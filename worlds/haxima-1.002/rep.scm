;;----------------------------------------------------------------------------
;; Player reputation management
;;
;; Crimes are worth various points. When the player crosses the line he becomes
;; an outlaw (his faction is changed). Over time the points decrement, and
;; eventually, if he stops committing crimes, his faction will revert to
;; normal. In general the third misdemeanor, second felony or first murder
;; pushes the player over the outlaw line.
;;
;; Murder should result in an outlaw period of one week. To allow for accidents
;; one assault alone will have no ill effect, but the second should result in a
;; day of outlawry.
;; 
;; TURNS_PER_MINUTE is currently hardcoded in src/common.h as 20.
;;
;;   1 minute = 20 turns
;;   1 hour   = 1200 turns
;;   1 day    = 28,800 turns
;;   1 week   = 201,600 turns
;; 
;; Let x be the outlaw boundary (measured in turns). Murder should result in 1
;; week:
;;
;;   murder = x + 201,600
;;
;; 2 assaults results in 1 day:
;;
;;   2 * assault = x + 28,800
;;       assault = x/2 + 14,400
;;
;; And 1 assault should be just below the cutoff:
;;
;;       assault = x - 1 
;;        2x - 2 = x + 28,800
;;             x = 28,802
;; 
;; Round x to 30000 (this is the boundary at which the player faction changes)
;; and recompute:
;; 
;;   assault = 15,000 + 14,400 = 29,400 turns
;;   murder = 30,000 + 201,600 = 231,600 turns
;;   max = 1,000,000 turns
;;

;;----------------------------------------------------------------------------
;; Constants
(define outlaw-rep -30000)
(define max-bad-rep -1000000)
(define assault-lethal 29400)
(define assault-non-lethal 15000)
(define murder-rep 231600)

;;----------------------------------------------------------------------------
;; Utility methods
(define (player-rep) 
  (player-get 'rep))

(define (player-set-rep! val)
  (if (> val max-bad-rep)
      (let ((kplayer (kern-get-player))
            (orep (player-get 'rep)))
        (player-set! 'rep val)
        (println "old rep:" orep " new rep:" val)
        (if (< val outlaw-rep)
            (if (>= orep outlaw-rep)
                (begin
                  (kern-being-set-base-faction kplayer faction-player-outlaw)
                  (kern-obj-add-effect kplayer ef_outlaw nil)
                  (kern-log-msg "^c+rYou have become an outlaw!^c-")
                  ))
            (if (< orep outlaw-rep)
                (begin
                  (kern-being-set-base-faction kplayer faction-player)
                  (kern-obj-remove-effect kplayer ef_outlaw)
                  (kern-log-msg "^c+gYou are no longer an outlaw!^c-")
                  ))
            ))))

(define (player-add-crime! what kvictim)
  (println "player-add-crime!")
  (let ((rap (player-get 'rapsheet))
        (where (kern-place-get-name (loc-place (kern-obj-get-location kvictim))))
        (towhom (kern-obj-get-name kvictim))
        )
    (player-set! 'rapsheet (cons (list what (kern-get-time) where towhom)
                                 rap))))

;;----------------------------------------------------------------------------
;; Turn-end-hook
;;
;; Cool off the reputation over time.
;;
(define (rep-update-after-turn kplayer)
  (let ((rep (player-get 'rep))
        (ticks (kern-ticks-per-turn)))
    (println "rep:" rep " ticks:" ticks)
    (cond ((> rep 0) 
           (player-set-rep! (- rep (min ticks rep))))
          ((< rep 0) 
           (player-set-rep! (+ rep (min ticks (- 0 rep)))))
          )))

(kern-add-hook 'turn_end_hook 'rep-update-after-turn)

;;----------------------------------------------------------------------------
;; Post-attack hook
;;
;; Check for attacks on friendlies and apply the consequences: player
;; reputation change, calling the guard, panicking the village, etc.
;;
(define (rep-update-after-attack kpc knpc degree)
  (if (not (is-hostile? kpc knpc))
      (let ((rep (player-rep)))
        (cond ((and (is-dead? knpc)
                    (can-be-seen-by-any? kpc (all-allies knpc)))
               ;; Murder with witnesses...
               (println "murder")
               (player-set-rep! (- rep murder-rep))
               (player-add-crime! "murder" knpc)
               (raise-alarm knpc #f)
               )
              (else
               ;; The victim is a witness, might flip to hostile after this
               (println "assault")
               (player-set-rep! (- rep degree))
               (player-add-crime! "assault" knpc)
               (if (in-town? knpc)
                   (cond ((not (is-hostile? kpc knpc))
                          ;; not hostile yet, but not happy
                          (println "complain")
                          (taunt knpc nil (list "Hey, watch it!" 
                                                "Watch where you point that thing!"
                                                "Behave!" "Take it outside!" 
                                                "Why, I oughtta..."
                                                "Keep it up and see what happens." 
                                                "I dare you to try that again."
                                                "You want to start something?"
                                                "You're lucky I'm in a good mood."
                                                "You got a problem?")
                                 ))
                         (else
                          ;; that's it, call the guards
                          (println "alarm")
                          (raise-alarm knpc #t)
                          ))))))))

(define (rep-post-attack-hook kpc knpc)
  (rep-update-after-attack kpc knpc assault-lethal))

(kern-add-hook 'post_attack_hook 'rep-post-attack-hook)

;;----------------------------------------------------------------------------
;; Reputation UI
;;
;; Add a pane to the ztats window that will show details of the player's
;; current reputation, including time left on outlawry or probation and a rap
;; sheet of past crimes.
;;
;; Use 'rz' as the shortened prefix for 'rep-ztats'.
;;

;;;;(define (rz-mk) (list nil nil))
;;;;(define (rz-dims! gob dims) (set-car! gob dims))
;;;;(define (rz-dims gob) (list-ref gob 0))
;;;;
;;;;(define (rz-enter self kparty dir rect)
;;;;  (kern-status-set-title "Reputation")
;;;;  (self-dims! self dims)
;;;;  )
;;;;
;;;;(define (rz-scroll self dir)
;;;;  )
;;;;
;;;;(define (rz-paint self)
;;;;  )
;;;;
;;;;(kern-ztats-add-pane rz-enter 
;;;;                     rz-scroll 
;;;;                     rz-paint 
;;;;                     rz-select 
;;;;                     (rz-mk))