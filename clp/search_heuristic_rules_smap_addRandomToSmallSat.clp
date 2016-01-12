(defrule SEARCH-HEURISTICS::add-random-instrument-to-small-sat
    "This heuristic finds an existing small satellite and adds a random instrument" 
    ?arch0 <- (MANIFEST::ARCHITECTURE (bitString ?orig) (num-sats-per-plane ?ns) (improve addRandomToSmallSat))
    =>
	;(printout t remove-existing-interference crlf)
    (bind ?N 1)
    (for (bind ?i 0) (< ?i ?N) (++ ?i) 
		(bind ?arch ((new rbsa.eoss.Architecture ?orig ?ns) addRandomToSmallSat))
    	(assert-string (?arch toFactString)))
	(modify ?arch0 (improve no))
    )
	 
(deffacts DATABASE::add-random-instrument-to-small-sat-list-of-improve-heuristics
(SEARCH-HEURISTICS::improve-heuristic (id addRandomToSmallSat))
)

