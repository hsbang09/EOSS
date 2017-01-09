;; *********************************
;; Mission - mission inheritance
;; *********************************



;; **********************************
;; Mission ==> Instrument inheritance (control)
;; **********************************

(defrule MANIFEST::assert-manifested-instruments
    (declare (salience 20))

    (MANIFEST::Mission (Name ?name) (mission-architecture ?arch) (num-of-planes# ?nplanes) (num-of-sats-per-plane# ?nsats) (orbit-altitude# ?h) (orbit-inclination ?inc) (instruments $?list-of-instruments))
    
       =>
    (foreach ?x $?list-of-instruments (assert (CAPABILITIES::Manifested-instrument (Name ?x) (flies-in ?name)  (mission-architecture ?arch) (num-of-planes# ?nplanes) (num-of-sats-per-plane# ?nsats) (num-of-planes# ?nplanes) (orbit-altitude# ?h) (orbit-inclination ?inc))))
    ;(assert (SYNERGIES::cross-registered-instruments (instruments ?list-of-instruments) (degree-of-cross-registration spacecraft)))
    )


;; **********************************
;; Mission ==> Instrument inheritance (calculated attributes)
;; **********************************

(defrule MANIFEST::get-instrument-spectral-bands-from-database
    ?instr <- (CAPABILITIES::Manifested-instrument (Name ?name) (spectral-bands $?sb&:(< (length$ $?sb) 1)))
    (DATABASE::Instrument (Name ?name) (spectral-bands $?sb2&:(>= (length$ $?sb2) 1)))
    =>
    (modify ?instr (spectral-bands $?sb2))
    )


(defrule MANIFEST::get-instrument-revisit-times-from-database
    ?instr <- (CAPABILITIES::Manifested-instrument (Name ?name) (Field-of-view# ?fov) (mission-architecture ?arch) (num-of-planes# ?nplanes) (num-of-sats-per-plane# ?nsats) (num-of-planes# ?nplanes) (orbit-altitude# ?h) (orbit-inclination ?inc))
    (DATABASE::Revisit-time-of (mission-architecture ?arch) (num-of-sats-per-plane# ?nsats) (num-of-planes# ?nplanes) (orbit-altitude# ?h) (orbit-inclination ?inc) (instrument-field-of-view# ?fov) (avg-revisit-time-global# ?revtime-global) (avg-revisit-time-tropics# ?revtime-tropics) (avg-revisit-time-northern-hemisphere# ?revtime-NH) (avg-revisit-time-southern-hemisphere# ?revtime-SH) (avg-revisit-time-cold-regions# ?revtime-cold) (avg-revisit-time-US# ?revtime-US))
    =>
    (modify ?instr (avg-revisit-time-global# ?revtime-global) (avg-revisit-time-tropics# ?revtime-tropics) (avg-revisit-time-northern-hemisphere# ?revtime-NH) (avg-revisit-time-southern-hemisphere# ?revtime-SH) (avg-revisit-time-cold-regions# ?revtime-cold) (avg-revisit-time-US# ?revtime-US))
    )

(defrule MANIFEST::compute-hsr-cross-track-from-instrument-and-orbit 
    "Compute horizontal spatial resolution from instrument angular resolution 
    and orbit altitude"
    ?instr <- (CAPABILITIES::Manifested-instrument (orbit-altitude# ?h&~nil) (Angular-resolution-azimuth# ?ara&:(neq ?ara nil)) (Horizontal-Spatial-Resolution-Cross-track# nil))
    =>
    (modify ?instr (Horizontal-Spatial-Resolution-Cross-track# (* 1000 ?h (* ?ara (/ (pi) 180)) )) )
    )

(defrule MANIFEST::compute-hsr-along-track-from-instrument-and-orbit 
    "Compute horizontal spatial resolution from instrument angular resolution 
    and orbit altitude"
    ?instr <- (CAPABILITIES::Manifested-instrument (orbit-altitude# ?h&~nil) (Angular-resolution-elevation# ?are&:(neq ?are nil)) (Horizontal-Spatial-Resolution-Along-track# nil))
    =>
    (modify ?instr (Horizontal-Spatial-Resolution-Along-track# (* 1000 ?h (* ?are (/ (pi) 180)) )) )
    )

(defrule MANIFEST::compute-hsr-from-instrument-and-orbit 
    "Compute horizontal spatial resolution hsr and hsr2 from instrument angular resolution 
    and orbit altitude"
    ?instr <- (CAPABILITIES::Manifested-instrument (orbit-altitude# ?h&~nil) (Angular-resolution# ?are&:(neq ?are nil)) (Horizontal-Spatial-Resolution# nil))
    =>
    (modify ?instr (Horizontal-Spatial-Resolution# (* 1000 ?h (* ?are (/ (pi) 180)) )))
    )

(defrule MANIFEST::fill-in-hsr-from-directional-hsrs
    "If along-track and cross-track spatial resolutions are known and identical, then 
    horizontal spatial resolution is equal to them"
    (declare (salience -2))
    ?instr <- (CAPABILITIES::Manifested-instrument (Horizontal-Spatial-Resolution-Cross-track# ?cr&~nil)
        (Horizontal-Spatial-Resolution-Along-track# ?al&~nil&?cr) (Horizontal-Spatial-Resolution# nil))
    =>
    (modify ?instr (Horizontal-Spatial-Resolution# ?cr))
    )


(defrule MANIFEST::compute-swath-from-instrument-and-orbit 
    "Compute swath from instrument field of regard 
    and orbit altitude"
    
    ?instr <- (CAPABILITIES::Manifested-instrument (orbit-altitude# ?h&~nil) 
        (Field-of-regard# ?for&~nil) (Swath# nil))
    =>
    (bind ?sw (* 2 ?h (matlabf tan (* ?for (/ (pi) 360) )))) 
    (modify ?instr (Swath# ?sw) ) 
    )

(defrule MANIFEST::compute-fov-from-angular-res-and-npixels-square 
    "Compute field of view in degrees from angular resolution (IFOV)
    and number of pixels for a square image"
    (declare (salience 4))
    ?instr <- (CAPABILITIES::Manifested-instrument  (Field-of-view# nil) 
        (Angular-resolution-azimuth# nil) (Angular-resolution-elevation# nil)
        (Angular-resolution# ?ifov&~nil) (num-pixels# ?npix&~nil) ) ; only square images
    =>
	(bind ?fov (* ?ifov ?npix)); 
    (modify ?instr (Field-of-view# ?fov))
    )

(defrule MANIFEST::compute-fov-from-angular-res-and-npixels-elevation 
    "Compute field of view in degrees from angular resolution (IFOV)
    and number of pixels for the elevation direction in a rectangular image"
    (declare (salience 4))
    ?instr <- (CAPABILITIES::Manifested-instrument  (Field-of-view-elevation# nil) 
       (Angular-resolution-elevation# ?ara&~nil) (num-pixels-along-track# ?npix&~nil) )
    =>
	(bind ?fov (* ?ara ?npix)); 
    (modify ?instr (Field-of-view-elevation# ?fov))
    )

(defrule MANIFEST::compute-fov-from-angular-res-and-npixels-azimuth 
    "Compute field of view in degrees from angular resolution (IFOV)
    and number of pixels for the azimuth direction in a rectangular image"
    (declare (salience 4))
    ?instr <- (CAPABILITIES::Manifested-instrument  (Field-of-view-azimuth# nil) 
       (Angular-resolution-azimuth# ?ara&~nil) (num-pixels-cross-track# ?npix&~nil) )
    =>
	(bind ?fov (* ?ara ?npix)); 
    (modify ?instr (Field-of-view-elevation# ?fov))
    )

(defrule MANIFEST::compute-for-from-fov-square 
    "Compute field of regard in degrees from field of view
    and off-axis scanning capability"
    (declare (salience 2))
    ?instr <- (CAPABILITIES::Manifested-instrument  (Field-of-regard# nil) 
        (Field-of-view# ?fov&~nil) (off-axis-angle-plus-minus# ?off-axis) ) ; only square images
    =>
    
    ; if no scanning capability then FOR = FOV, else take into account scanning
    (if (neq ?off-axis nil) then
        (bind ?for (+ ?fov (* 2 ?off-axis)))
        else
        (bind ?for  ?fov); 
        )
	
    (modify ?instr (Field-of-regard# ?for))
    )

(defrule MANIFEST::compute-revisit-time
    
    ?m <- (REQUIREMENTS::Measurement (taken-by ?ins) (avg-revisit-time-global# nil)
         (avg-revisit-time-tropics# nil) (avg-revisit-time-northern-hemisphere# nil)
        (avg-revisit-time-southern-hemisphere# nil) (avg-revisit-time-cold-regions# nil) 
        (avg-revisit-time-US# nil) )
    
    (CAPABILITIES::Manifested-instrument (Name ?ins) (num-of-planes# ?np) (num-of-sats-per-plane# ?ns)
         (orbit-altitude# ?h) (orbit-inclination ?inc) (Field-of-view# ?fov) )
    
    (DATABASE::Revisit-time-of (num-of-planes# ?np) (num-of-sats-per-plane# ?ns) (orbit-altitude# ?h)
         (orbit-inclination ?inc) (instrument-field-of-view# ?fov) 
         (avg-revisit-time-global# ?glob) (avg-revisit-time-tropics# ?trop)
         (avg-revisit-time-northern-hemisphere# ?nh)(avg-revisit-time-southern-hemisphere# ?sh) 
        (avg-revisit-time-cold-regions# ?cold) (avg-revisit-time-US# ?us)) 
    => 
    (printout t penis clrf)
    (modify ?m (avg-revisit-time-global# ?glob) (avg-revisit-time-tropics# ?trop) (avg-revisit-time-northern-hemisphere# ?nh)
        (avg-revisit-time-southern-hemisphere# ?sh) (avg-revisit-time-cold-regions# ?cold) (avg-revisit-time-US# ?us))
    )



;; ********************************** 
;; **********************************
;; Cloud radars (e.g. Cloudsat, EarthCARE, ACE_RAD, TRMM PR)
;; **********************************
;; **********************************

(defrule MANIFEST::compute-cloud-radar-properties-vertical-spatial-resolution
    ?instr <- (CAPABILITIES::Manifested-instrument (Intent "Cloud profile and rain radars") 
        (bandwidth# ?B&~nil) (off-axis-angle-plus-minus# ?theta&~nil) (Vertical-Spatial-Resolution# nil))
    =>
    (bind ?range-res (/ 3e8 (* 2 ?B (sin ?theta))))
    (modify ?instr (Vertical-Spatial-Resolution# ?range-res))
    )

(defrule MANIFEST::compute-cloud-radar-properties-horizontal-spatial-resolution
    ?instr <- (CAPABILITIES::Manifested-instrument  (Intent "Cloud profile and rain radars")
         (frequency# ?f&~nil) (dimension-x# ?D) (orbit-altitude# ?h&~nil) (Horizontal-Spatial-Resolution# nil))
    =>
    (bind ?hsr (* (/ 3e8 (* ?D ?f)) ?h)); hsr = lambda/D*h, lambda=c/f
    (modify ?instr (Horizontal-Spatial-Resolution# ?hsr))
    )

(defrule MANIFEST::compute-cloud-radar-properties-swath
    ?instr <- (CAPABILITIES::Manifested-instrument (Intent "Cloud profile and rain radars") 
        (off-axis-angle-plus-minus# ?theta&~nil) (scanning conical) (orbit-altitude# ?h&~nil) (Swath# nil))
    =>
    (bind ?sw (* 2 ?h (matlabf tan (* ?theta (/ (pi) 180)) ))); hsr = lambda/D*h, lambda=c/f
    (modify ?instr (Swath# ?sw))
    )

;; ********************************** 
;; **********************************
;; Passive microwave imaging radiometers (e.g. SMAP)
;; **********************************
;; **********************************


; *** LIDARS



;; probert-jones equation pr = pt*g^2*theta^2*pulse width*pi^3*k^2*L*Z/1024ln(2)/lambda^2/R^2


;; SYNERGIES:: dual frequency ==> Ka improves sensitiviyty in rain

;; SYNERGIES:: dual polarization allows particle shape and phase transition

;; SYNERGIES:: Doppler capability allows better accuracy cloud type, air motion, particle size

;; **********************************
;; Instrument ==> Instrument (calculated attributes) (Angular-resolution-azimuth# nil) (Angular-resolution-elevation# nil)
;; **********************************

;; for a sounder, vertical resolution is related to number of channels (although resolution can be traded for accuracy)



;; **********************************
;; Instrument ==> Measurement inheritance
;; **********************************
;; See excel, plus:



;; ****************
;; Rules for synthesis of alternative mission architectures trading accuracy for spatial resolution,
;; temporal resolution, or vertical spatial resolution. All these missions will be declared, and
;; rules can be added so that only one of each can be selected
