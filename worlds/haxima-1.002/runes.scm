;; rune sprites

;; rune interface: when a rune is used on a special altar, it transforms the
;; alter and signals the demon gate mechanism
(define (rune-use ktype kuser)
  (println "rune-use")
  (let ((loc (get-target-loc kuser 1)))
    (cond ((null? loc) 
           result-no-target)
          ((eqv? (kern-place-get-terrain loc) t_rune_altar)
           (shake-map 5)
           (kern-log-msg "A LOCK IS RELEASED!")
           (kern-obj-remove-from-inventory kuser ktype 1)
           (kern-place-set-terrain loc t_active_altar)
           (send-signal kuser demon-gate 'on)
           result-ok)
          (else 
           result-not-here))))

(define rune-ifc
  (ifc obj-ifc
       (method 'use rune-use)
       ))

;; special extended interface for rune of leadership: summon the ghost of the
;; warritrix when the player picks it up
(define (rune-l-get kobj kchar)
  (kern-log-msg "An apparition appears!")
  (kern-obj-put-at (mk-warritrix)
                   (kern-obj-get-location kobj))
  (kern-obj-remove kobj)
  (kobj-get (kern-mk-obj t_rune_l 1) kchar))
(define rune-l-ifc
  (ifc rune-ifc
       (method 'get rune-l-get)))

;; trigger quest update
(define (rune-k-get kobj kchar)
	(quest-data-update-with 'questentry-thiefrune 'recovered 1 (quest-notify (grant-party-xp-fn 50)))
	(kobj-get kobj kchar)
	)
(define rune-k-ifc
  (ifc rune-ifc
       (method 'get rune-k-get)))
	
;; trigger quest update
(define (rune-p-get kobj kchar)
	(quest-complete (quest-data-get 'questentry-rune-p))
	(quest-data-assign-once 'questentry-rune-p)
	(quest-data-update-with 'questentry-rune-p 'done 1 (grant-party-xp-fn 50))
	(qst-set-icon! (quest-get 'questentry-rune-p) s_runestone_p)
	(kobj-get kobj kchar)
	)
(define rune-p-ifc
  (ifc rune-ifc
       (method 'get rune-p-get)))


;; rune types
(mk-quest-obj-type 't_rune_k "Rune of Knowledge" s_runestone_k layer-item rune-k-ifc)
(mk-quest-obj-type 't_rune_p "Rune of Power" s_runestone_p layer-item rune-p-ifc)
(mk-quest-obj-type 't_rune_s "Rune of Skill" s_runestone_s layer-item rune-ifc)
(mk-quest-obj-type 't_rune_c "Rune of Curiosity" s_runestone_c layer-item rune-ifc)
(mk-quest-obj-type 't_rune_f "Rune of Freedom" s_runestone_f layer-item rune-ifc)
(mk-quest-obj-type 't_rune_w "Rune of Wisdom" s_runestone_w layer-item rune-ifc)
(mk-quest-obj-type 't_rune_d "Rune of Discretion" s_runestone_d layer-item rune-ifc)
(mk-quest-obj-type 't_rune_l "Rune of Leadership" s_runestone_l layer-item rune-ifc)
(mk-quest-obj-type 't_rune_l_init "Rune of Leadership" s_runestone_l layer-item rune-l-ifc)

;; list of all rune types
(define rune-types 
  (list t_rune_k
        t_rune_p
        t_rune_s
        t_rune_c
        t_rune_l
        t_rune_f
        t_rune_w
        t_rune_d))

;; check if kpc has all the runes in inventory
(define (has-all-runes? kpc)
  (all-in-inventory? kpc rune-types))
