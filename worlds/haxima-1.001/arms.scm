;;----------------------------------------------------------------------------
;; arms.scm - armament types
;;
;; The basic primitive for creating an armament type is the kern-mk-arms-type
;; procedure. This procedure takes a lot of parameters (listed below in
;; order). A lot of the parameters are boiler-plate for whole classes of
;; weapons, so I added some "curried" wrapper calls below.
;;
;;          tag : the symbol for the type in the script (variable-name)
;;         name : the string name used by the game
;;       sprite : sprite for the type
;;       to-hit : to-hit attack bonus (dice expr)
;;       damage : attack damage (dice expr)
;;        armor : added to armor class (dice expr)
;;      deflect : damage deflected when hit (dice expr)
;;        slots : slots it will fit in (e.g., hands)
;;        hands : number of slots required to ready it
;;        range : range it will fire
;;          rap : required action points to attack with it
;;      missile : nil or the armament type it fires
;;       thrown : true or false
;;         ubiq : true if it needs ammo in inventory, false otherwise
;;        field : nil or the field type it leaves on the target tile
;;       weight : unused
;;   fire-sound : string name of sound file to play when it's fired
;;
;;----------------------------------------------------------------------------

;; Make the default number of required action points the same as the number of
;; turns a human gets per round.
(define default-rap speed-human) 

;;--------------------------------------------------------------------------
;; Curried constructors
;;
;; These are for creating the standard classes of armaments. They simplify
;; things by filling in the blanks for all the boilerplate parameters of
;; the primitive kern-mk-arms-type procedure.
;;--------------------------------------------------------------------------

(define obj-ifc-cap (ifc-cap obj-ifc))

(define (mk-melee-arms-type tag name sprite to-hit-bonus damage deflect slots 
                            num-hands range)
  (kern-mk-arms-type tag name sprite to-hit-bonus damage deflect "0"  slots 
                     num-hands range default-rap nil #f #f nil 0 nil obj-ifc-cap obj-ifc))

;; Curried constructor: missile weapon (add missile, ubiq flag to melee)
(define (mk-projectile-arms-type tag name sprite to-hit-bonus damage deflect 
                                 slots num-hands range missile ubiq)
  (kern-mk-arms-type tag name sprite to-hit-bonus damage deflect "0"  slots 
                     num-hands range default-rap missile #f ubiq nil 0 nil obj-ifc-cap obj-ifc))

;; Curried constructor: thrown weapon (add field to melee)
(define (mk-thrown-arms-type tag name sprite to-hit-bonus damage deflect slots 
                             num-hands range field)
  (kern-mk-arms-type tag name sprite to-hit-bonus damage deflect "0" slots 
                     num-hands range default-rap nil #t #f field 0 nil obj-ifc-cap obj-ifc))

(define (mk-missile-arms-type tag name sprite field damage ifc)
  (kern-mk-arms-type tag name sprite "0" damage "0" "0" slot-nil 0 0 0 nil #f #f 
                     field 0 nil (ifc-cap ifc) ifc))

(define (mk-armor-type tag name sprite to-hit armor slots)
  (kern-mk-arms-type tag name sprite to-hit "0" armor "0" slots 1 0 0 nil #f #f 
                     nil 0 nil obj-ifc-cap obj-ifc))

(define (mk-shield-type tag name sprite to-hit armor slots) 
  (kern-mk-arms-type tag name sprite to-hit "0" armor "0" slots 1 0 0 nil #f #f 
                     nil 0 nil obj-ifc-cap obj-ifc))

;; ----------------------------------------------------------------------------
;; Custom interfaces
;; ----------------------------------------------------------------------------
(define poison-bolt-ifc
  (ifc '()
       (method 'exec apply-poison)))

(define deathball-ifc
  (ifc '()
       (method 'exec (lambda (kobj)
                       (if (kern-obj-is-char? kobj)
                           (kern-char-kill kobj))))))

;;--------------------------------------------------------------------------
;; Standard arms type tables
;;
;; These are run-of-the-mill arms types that vary only in the values assigned
;; to different fields.
;;--------------------------------------------------------------------------

(define missile-arms-types
  (list
   ;;    ============================================================================================================
   ;;    tag           | name        | sprite  |       field  | damage | gifc
   ;;    ============================================================================================================
   (list 't_arrow        "arrow"       s_arrow         nil      "1d6"    obj-ifc)
   (list 't_warhead      "warhead"     s_magic         F_fire   "0"      obj-ifc)
   (list 't_cannonball   "cannonball"  s_magic         nil      "0"      obj-ifc)
   (list 't_poison_bolt  "poison bolt" s_green_magbolt nil      "1d6"    poison-bolt-ifc)
   (list 't_fireball     "fireball"    s_red_magbolt   nil      "2d6"    nil)
   (list 'deathball      "deathball"   s_magic         nil      "0"      deathball-ifc)
   ))

;; If we don't create these missile types now, we won't be able to refer to
;; them below in the projectile-arms-types table. For example, t_bow needs to
;; refer to t_arrow. But the interpreter won't recognize t_arrow as a variable
;; name until we call the procedure to create the t_arrow type.
(map (lambda (type) (apply mk-missile-arms-type type)) missile-arms-types)

(define projectile-arms-types
  (list
   ;;     ===========================================================================================================
   ;;     tag   | name       | sprite     | to-hit | damage | to-def | slots       | hnds | rng | missile | ubiq
   ;;     ===========================================================================================================
   (list 't_bow   "short bow"  s_lght_bow   "1"      "1d6"    "-2"     slot-weapon   2      6     t_arrow   #f)
   (list 't_rpg   "RPG"        s_hvy_xbow   "1d4"    "2d20"   "-5"     slot-weapon   2      12    t_warhead #t)
   ))

(define thrown-arms-types
  (list
   ;;     ===========================================================================================================
   ;;     tag    | name          | sprite           | to-hit | damage | to-def | slots       | hnds | rng | field
   ;;     ===========================================================================================================
   (list  't_oil   "flaming oil"   s_orange_potion    "0"      "1d6"    "-2"     slot-weapon   1      4     F_fire)
   (list  't_spear "spear"         s_spear            "0"      "1d8"    "+1"     slot-weapon   2      4     nil)
   (list  't_thrown_boulder "boulder" s_boulder       "-1"     "2d6"    "0"      slot-weapon   2      5     nil)
   ))

(define melee-arms-types
  (list
   ;;     ===========================================================================================================
   ;;     tag          | name          | sprite           | to-hit | damage | to-def | slots       | hnds | rng
   ;;     ===========================================================================================================
   (list  't_hands       "bare hands"     nil               "1d2"    "1d4"    "1d2"    slot-nil      1      1)
   (list  't_fangs       "fangs"          nil               "1d2"    "1d8"    "0"      slot-nil      1      1)
   (list  't_dagger      "dagger"         s_dagger          "1d3"    "1d6"    "1d2"    slot-weapon   1      1)
   (list  't_acid_spray  "acid spray"     nil               "1d2"     "1d8"   "0"      slot-nil      2      2)   
   (list  't_stinger     "stinger"        nil               "1d8"    "1d2-1"  "0"      slot-nil      1      1)
   ))

(define armor-types
  (list
   ;;     ===========================================================================================================
   ;;     tag             | name          | sprite           | to-hit | armor  | slots
   ;;     ===========================================================================================================
   (list   't_iron_helm     "iron helm"      s_plate_helm       "0"      "2"      slot-helm)
   ))

(define shield-types
  (list
   ;;     ===========================================================================================================
   ;;     tag             | name          | sprite           | to-hit | armor  | slots
   ;;     ===========================================================================================================
   (list   't_sm_shield    "small shield"  s_small_shield     "-1"     "3"      slot-shield)
   ))

(map (lambda (type) (apply mk-thrown-arms-type type)) thrown-arms-types)
(map (lambda (type) (apply mk-projectile-arms-type type)) projectile-arms-types)
(map (lambda (type) (apply mk-melee-arms-type type)) melee-arms-types)
(map (lambda (type) (apply mk-armor-type type)) armor-types)
(map (lambda (type) (apply mk-shield-type type)) shield-types)


;;--------------------------------------------------------------------------
;; Special arms types
;;
;; These don't fit into the mold for any standard arms type.
;;--------------------------------------------------------------------------

(kern-mk-arms-type 't_cannon         ; tag
                   "cannon"          ; name
                   nil               ; sprite
                   "+1"              ;;       to-hit : to-hit attack bonus (dice expr)
                   "2d20+5"          ;;       damage : attack damage (dice expr)
                   "0"               ;;        armor : added to armor class (dice expr)
                   "0"               ;;      deflect : damage deflected when hit (dice expr)
                   slot-nil          ;;        slots : slots it will fit in (e.g., hands)
                   0                 ;;        hands : number of slots required to ready it
                   6                 ;;        range : range it will fire
                   8                 ;;          rap : required action points to attack with it
                   t_cannonball      ;;      missile : nil or the armament type it fires
                   #f                ;;       thrown : true or false
                   #t                ;;         ubiq : true if it needs ammo in inventory, false otherwise
                   nil               ;;        field : nil or the field type it leaves on the target tile
                   0                 ;;       weight : unused
                   sound-cannon-fire ;;   fire-sound : string name of sound file to play when it's fired
                   0                 ;;      ifc-cap : integer bitmap describing interface slots
                   nil               ;;  get-handler : script ifc
                   )
                   
(display t_cannon)(newline)
