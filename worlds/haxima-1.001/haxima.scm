;;----------------------------------------------------------------------------
;; The very first line of any session file should be (load "naz.scm"). This
;; bootstraps some procedures that we need to continue. This is the only place
;; you should use 'load'. Every other place you want to load a file you should
;; user 'kern-load'. 'kern-load' ensures that a saved session will be able to
;; load the file, too.
;;----------------------------------------------------------------------------
(load "naz.scm")

;;----------------------------------------------------------------------------
;; Load the read-only game data. See the note on 'kern-load' vs 'load' above.
;;----------------------------------------------------------------------------
(kern-load "game.scm")

;;----------------------------------------------------------------------------
;; Maps
;;----------------------------------------------------------------------------
(load "gregors-hut.scm")
(load "moongate-clearing.scm")
(load "abandoned-farm.scm")

;;----------------------------------------------------------------------------
;; Characters
;;----------------------------------------------------------------------------
(kern-mk-char 
 'ch_wanderer
 "The Wanderer"        ; name
 sp_human              ; species
 oc_wanderer           ; occ
 s_companion_ranger    ; sprite
 faction-player        ; starting alignment
 0 10 2                ; str/int/dex
 0 1                   ; hp mod/mult
 10 5                  ; mp mod/mult
 24 0 3 3              ; hp/xp/mp/lvl
 nil                   ; conv
 nil                   ; sched
 nil                   ; special ai
 nil)                  ; readied
 
;;----------------------------------------------------------------------------
;; Player Party
;;----------------------------------------------------------------------------
(kern-mk-player
 'player                     ; tag
 s_companion_fighter         ; sprite
 "Walk"                      ; movement description
 sound-walking               ; movement sound
 1000                        ; food
 500                         ; gold
 nil                         ; formation
 nil                         ; campsite map
 nil                         ; campsite formation
 nil                         ; vehicle
 ;; inventory
 (kern-mk-container
  nil ;; type
  nil ;; trap
  ;; contents
  (list (list 1 t_dagger))
  nil)

 nil ;; party members (should be nil for initial load file)
 )

;;----------------------------------------------------------------------------
;; Party members
;;----------------------------------------------------------------------------
(kern-party-add-member player ch_wanderer)

;;----------------------------------------------------------------------------
;; Places
;;----------------------------------------------------------------------------
(define road-map
  (list
   (list 'r8 'rd 'rd 'r2)
   (list '.. '.. '.. 'r7)
   (list '.. '.. '.. 'r7)
   (list '.. '.. '.. 'r7)
   (list 'rd 'rd 'rd 'ra)))

(kern-mk-place 'p_shard
               "The Shard Surface"
               nil          ; sprite

               ;; map:
               (kern-mk-map 
                'm_shard 19 19 pal_expanded
                (list
                 "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ";  //  0
                 "-- -- -- -- {{ ^^ ^^ ^^ {{ {{ {{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ";  //  1
                 "-- __ __ -- tt {{ ^^ {{ tt tt ^^ tt tt tt {{ {{ {{ ^^ ^^ ";  //  2
                 "-- __ __ -- ~~ {{ {{ {{ tt ^^ ^^ ^^ {{ tt tt tt {{ {{ ^^ ";  //  3
                 "-- -- -- -- ~~ ~~ tt tt tt {{ ^^ {{ {{ tt tt tt tt {{ {{ ";  //  4
                 "-- ^^ tt {{ tt ~~ tt tt tt tt {{ {{ tt tt .. .. tt tt {{ ";  //  5
                 "^^ ^^ ^^ {{ tt ~~ tt tt tt tt tt tt .. .. .. .. .. tt tt ";  //  6
                 "^^ ^^ ^^ {{ tt ~~ tt tt tt .. tt tt .. .. .. .. .. tt .. ";  //  7
                 "{{ {{ ^^ {{ tt ~~ ~~ ~~ tt tt tt .. .. .. .. .. .. .. tt ";  //  8
                 "^^ {{ ^^ ^^ {{ tt tt ~~ ~~ tt .. .. .. .. .. .. .. .. .. ";  //  9
                 "tt {{ tt {{ tt tt tt tt ~~ tt .. .. .. .. .. .. .. .. .. ";  // 10
                 "{{ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ tt .. .. .. .. .. .. .. .. .. ";  // 11
                 "~~ ~~ tt tt tt tt tt tt ~~ tt .. .. .. .. .. .. .. .. .. ";  // 12
                 "tt tt tt .. .. .. .. tt ~~ tt .. .. .. .. .. .. .. .. .. ";  // 13
                 ".. .. .. .. .. .. .. tt ~~ tt tt .. .. .. .. .. .. .. .. ";  // 14
                 ".. .. .. .. .. .. .. tt ~~ tt tt .. .. .. .. .. .. .. .. ";  // 15
                 ".. .. .. .. .. .. .. tt ~~ ~~ tt .. .. .. .. .. .. .. .. ";  // 16
                 ".. .. .. .. .. .. .. tt tt ~~ tt .. .. .. .. .. .. .. .. ";  // 17
                 ".. .. .. .. .. .. .. tt tt ~~ tt .. .. .. .. .. .. .. .. ";  // 18
                 )
                )

               #f  ;; wraps
               #f  ;; underground
               #t  ;; wilderness
               #f  ;; tmp combat place

               ;; subplaces:
               (list
                (list p_moongate_clearing  9 7)
                (list p_gregors_hut       18 9)
                (list p_abandoned_farm    18 7)
                )

               nil ; neighbors

               ;; objects:
               (list
                (list player 9 9)
                )

               nil ; hooks
               )

;;----------------------------------------------------------------------------
;; Time
;;----------------------------------------------------------------------------
(define hour 12)
(define minutes 45)
(define time-in-minutes (+ (* hour 60) minutes))

(kern-set-clock 
 0 ; year
 0 ; month
 0 ; week
 0 ; day
 hour  ; hour
 minutes ; minutes(
 )

;;----------------------------------------------------------------------------
;; Astronomy
;;----------------------------------------------------------------------------
(kern-mk-astral-body
 'sun              ; tag
 "Fyer (the sun)"  ; name
 1                 ; relative astronomical distance 
 1                 ; minutes per phase (n/a for sun)
 (/ (* 24 60) 360) ; minutes per degree
 0                 ; initial arc
 0                 ; initial phase
 '()               ; script interface
 ;; phases:
 (list 
  (list s_sun 255 "full")
  )
 )

;; ----------------------------------------------------------------------------
;; The diplomacy table. Each entry defines the attitude of the row to the
;; column. Note that attitudes are not necessarily symmetric. Negative values
;; are hostile, positive are friendly.
;; ----------------------------------------------------------------------------
(kern-mk-dtable
 ;;           none play men orks accu mons
 (dtable-row  0    0    0   0   -1    -2) ;; none
 (dtable-row  0    2    1   0   -1    -2) ;; player
 (dtable-row -1    1    2  -1   -2    -2) ;; men
 (dtable-row -1    0   -1   2   -1    -2) ;; orks
 (dtable-row -1   -1   -1  -1    2    -2) ;; accursed
 (dtable-row -2   -2   -2  -2   -2     0) ;; monsters
 )
