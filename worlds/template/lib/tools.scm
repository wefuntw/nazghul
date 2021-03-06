;; ----------------------------------------------------------------------------
;; tools.scm -- "usable" stuff that isn't a book, scroll or potion
;; ----------------------------------------------------------------------------

(kern-mk-sprite-set 'ss_tools 32 32 8 8 0 0 "gfx/tools.png")

(kern-mk-sprite 's_torch    ss_tools 1 0 #f 0)
(kern-mk-sprite 's_picklock ss_tools 1 1 #f 0)
(kern-mk-sprite 's_gem      ss_tools 1 2 #f 0)
(kern-mk-sprite 's_shovel   ss_tools 1 3 #f 0)
(kern-mk-sprite 's_pick     ss_tools 1 4 #f 0)
(kern-mk-sprite 's_sextant  ss_tools 1 5 #f 0)
(kern-mk-sprite 's_chrono   ss_tools 1 6 #f 0)
(kern-mk-sprite 's_clock_stopped    ss_tools 1 7 #f 0)
(kern-mk-sprite 's_clock_body    ss_tools 2 8 #f 0)
(kern-mk-sprite 's_clock_hand_n    ss_tools 1 10 #f 0)
(kern-mk-sprite 's_clock_hand_ne    ss_tools 1 11 #f 0)
(kern-mk-sprite 's_clock_hand_se    ss_tools 1 12 #f 0)
(kern-mk-sprite 's_clock_hand_s    ss_tools 1 13 #f 0)
(kern-mk-sprite 's_clock_hand_sw    ss_tools 1 14 #f 0)
(kern-mk-sprite 's_clock_hand_nw    ss_tools 1 15 #f 0)
(kern-mk-sprite 's_clock_spin            ss_tools 6 10 #f 0)
(kern-mk-sprite 's_mirror_fg             ss_tools 1 16 #f 0)
(kern-mk-sprite 's_mirror_bg_flagstones   ss_tools 1 17 #f 0)
(kern-mk-sprite 's_mirror_bg   ss_tools 1 18 #f 0)
(kern-mk-sprite 's_bookshelf   ss_tools 1 23 #f 0)
(kern-mk-sprite 's_grease      ss_tools 1 24 #f 0)
(kern-mk-sprite 's_rope_hook   ss_tools 1 25 #f 0)


;; torch -- use two in-lor spells
(mk-usable-item 't_torch "torch" s_torch norm
                (lambda (kobj kuser) 
                  (kern-obj-add-effect kuser ef_torchlight nil)
                  result-ok))

;; picklock
(define (pick-lock-ok kuser ktarg)
  (send-signal kuser ktarg 'unlock)
  result-ok)
(define (pick-lock-failed kuser ktool)
  (kern-log-msg "Picklock broke!")
  (kern-obj-remove-from-inventory kuser ktool 1)
  result-failed)
(define (pick-lock-bonus kuser)
  (if (eqv? (kern-char-get-occ kuser)
            oc_wrogue)
      (floor (+ (kern-char-get-level kuser) (/ (kern-char-get-dexterity kuser) 3)))
      (floor (/ (+ (kern-char-get-level kuser) (kern-char-get-dexterity kuser)) 4)))
      )
(mk-reusable-item 't_picklock "picklock" s_picklock v-hard
                  (lambda (kobj kuser)
                    (let ((ktarg (ui-target (kern-obj-get-location kuser)
                                            1 
                                            (mk-ifc-query 'unlock))))
                      (if (null? ktarg)
                          (begin
                            (kern-log-msg "No effect!")
                            nil)
                          (let ((roll (kern-dice-roll "1d20"))
                                (bonus (kern-dice-roll (string-append "1d" 
                                                                      (number->string (occ-ability-thief kuser)))))
                                )
                            (println "rolled " roll " + " bonus)
                            (if (= roll 20)
                                (pick-lock-ok kuser ktarg)
                                (if (> (+ roll bonus ) 
                                       15)
                                    (pick-lock-ok kuser ktarg)
                                    (pick-lock-failed kuser kobj)
                                    )))))))

;; gem -- use peer spell
(mk-usable-item 't_gem "gem" s_gem norm
                (lambda (kgem kuser)
                  (powers-view kuser kuser 12)
                  result-ok))

;; sledge-hammer -- shatter rocks
(mk-reusable-item 't_pick "pick" s_pick v-hard
                  (lambda (ktool kuser)
                    (let ((loc (kern-ui-target (kern-obj-get-location kuser)
                                               1)))
                      (if (null? loc)
                          result-no-target
                          (let ((kter (kern-place-get-terrain loc)))
                            (cond ((eqv? kter t_boulder)
                                   (kern-log-msg (kern-obj-get-name kuser)
                                                 " pulverizes a boulder!")
                                   (kern-place-set-terrain loc t_grass)
                                   (cond ((> (kern-dice-roll "1d20") 16)
                                          (kern-log-msg "The pick shatters!")
                                          (kern-obj-remove-from-inventory kuser ktool 1)))
                                   result-ok)
                                  (else
                                   result-no-effect)))))))

;; sextant -- gives location
(mk-reusable-item 't_sextant "sextant" s_sextant hard
                  (lambda (ktool kuser)
                    (let ((loc (kern-obj-get-location kuser)))
                      (cond ((kern-place-is-wilderness? (loc-place loc))
                             (kern-log-msg "You are at [x=" 
                                           (cadr loc) " y=" (caddr loc) "]")
                             result-ok)
                            (else
                             (kern-log-msg "Usable only in the wilderness!")
                             result-not-here)))))

;;----------------------------------------------------------------------------
;; shovel & buried object generator
;;----------------------------------------------------------------------------
(define (buried-mk objtype-tag quan) (list objtype-tag quan))
(define (buried-objtype-tag buried) (car buried))
(define (buried-quan buried) (cadr buried))

(define (buried-digup kburied)
  (display "buried-digup")(newline)
  (let* ((buried (kobj-gob-data kburied))
         (kobj (kern-mk-obj (eval (buried-objtype-tag buried))
                            (buried-quan buried))))
    (kern-obj-put-at kobj
                     (kern-obj-get-location kburied))
    (kern-log-msg "You dig up something!")
    (kern-obj-remove kburied)))

(define buried-ifc
  (ifc nil
       (method 'digup buried-digup)))

(mk-obj-type 't_buried nil nil layer-none buried-ifc)

(define (mk-buried objtype-tag quan)
  (bind (kern-mk-obj t_buried 1)
        (buried-mk objtype-tag quan)))

(define (is-buried? kobj)
  (eqv? (kern-obj-get-type kobj)
        t_buried))

(mk-reusable-item 't_shovel "shovel" s_shovel v-hard
                (lambda (kshovel kuser)
                  (let ((ktarg (filter is-buried?
                                       (kern-get-objects-at 
                                        (kern-obj-get-location kuser)))))
                    (cond ((null? ktarg)
                           (kern-log-msg "Nothing buried here!")
                           result-no-effect)
                          (else
                           (signal-kobj (car ktarg) 'digup (car ktarg) nil)
                           result-ok)))))
						  
(mk-reusable-item 't_chrono "chronometer" s_chrono hard
                  (lambda (kclock kuser)
                    (let* ((time (kern-get-time))
                           (hour (number->string
                                  (if (< (time-hour time) 13)
                                      (time-hour time)
                                      (- (time-hour time) 12))))
                           (minbase (number->string (time-minute time)))
                           (min (if (< (time-minute time) 10)
                                    (string-append "0" minbase)
                                    minbase)))
                      (kern-log-msg "The chronometer reads " hour ":" min)
                      result-ok)))
			
(define clock-hand-icons (list s_clock_hand_n s_clock_hand_ne s_clock_hand_se s_clock_hand_s s_clock_hand_sw s_clock_hand_nw))

(define (clock-get-hand number)
	(if (> number 5)
		(clock-get-hand (- number 6))
		(list-ref clock-hand-icons number)
	))

(define clock-ifc
  (let ((readclock 
         (lambda (kclock kuser)
           (let* ((time (kern-get-time))
                  (hour (number->string
                         (if (< (time-hour time) 13)
                             (time-hour time)
                             (- (time-hour time) 12))))
                  (minbase (number->string (time-minute time)))
                  (min (if (< (time-minute time) 10)
                           (string-append "0" minbase)
                           minbase)))
             (kern-log-msg "The clock reads " hour ":" min)
             result-ok))))
    (ifc '()
         (method 'handle 
                 readclock)
         (method 'xamine 
                 readclock)
         (method 'step
                 (lambda (kmirror kuser)
                   ))
         (method 'update-gfx
                 (lambda (kclock)
                   (let* ((time (kern-get-time))
                          (hour-hand (clock-get-hand (floor (/ (time-hour time) 2))))
                          (min-hand (clock-get-hand (floor (/ (+ (time-minute time) 5) 10)))))
                     (kern-obj-set-sprite kclock (mk-composite-sprite (list s_clock_body hour-hand min-hand)))
                     )))
         (method 'init
                 (lambda (kmirror)
                   (kern-obj-set-pclass kmirror pclass-wall)
                   ))	
         )))

(define broken-clock-ifc
  (let ((readclock 
         (lambda (kclock kuser)
           (kern-log-msg (gob kclock))
           )))
    (ifc '()
         (method 'handle 
                 readclock)
         (method 'xamine
                 readclock)
         (method 'step
                 (lambda (kmirror kuser)
                   ))
         (method 'init
                 (lambda (kmirror)
                   (kern-obj-set-pclass kmirror pclass-wall)
                   ))
         )))

(mk-obj-type 't_clock "clock"
             (mk-composite-sprite (list s_clock_body s_clock_hand_n s_clock_spin))
             layer-mechanism clock-ifc)

(define (mk-clock)
	(let ((kclock (kern-mk-obj t_clock 1)))
          (kern-obj-add-effect kclock ef_graphics_update nil) 
          (bind kclock nil)
          kclock))

(mk-obj-type 't_broken_clock "clock"
             s_clock_stopped
             layer-mechanism broken-clock-ifc)
	
(define (mk-broken-clock icona iconb message)
  (let ((kclock (kern-mk-obj t_broken_clock 1)))
    (bind kclock message)
    (kern-obj-set-sprite kclock (mk-composite-sprite (list s_clock_stopped icona iconb)))
    kclock))


(define (get-char-at location)
  (define (get-char-from list)
    (cond ((null? list) nil)
          ((kern-obj-is-char? (car list)) (car list))
          (else (get-char-from (cdr list))))
    )
  (get-char-from (kern-get-objects-at location))
  )

;;------------------------------------------------
;; mirrors

(define mirror-ifc
  (ifc '()
       (method 'handle 
               (lambda (kmirror kuser)
                 (kern-log-msg (kern-obj-get-name kuser) " spots " (kern-obj-get-name kuser) " in the mirror")
                 result-ok))
       (method 'step
               (lambda (kmirror kuser)
                 ))
       (method 'remote-sensor
               (lambda (kmirror kuser)
                 (let* ((mirror-loc (kern-obj-get-location kmirror))
                        (target-loc (list (car mirror-loc) (cadr mirror-loc) (+ (caddr mirror-loc) 1)))
                        (character (get-char-at target-loc)))
                   (if (null? character)
                       (kern-obj-set-sprite kmirror (mk-composite-sprite (list s_mirror_bg (eval (gob kmirror)) s_mirror_fg)))
                       (kern-obj-set-sprite kmirror (mk-composite-sprite (list s_mirror_bg (kern-obj-get-sprite character) (eval (gob kmirror)) s_mirror_fg))))
                   (kern-map-set-dirty)
                   )))
       (method 'init
               (lambda (kmirror)
                 (kern-obj-set-pclass kmirror pclass-wall)
                 ))
       ))

(mk-obj-type 't_mirror "mirror"
             '()
             layer-mechanism mirror-ifc)

(define (mk-mirror background-tag)
  (let ((kmirror (kern-mk-obj t_mirror 1)))
    (bind kmirror background-tag)
    (kern-obj-set-sprite kmirror (mk-composite-sprite (list s_mirror_bg (eval background-tag) s_mirror_fg)))
    kmirror))

;;---------------------------------------------------------
;; bookshelf

(define shelf-ifc
  (ifc '()
       (method 'step
               (lambda (kobj kuser)
                 ))
       (method 'init
               (lambda (kobj)
                 (kern-obj-set-pclass kobj pclass-wall)
                 ))
       ))

(mk-obj-type 't_shelf "set of shelves"
             s_bookshelf
             layer-mechanism shelf-ifc)

(define (mk-shelf)
  (let ((kshelf (kern-mk-obj t_shelf 1)))
    (bind kshelf nil)
    kshelf))

;;---------------------------------------------------------
;; blocker

(define blocker-ifc
  (ifc '()
       (method 'step
               (lambda (kobj kuser)
                 ))
       (method 'init
               (lambda (kobj)
                 (kern-obj-set-pclass kobj pclass-space)
                 ))
       ))

(mk-obj-type 't_blocker nil
             '()
             layer-mechanism blocker-ifc)

(define (mk-blocker)
  (let ((kstop (kern-mk-obj t_blocker 1)))
    (bind kstop nil)
    kstop))

;; grease -- inert object, required for the Wriggle skill
(mk-obj-type 't_grease "grease" s_grease layer-item obj-ifc)

;;----------------------------------------------------------------------------
;; rope-and-hook -- use the wrogue's Reach skill. Works like telekineses but
;; range is limited by wrogue ability.
;;
(mk-reusable-item 
 't_rope_hook "rope & hook" s_rope_hook hard
 (lambda (kobj kuser)
   (cond ((not (has-skill? kuser sk_reach)) result-lacks-skill)
         (else
          (cast-ui-ranged-any powers-telekinesis
                              kuser
                              (powers-telekinesis-range (occ-ability-thief kuser))
                              (occ-ability-thief kuser)
                              kern-obj-is-mech?)))))
