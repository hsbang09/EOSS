;; ***************************
;; CAPABILITY RULES
;; ***************************


(defrule CAPABILITIES-CHECK::passive-optical-instruments-cannot-measure-in-dark
    "Passive optical instruments cannot take their measurements in DD RAANs"
    (declare (salience 10))
    ?c <- (CAPABILITIES::can-measure (instrument ?ins) (orbit-RAAN DD) (can-take-measurements yes) )
    ?sub <- (DATABASE::Instrument (Name ?ins) (Illumination Passive) (Spectral-region ?sr) )
    (test (eq (sub-string 1 (min (str-length ?sr) 3) ?sr) "opt"))
    =>
    ;(printout t cannot-measure-in-dark " " ?ins " " ?sr crlf)
    (modify ?c (can-take-measurements no) (reason "Passive optical instruments cannot take their measurements in DD RAANs") )
    )

(defrule CAPABILITIES-CHECK::chemistry-instruments-prefer-PM-orbits-effect-on-science-tropo
    "Decrease sensitivity of chemistry instruments flying in AM orbits"
    (declare (salience 10))
    ?i <- (CAPABILITIES::Manifested-instrument (Name ?ins) (Concept ?c) (orbit-RAAN AM) (sensitivity-in-low-troposphere-PBL High) )
    (or 
        (test (neq (str-index "chemistry" ?c) FALSE))
        (test (neq (str-index "pollut" ?c) FALSE))
        )
    =>
    ;(printout t "Decrease sensitivity of chemistry instruments flying in AM orbits " ?ins " " crlf)
    (modify ?i (sensitivity-in-low-troposphere-PBL Low) ) 
    )

(defrule CAPABILITIES-CHECK::chemistry-instruments-prefer-PM-orbits-effect-on-science-strato
    "Decrease sensitivity of chemistry instruments flying in AM orbits"
    (declare (salience 10))
    ?i <- (CAPABILITIES::Manifested-instrument (Name ?ins) (Concept ?c) (orbit-RAAN AM) (sensitivity-in-upper-troposphere-and-stratosphere High) )
    (or 
        (test (neq (str-index "chemistry" ?c) FALSE))
        (test (neq (str-index "pollut" ?c) FALSE))
        )
    =>
    ;(printout t "Decrease sensitivity of chemistry instruments flying in AM orbits " ?ins " " crlf)
    (modify ?i (sensitivity-in-upper-troposphere-and-stratosphere Low) ) 
    )

(defrule CAPABILITIES-CHECK::hires-passive-optical-imagers-prefer-AM-orbits-effect-on-science
    "Passive optical all purpose hi res imagers such as Landsat or ASTER must fly in AM orbits to decrease cloudiness"
    (declare (salience 10))
    ?c <- (CAPABILITIES::can-measure (instrument ?ins) (orbit-RAAN PM) (can-take-measurements yes) )
    ?sub <- (DATABASE::Instrument (Name ?ins) (Illumination Passive) (Spectral-region ?sr) (Intent "High resolution optical imagers") )
    (test (eq (sub-string 1 (min (str-length ?sr) 3) ?sr) "opt"))
    =>
    ;(printout t cannot-measure-in-dark " " ?ins " " ?sr crlf)
    (modify ?c (can-take-measurements no) (reason "Passive optical all purpose hi res imagers such as Landsat or ASTER must fly in AM orbits to decrease cloudiness"))
    )

(defrule CAPABILITIES-CHECK::image-distortion-at-low-altitudes-in-side-looking-instruments
    "Passive optical instruments cannot take their measurements in DD RAANs"
    (declare (salience 10))
    ?c <- (CAPABILITIES::can-measure (instrument ?ins) (orbit-altitude# ?h&~nil&:(<= ?h 400)) (can-take-measurements yes) )
    ?sub <- (DATABASE::Instrument (Name ?ins) (Geometry slant) (Spectral-region ?sr))
    =>
    ;(printout t image-distortion " " ?ins crlf)
    (modify ?c (can-take-measurements no) (reason "Side-looking instruments suffer from image distortion at low altitudes") )
    )

(defrule CAPABILITIES-CHECK::two-lidars-at-same-frequency-cannot-work
    "Two lidars at same frequency can interfere with each other"
    (declare (salience 10))
    ?l1 <- (CAPABILITIES::can-measure (instrument ?ins1) (can-take-measurements yes) )
    ?l2 <- (CAPABILITIES::can-measure (instrument ?ins2&~?ins1) (can-take-measurements yes) )
    ?sub1 <- (DATABASE::Instrument (Name ?ins1) (Intent "Laser altimeters") (spectral-bands $?sr))
    ?sub2 <- (DATABASE::Instrument (Name ?ins2) (Intent "Laser altimeters") (spectral-bands $?sr))
    
    =>
    ;(printout t two-lidars-same-freq " " ?ins1 " " ?ins2 " " $?sr crlf)
    (modify ?l1 (can-take-measurements no) (reason "Two lidars at same frequency can interfere with each other") )
    (modify ?l2 (can-take-measurements no) (reason "Two lidars at same frequency can interfere with each other") )
    )

(defrule CAPABILITIES-CHECK::resource-limitations-datarate
    (declare (salience 10))
    ?l1 <- (CAPABILITIES::can-measure (instrument ?ins1) (in-orbit ?miss) (can-take-measurements yes) (data-rate-duty-cycle# nil) )
    ?i1 <- (CAPABILITIES::Manifested-instrument (Name ?ins1&~nil) (flies-in ?miss&~nil) )
    ?sub <- (MANIFEST::Mission  (Name ?miss) (sat-data-rate-per-orbit# ?rbo&~nil) )
    =>
    (bind ?dc (min 1.0 (/ (* 1 7 60 500 (/ 1 8192)) ?rbo))); you get 1 7' pass at 500Mbps max
    (modify ?l1 (data-rate-duty-cycle# ?dc) (reason "Cumulative spacecraft data rate cannot be downloaded to ground stations") )
	(modify ?i1 (data-rate-duty-cycle# ?dc) )
    ;(if (< ?dc 1.0) then (printout t "resource-limitations-datarate " ?ins1 " dc = " ?dc crlf))
    )

(defrule CAPABILITIES-CHECK::resource-limitations-power
    (declare (salience 10))
    ?l1 <- (CAPABILITIES::can-measure (instrument ?ins1) (in-orbit ?miss) (can-take-measurements yes) (power-duty-cycle# nil) )
	?i1 <- (CAPABILITIES::Manifested-instrument (Name ?ins1&~nil) (flies-in ?miss&~nil) )
    ?sub <- (MANIFEST::Mission  (satellite-BOL-power# ?pow&~nil) )
    =>
    (bind ?dc (min 1.0 (/ 10000 ?pow)))
    (modify ?l1 (power-duty-cycle# ?dc) (reason "Cumulative spacecraft power exceeds 10kW") )
	(modify ?i1 (power-duty-cycle# ?dc) )
    ;(if (< ?dc 1.0) then (printout t "resource-limitations-power " ?ins1 " dc = " ?dc crlf))
    )
        

(defrule CAPABILITIES-CHECK::cryospheric-instruments-want-polar-orbits
    "If a cryospheric instrument is flown on a non polar orbit then 
    it loses coverage of the polar regions"
    
    (declare (salience 10))
    ?c <- (CAPABILITIES::can-measure (instrument ?ins) (orbit-inclination ?inc&~polar) (can-take-measurements yes) )
    ?sub <- (DATABASE::Instrument (Name ?ins) (Concept ?co) )
    (test (neq (str-index "Primary application: ice" ?co) FALSE))
    =>
    ;(printout t cryospheric-instruments-want-polar-orbits crlf)
    (modify ?c (can-take-measurements no) (reason "If a cryospheric instrument is flown on a non polar orbit then 
    it loses coverage of the polar regions") )
    )



