;;;;
;;;; old-mine.scm -- an abandoned mine littered with gems
;;;;

(mk-dungeon-room
 'p_old_mine "Old Mine"
 (list
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr bb bb rr rr rr rr rr bb bb bb .. .. .. .. bb bb rr "
      "rr bb .. .. bb rr rr rr bb .. .. .. .. .. .. .. .. bb rr "
      "rr bb .. .. .. .. .. .. .. .. .. .. rr rr .. .. .. bb rr "
      "rr rr .. .. .. .. .. .. .. .. .. bb rr rr rr .. .. rr rr "
      "rr rr .. .. rr rr rr rr .. .. .. rr rr rr rr .. .. rr rr "
      "rr rr .. .. bb rr rr rr rr .. .. bb bb rr rr .. .. rr rr "
      "rr rr .. .. .. bb bb bb bb .. .. .. bb .. bb .. .. rr rr "
      "rr rr .. .. .. bb bb .. .. .. .. .. .. .. .. .. .. rr rr "
      "rr rr .. .. bb rr .. .. .. .. .. .. .. .. .. .. .. rr rr "
      "rr rr .. .. rr bb .. .. .. .. .. rr rr .. .. .. .. bb rr "
      "rr rr .. .. rr rr .. .. .. .. bb rr rr rr rr .. .. rr rr "
      "rr rr .. .. .. bb .. .. rr bb rr rr rr rr rr .. .. rr rr "
      "rr rr .. .. .. .. .. rr rr rr rr .. .. rr .. .. .. rr rr "
      "rr bb .. .. .. .. .. rr .. .. .. .. .. .. .. .. .. rr rr "
      "rr bb .. .. .. .. .. .. .. .. .. .. .. .. .. rr .. rr rr "
      "rr rr bb .. .. .. .. .. .. rr rr .. .. rr rr rr .. .. rr "
      "rr rr rr rr bb rr rr rr rr rr rr rr rr rr rr rr .. .. rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
  )
 (put (mk-ladder-down 'p_trolls_den 3 15) 17 17)
 (put (guard-pt 'ghast) 15 10)
 (put (guard-pt 'ghast) 11 14)
 (put (mk-step-trig 'wind-trap nil) 15 14)
 (put (mk-step-trig 'wind-trap nil) 16 12)
 )

;; drop gems
(put-random-stuff p_old_mine
                  (mk-rect 0 0 19 19)
                  (lambda (loc)
                    (eqv? (kern-place-get-terrain loc)
                          t_boulder))
                  (lambda (loc)
                    (kern-obj-put-at (kern-mk-obj t_gem 
                                                  (modulo (random-next) 
                                                          10))
                                     loc))
                  10)
