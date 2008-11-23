;;----------------------------------------------------
;; this is a collection place for updates to quests
;;
		
;;---------------
;; whereami

(define (quest-whereami-update)
	(let* ((quest (quest-data-get 'questentry-whereami))
			(quest-tbl (car (qst-payload quest)))
			(qp-shard (tbl-get quest-tbl 'shard))
			(qp-wanderer (tbl-get quest-tbl 'wanderer)))

		(qst-set-descr! quest
		
(if (not (null? (tbl-get quest-tbl 'nossifer)))

			(kern-ui-paginate-text
			"You have found yourself on the Shard, a small fragment of a world, that floats surrounded by a great void."
			""
			"The demon lord Nossifer arranged for your arrival, to set in motion events that would allow his own passage to the Shard."
			""
			"Now the Demon Gate is open, and the only thing left in Nossifer's way is you..."
		)
		
		 (append
;;1 where
(cond ((null? qp-shard)
		(kern-ui-paginate-text
			"You have found yourself in a world you have no knowledge of, with barest impressions of what might have gone before."
			""
		))
	((equal? 1 qp-shard)
		(kern-ui-paginate-text
			"You have found yourself in a world you have no knowledge of. The inhabitants refer to it as the Shard."
			""
		))
	(#t (kern-ui-paginate-text
			"You have found yourself on the Shard, a small fragment of a world, that floats surrounded by a great void."
			""
		))
	)


;; how
(if (and (null? qp-wanderer) (null? qp-shard))
		(kern-ui-paginate-text "Where are you?")
		nil
	)
			
(cond ((null? qp-wanderer)
		(kern-ui-paginate-text
			"How and why are you here?"
			"And what are you going to do now?"
		))
	((equal? 1 qp-wanderer)
		(kern-ui-paginate-text
			"Others like you have in the past been found stumbling into this world. The inhabitants know you as 'Wanderers'."
			""
			"Now you are here, what are you going to do?"
		))
	(#t (kern-ui-paginate-text
			"Wanderers like yourself, who are occasionally stumbled upon this world, have in the past been responsible for great deeds."
			""
			"How will you make your place?"
		))
	)

				)
			)
		)
	))

;;-----------------------
;; calltoarms

(define (quest-calltoarms-update)
	(let* ((quest (quest-data-get 'questentry-calltoarms))
			(quest-tbl (car (qst-payload quest)))
			(header (kern-ui-paginate-text
					"You have recieved an urgent message to contact someone called the Enchanter as soon as possible."
					"")))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond ((tbl-flag? 'done)
		(kern-ui-paginate-text
			"You have allied yourself with the Enchanter, one of the Wise who watch over the shard."
		))
	((tbl-flag? 'talked)
		(append header
		(kern-ui-paginate-text
			"You have met with the Enchanter, but you and he did not come to any agreement."
		)))
	((tbl-flag? 'tower)
		(append header
		(kern-ui-paginate-text
			"You have found the Enchanter's Tower in the Fens. However, getting inside could be more difficult than reaching it."
		)))
	((tbl-flag? 'directions)
		(append header
		(kern-ui-paginate-text
			"The Enchanter's Tower may be found in the Fens, a swampland north of the town of Trigrave, in the western part of the Shard."
		)))
	(#t
		(append header
		(kern-ui-paginate-text
			"The message suggests that you ask the caretaker of the clearing that you arrived in for directions."
		)))
)

		)
	))

;; give some xp for reaching the tower
(define (quest-calltoarms-tower kplace kplayer)
	(quest-data-update-with 'questentry-calltoarms 'tower 1 (quest-notify (grant-xp-fn 5)))
	)

;;-----------------------
;; thiefrune

;; TODO: make the theft appear not to happen until the player is on the scene, by altering convs based on quest status

(define (quest-thiefrune-update)
	(let* ((quest (quest-data-get 'questentry-thiefrune))
			(quest-tbl (car (qst-payload quest)))
			(header (kern-ui-paginate-text
					"The Enchanter has asked you to investigate a theft from his tower."
					"")))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond ((tbl-flag? 'recovered) 
		(append header
		(kern-ui-paginate-text
			"You have tracked down the thief and retrieved a rune belonging to the Enchanter."
		)))
	((tbl-flag? 'talked)
		(append header
		(kern-ui-paginate-text
			"The culprit, Mouse, seems to be willing to negotiate."
		)))
	((tbl-flag? 'den5)
		(append header
		(kern-ui-paginate-text
			"You have found the thief's hideout in Bole, and breached the defensive upper levels."
		)))
	((tbl-flag? 'den4)
		(append header
		(kern-ui-paginate-text
			"You have found the thief's hideout in Bole, and have passed three levels of traps."
		)))
	((tbl-flag? 'den3)
		(append header
		(kern-ui-paginate-text
			"You have found the thief's hideout in Bole, and have passed two levels of traps."
		)))
	((tbl-flag? 'den2)
		(append header
		(kern-ui-paginate-text
			"You have found the thief's hideout in Bole, but have only passed the first level."
		)))
	((tbl-flag? 'den1)
		(append header
		(kern-ui-paginate-text
			"You have found the thief's hideout in Bole, but have yet to breach its defenses."
		)))
	((tbl-flag? 'bole)
		(append header
		(kern-ui-paginate-text
			"The ^c+mthief^c- has been seen heading northeast through the Great Forest. Bole would be the most likely place to look."
		)))
	((tbl-flag? 'tower)
		(append header
		(kern-ui-paginate-text
			"The ^c+mthief^c- has been seen heading east through the mountain passes. The Green Tower would be the best place to start looking."
		)))
	(#t
		(append header
		(kern-ui-paginate-text
			"The ^c+mthief^c- has been tracked as far as Trigrave. The townsfolk there may be able to give you further information."
		)))
)

		)
	))

;; give some xp for getting through the dungeon
(define (quest-thiefrune-den1 kplace kplayer)
	(quest-data-update 'questentry-thiefrune 'tower 1)
	(quest-data-update 'questentry-thiefrune 'bole 1)
	(quest-data-update-with 'questentry-thiefrune 'den1 1 (quest-notify (grant-party-xp-fn 10)))
	)
(define (quest-thiefrune-den2 kplace kplayer)
	(quest-data-update-with 'questentry-thiefrune 'den2 1 (quest-notify (grant-party-xp-fn 10)))
	)
(define (quest-thiefrune-den3 kplace kplayer)
	(quest-data-update-with 'questentry-thiefrune 'den3 1 (quest-notify (grant-party-xp-fn 10)))
	)
(define (quest-thiefrune-den4 kplace kplayer)
	(quest-data-update-with 'questentry-thiefrune 'den4 1 (quest-notify (grant-party-xp-fn 10)))
	)
(define (quest-thiefrune-den5 kplace kplayer)
	(quest-data-update-with 'questentry-thiefrune 'den5 1 (quest-notify (grant-party-xp-fn 10)))
	)


;;-----------------------
;; runeinfo

;; TODO: runes are unidentified until you check in with abe?

(define (quest-runeinfo-update)
	(let* ((quest (quest-data-get 'questentry-runeinfo))
			(quest-tbl (car (qst-payload quest)))
			(header (kern-ui-paginate-text
				"The stolen rune that you recovered must have great significance to prompt it's theft. The Enchanter has given you the task of seeking out this reason."
				""
				)))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"The rune you carry is one of the Keys to the Demon Gate. The gate itself lies somewhere in the north. It was sealed by the wise in ages past, and the Keys were scattered and hidden."
		))
	((tbl-flag? 'gate)
		(append header
		(kern-ui-paginate-text
			"The runes are also known as the Keys to the Demon Gate. The gate itself lies somewhere in the north. It was sealed by the wise in ages past, and the Keys were scattered and hidden."
		)))
	((tbl-flag? 'keys)
		(append header
		(kern-ui-paginate-text
			"The runes are also known as the Keys to the Demon Gate. What that means remains unknown."
		)))
	((tbl-flag? 'abe)
		(append header
		(kern-ui-paginate-text
			"The Alchemist has advised you that ^c+mAbe^c-, at the Green Tower, has studied the nature of the runes."
		)))
	(#t
		(append header
		(kern-ui-paginate-text
			"He suggests that you start with the ^c+mAlchemist^c-, who may be found at Oparine."
		)))
)

		)
	))


;;-----------------------
;; dragon blood

(define (quest-dragon-update quest)
	(let* ((quest-tbl (car (qst-payload quest)))
			(header (kern-ui-paginate-text
				"The Alchemist has offered to trade you information on the wherabouts of a Rune, in exchange for the blood of a dragon."
				)))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"The Alchemist has traded you information on the wherabouts of a Rune, in exchange for the blood of a dragon."
		))
	((in-inventory? (car (kern-party-get-members (kern-get-player))) t_dragons_blood 1)
		(append header
		(kern-ui-paginate-text
			""
			"You have a vial of dragon's blood in your possession."
		)))
	((tbl-flag? 'sea)
		(append header
		(kern-ui-paginate-text
			""
			"He suggests that the Fire Sea may be the best place to seek them out."
		)))
	(#t
		header
		)
)

		)
	))

;;-----------------------
;; deeps rune

(define (quest-rune-p-update)
	(let* ((quest (quest-data-get 'questentry-rune-p))
			(quest-tbl (car (qst-payload quest))))
		(define (tbl-flag? tag) (not (null? (tbl-get quest-tbl tag))))
		(qst-set-descr! quest
		
(cond 
	((tbl-flag? 'done)
		(kern-ui-paginate-text
			"A rune was found in the depths of Kurpolis."
		))
	(#t
		(kern-ui-paginate-text
			"The Alchemist provided you with information on a rune buried in the deeps of Kurpolis:"
			""
		   "\"The paladins have built several fortifications in the deeps of Kurpolis. One of the runes was buried in the foundations of the deepest fort.\""
		   ""
	   		"\"A pick and shovel may be enough to get it out again, but it might be difficult with a dozen paladins breathing down your neck.\""
		))
)

		)
	))
	