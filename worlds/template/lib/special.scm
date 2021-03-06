;;----------------------------------------------------------------------------
;; Special -- one-off stuff that needs to be kern-loaded and doesn't really fit
;; anywhere else.
;;----------------------------------------------------------------------------

(kern-mk-sprite-set 'ss_special 32 32 3 3 0 0 "gfx/special.png")

(kern-mk-sprite 's_gold_skull ss_special 1 0 #f 0)
(kern-mk-sprite 's_power_core ss_special 1 1 #f 0)

;;----------------------------------------------------------------------------
;; Angriss Lair generator -- procedure invoked by a step trigger to create
;; Angriss's Lair. Should return true iff it triggers to remove the step
;; generator that invokes it.
;;----------------------------------------------------------------------------
(define angriss-lair-loc (list 'p_shard 89 70))
(define (mk-angriss-lair kbeing)
  (if (eqv? kbeing 
            (kern-get-player))
      (begin
        (kern-log-msg "You find the entrance to Angriss's Lair!")
        (kern-place-set-subplace p_angriss_lair 
                                 (eval-loc angriss-lair-loc))
        (kern-map-set-dirty)
        #t)
      #f))

;; ----------------------------------------------------------------------------
;; The Warritrix's note
;; ----------------------------------------------------------------------------
(mk-reusable-item 
 't_warritrix_orders "Military Orders" s_lexicon norm
 (lambda (klexicon kuser)
   (kern-ui-page-text
   "Orders to the Warritrix"
   "Ever faithful servant of Glasdrin,"
   "we suspect a coven of the Accursed are hiding"
   "in the deeps of the Lost Halls. Proceed at"
   "once to investigate. Leave no cavern"
   "unexplored.\n"
   "--Commander Jeffries\n"
   "P.S. These orders are to be destroyed."
   )))


;; Kraken lakes kraken trigger
(define (spawn-kraken-lakes-sea-serpent kbeing)
  (kern-log-msg "Your disturb something in the water...")
  (kern-obj-put-at (spawn-npc 'kraken 8) (mk-loc p_deepness 31 34))
  (kern-obj-put-at (spawn-npc 'kraken 8) (mk-loc p_deepness 32 35))
  (kern-obj-put-at (spawn-npc 'kraken 8) (mk-loc p_deepness 30 29))
  #t)

;; Locations referred to more than once
(define the-mans-hideout-loc (list 'p_shard 92 10))
(define lost-halls-loc (list 'p_shard 39 75))

;; Power core for voidship
(mk-quest-obj-type 't_power_core "ancient power core" s_power_core layer-item obj-ifc)

;; Luximene begins the game as a Lich King, when defeated he drops his skull,
;; which can be used with the Necromancer to summon his shade.
(mk-quest-obj-type 't_lich_skull "King Luximenes skull" s_gold_skull layer-item obj-ifc)

;; grow -- trigger hook fx to create items (eg, growing reagents, hence the name)
(define (grow-trig ktrig ktype-tag dice)
  (println "grow-trig")
  (println "  ktrig=" ktrig)
  (println "  ktype-tag=" ktype-tag)
  (println "  dice=" dice)
  (kern-obj-put-at (kern-mk-obj (eval ktype-tag) (kern-dice-roll 
                                       dice))
                   (kern-obj-get-location ktrig)))
