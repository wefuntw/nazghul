(define humanoid-slots (list slot-helm
                             slot-amulet
                             slot-weapon-or-shield
                             slot-weapon-or-shield
                             slot-armor
                             slot-boot
                             slot-ring
                             slot-ring))

(define troll-speed         speed-human)
(define troll-base-hp       20)
(define troll-critical-hp   10)
(define troll-melee-weapon  t_hands)
(define troll-ranged-weapon t_thrown_boulder)
(define troll-ripup-boulder-ap (* 2 troll-speed))


(kern-mk-species 'sp_human         ; tag
                 "human"           ; name
                 10 10 10          ; str/int/dex
                 speed-human       ; speed
                 13                ; vision radius
                 mmode-walk        ; passability
                 20                ; base hp
                 2                 ; hp per level
                 10                ; base mp
                 2                 ; mp per level
                 s_corpse          ; sleep sprite
                 t_hands           ; natural (unarmed) weapon
                 #t                ; visible
                 sound-damage      ; damage sound
                 sound-walking     ; walking sound
                 nil               ; on-death closure
                 8                 ; xpval
                 humanoid-slots    ; slots
                 nil               ; native spells
                 )

(kern-mk-species 'sp_ghast         ; tag
                 "ghast"           ; name
                 10 10 10          ; str/int/dex
                 speed-human       ; speed
                 8                 ; vision radius
                 mmode-phase       ; passability
                 10 5              ; hp mod/mult
                 10 10             ; mp mod/mult
                 s_corpse          ; sleep sprite
                 t_hands           ; natural (unarmed) weapon
                 #f                ; visible
                 sound-damage      ; damage sound
                 nil               ; walking sound
                 nil               ; on-death closure
                 8                 ; xpval
                 humanoid-slots    ; slots
                 nil               ; native spells FIXME!!!!
                 )

(kern-mk-species 'sp_goblin        ; tag
                 "goblin"          ; name
                 12  8 12          ; str/int/dex
                 speed-human       ; speed
                 14                ; vision radius
                 mmode-walk        ; passability
                 15 2              ; hp mod/mult
                 10 10             ; mp mod/mult
                 s_corpse          ; sleep sprite
                 t_hands           ; natural (unarmed) weapon
                 #t                ; visible
                 sound-damage      ; damage sound
                 sound-walking     ; walking sound
                 nil               ; on-death closure
                 8                 ; xpval
                 humanoid-slots    ; slots
                 nil               ; native spells
                 )

(kern-mk-species 'sp_insect        ; tag
                 "insect swarm"    ; name
                 1  1  18          ; str/int/dex
                 speed-insect      ; speed
                 4                 ; vision radius
                 mmode-hover       ; passability
                 3 1               ; hp mod/mult
                 0 0               ; mp mod/mult
                 nil               ; sleep sprite
                 t_stinger         ; natural (unarmed) weapon
                 #t                ; visible
                 sound-damage      ; damage sound
                 nil               ; walking sound
                 nil               ; on-death closure
                 4                 ; xpval
                 nil               ; slots
                 nil               ; native spells
                 )

(kern-mk-species 'sp_yellow_slime      ; tag
                 "yellow slime"        ; name
                 4 4 4                 ; str/int/dex
                 speed-yellow-slime    ; speed
                 6                     ; vision radius
                 mmode-walk            ; pmask
                 15 1                  ; hp mod/mult
                 20 20                 ; mp mod/mult
                 s_yellow_slime_asleep ; sleep sprite
                 t_acid_spray          ; unarmed weapon
                 #t                    ; visible
                 sound-damage          ; damage sound
                 sound-squishing       ; walking sound
                 nil               ; on-death closure
                 8                     ; xpval
                 nil                   ; slots
                 ;; native spells
                 (list 
                  "KXN"
                  )
                 )

(kern-mk-species 'sp_green_slime       ; tag
                 "green slime"         ; name
                 2 2 2                 ; str/int/dex
                 speed-yellow-slime    ; speed
                 5                     ; vision radius
                 mmode-walk            ; pmask
                 10 1                  ; hp mod/mult
                 0 0                   ; mp mod/mult
                 s_slime_asleep        ; sleep sprite
                 t_acid_spray          ; unarmed weapon
                 #t                    ; visible
                 sound-damage          ; damage sound
                 sound-squishing       ; walking sound
                 nil                   ; on-death closure
                 4                     ; xpval
                 nil                   ; slots
                 nil                   ; native spells
                 )

(kern-mk-species 'sp_skeleton      ; tag
                 "skeleton"        ; name
                 12 8 12          ; str/int/dex
                 speed-human       ; speed
                 6                 ; vision radius
                 mmode-walk        ; passability
                 22 2              ; hp mod/mult
                 0  0              ; mp mod/mult
                 s_corpse          ; sleep sprite
                 t_hands           ; natural (unarmed) weapon
                 #t                ; visible
                 sound-damage      ; damage sound
                 sound-walking     ; walking sound
                 nil               ; on-death closure
                 8                 ; xpval
                 humanoid-slots    ; slots
                 nil               ; native spells
                 )

(kern-mk-species 'sp_snake         ; tag
                 "snake"           ; name
                 2 2 14             ; str/int/dex
                 speed-human       ; speed
                 6                 ; vision radius
                 mmode-walk        ; passability
                 5 1               ; hp mod/mult
                 20 10             ; mp mod/mult
                 nil               ; sleep sprite
                 t_fangs           ; natural (unarmed) weapon
                 #t                ; visible
                 sound-damage      ; damage sound
                 sound-walking     ; walking sound
                 nil               ; on-death closure
                 4                 ; xpval
                 nil               ; slots
                 nil               ; native spells FIXME!!!!
                 )

(kern-mk-species 'sp_spider      ;; tag: script variable name
                 "spider"        ;; name: used to display name in the UI
                 12             ;; strength: limits armament weight
                 6              ;; intelligence: (just reported in stats)
                 14              ;; dexterity: used to avoid traps on chests
                 speed-insect   ;; speed: action points per turn
                 10              ;; vision radius: in tiles
                 mmode-walk     ;; movement mode
                 10             ;; base hp: hit points at level zero
                 4              ;; hp multiplier: extra hp per level
                 0              ;; base mp: mana points at level zero
                 0              ;; mp multiplier: extra mana points per level
                 s_corpse       ;; sleep sprite
                 t_hands        ;; natural weapon: used when unarmed
                 #t             ;; visible: can be seen
                 sound-damage   ;; damage sound
                 sound-walking  ;; walking sound
                 'spider-killed ;; on-death
                 4              ;; xpval
                 humanoid-slots ;; slots: hands
                 nil            ;; native spells: currently unused
                 )

(kern-mk-species 'sp_queen_spider ;; tag: script variable name
                 "queen spider"   ;; name: used to display name in the UI
                 18             ;; strength: limits armament weight
                 6              ;; intelligence: (just reported in stats)
                 12             ;; dexterity: used to avoid traps on chests
                 speed-human    ;; speed: action points per turn
                 10             ;; vision radius: in tiles
                 mmode-walk     ;; movement mode
                 30             ;; base hp: hit points at level zero
                 4              ;; hp multiplier: extra hp per level
                 0              ;; base mp: mana points at level zero
                 0              ;; mp multiplier: extra mana points per level
                 s_corpse       ;; sleep sprite
                 t_hands        ;; natural weapon: used when unarmed
                 #t             ;; visible: can be seen
                 sound-damage   ;; damage sound
                 sound-walking  ;; walking sound
                 'queen-spider-killed ;; on-death closure
                 16             ;; xpval
                 humanoid-slots ;; slots: hands
                 nil            ;; native spells: currently unused
                 )

(kern-mk-species 'sp_troll      ;; tag: script variable name
                 "troll"        ;; name: used to display name in the UI
                 14             ;; strength: limits armament weight
                 6              ;; intelligence: (just reported in stats)
                 12             ;; dexterity: used to avoid traps on chests
                 troll-speed    ;; speed: action points per turn
                 10             ;; vision radius: in tiles
                 mmode-walk     ;; movement mode
                 troll-base-hp  ;; base hp: hit points at level zero
                 2              ;; hp multiplier: extra hp per level
                 0              ;; base mp: mana points at level zero
                 0              ;; mp multiplier: extra mana points per level
                 s_troll_corpse ;; sleep sprite
                 t_hands        ;; natural weapon: used when unarmed
                 #t             ;; visible: can be seen
                 sound-damage   ;; damage sound
                 sound-walking  ;; walking sound
                 nil            ;; on-death closure
                 12             ;; xpval
                 humanoid-slots ;; slots: hands
                 nil            ;; native spells: currently unused
                 )

;;----------------------------------------------------------------------------
;; This list of the undead species is used by spells which affect the undead.
;;----------------------------------------------------------------------------
(define undead-species-tags
  (list sp_skeleton))

(define (species-is-undead? species)
  (foldr (lambda (x undead) (or x (eqv? species undead)))
         #f undead-species-tags))

;; ----------------------------------------------------------------------------
;; Species immunities
;; ----------------------------------------------------------------------------
(define (species-is-immune-to-ensnare? species)
  (or (eqv? species sp_spider)
      (eqv? species sp_queen_spider)))

(define (species-is-immune-to-paralyze? species)
  #f)

;;----------------------------------------------------------------------------
;; Species Queries
;;----------------------------------------------------------------------------
(define (obj-is-green-slime? kobj)
  (and (obj-is-char? kobj)
       (eqv? (kern-char-get-species kobj) sp_green_slime)))

(define (char-is-spider? kchar)
  (eqv? (kern-char-get-species kchar) sp_spider))

(define (is-spider? kchar)
  (let ((species (kern-char-get-species kchar)))
    (or (eqv? species sp_spider)
        (eqv? species sp_queen_spider))))

(define (char-is-troll? kchar)
  (eqv? (kern-char-get-species kchar) sp_troll))

;;----------------------------------------------------------------------------
;; Trigger to generate slimes
;;----------------------------------------------------------------------------
(define (slime-gen-target-loc kgen)
  (let* ((kplace (loc-place (kern-obj-get-location kgen)))
        (gob (gob-data (kobj-gob kgen)))
        (x (car gob))
        (y (cadr gob)))
    (display "gob:")(display gob)(newline)
    (mk-loc kplace x y)))

(define (slime-generator-step kgen kstepper)
  (define (mkslime)
    (kern-log-msg "A slime emerges from the ooze!")
    (mk-green-slime))
  (let* ((kplace (loc-place (kern-obj-get-location kstepper)))
         (slimes (filter obj-is-green-slime? (kern-place-get-objects kplace))))
    (if (< (length slimes) 1)
        (psummon (slime-gen-target-loc kgen)
                 mkslime
                 (kern-dice-roll "1d2")))))

(define slime-generator-ifc
  (ifc '()
       (method 'step slime-generator-step)))

(mk-obj-type 't_slime_generator nil nil layer-mechanism slime-generator-ifc)

(define (mk-slime-generator x y)
  (kern-obj-set-visible (bind (kern-mk-obj t_slime_generator 1)
                              (list x y))
                        #f))
