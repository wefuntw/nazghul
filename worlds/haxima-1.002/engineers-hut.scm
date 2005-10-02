;;----------------------------------------------------------------------------
;; Map
;;----------------------------------------------------------------------------
(kern-mk-map
 'm_engineers_hut 19 19 pal_expanded
 (list
            ".. .. .. .. .. .. .. .. .. .. tt tt tt tt .. .. .. .. .. "
            ".. rr rr rr rr rr rr rr rr rr .. tt tt .. rr rr rr rr .. "
            ".. rr rr [[ @@ @@ @@ ]] rr rr .. .. .. .. rr ,, ,, rr .. "
            ".. rr 00 ,, ,, ,, ,, ,, ,, rr .. /0 /d /d ,, ,, ,, rr .. "
            "~~ rr 00 ,, ,, ,, ,, ,, ,, rr .. /7 .. .. rr ,, ,, rr .. "
            "~~ rr 00 ,, ,, [[ ]] ,, ,, ,, /d /6 .. .. rr ,, bb rr .. "
            "~~ rr ,, ,, ,, ,, ,, ,, ,, rr .. /7 .. .. rr .. ,, rr .. "
            "~~ rr ~~ ,, ,, ,, ,, ,, ,, rr .. /7 .. .. rr ,, ,, rr .. "
            ".. rr ~~ ,, ,, ,, [[ @@ ]] rr .. /7 .. .. rr rr rr rr .. "
            ".. rr ,, ,, ,, ,, rr rr rr rr .. /7 .. bb .. .. .. .. tt "
            ".. rr ,, ,, ,, ,, 00 rr .. .. .. /7 .. .. .. .. .. tt tt "
            ".. rr ,, ,, ,, ,, 00 rr .. /0 /d /9 /d /d /d /2 .. tt tt "
            ".. rr ,, rr && rr rr rr .. /7 .. .. .. .. .. /7 .. .. tt "
            "bb .. .. rr rr rr ~~ .. .. /7 .. .. .. rr rr ,, rr rr .. "
            "bb .. .. .. .. .. ~~ bb .. /7 .. .. rr rr ,, ,, ,, rr .. "
            "bb .. .. .. .. .. ~~ ~~ ~~ =| ~~ ~~ rr && ,, ,, ,, rr .. "
            "bb .. .. .. .. .. .. bb .. /7 .. ~~ rr rr ,, ,, ,, rr .. "
            "bb .. .. .. .. .. bb .. .. /7 .. ~~ ~~ rr rr rr rr rr .. "
            "tt bb bb bb bb bb tt .. .. /7 .. .. ~~ .. .. .. .. .. .. "
))

;;----------------------------------------------------------------------------
;; NPC's
;;----------------------------------------------------------------------------


;;----------------------------------------------------------------------------
;; Place
;;----------------------------------------------------------------------------
(kern-mk-place
 'p_engineers_hut     ; tag
 "Engineers Hut"      ; name
 s_hamlet      ; sprite
 m_engineers_hut      ; map
 #f              ; wraps
 #f              ; underground
 #f              ; large-scale (wilderness)
 #f              ; tmp combat place
 nil ; subplaces
 nil ; neighbors

 (list ; objects
  (put (mk-bull) 3 15)
  (put (mk-door) 15 13)
  (put (mk-bed) 16 15)
  (put (mk-chest
        nil
        (list (list 5 t_food))) 14 16)

  (put (mk-door) 14  3)

  (put (mk-door) 9 5)
  (put (mk-windowed-door) 2 12)
  )

 nil ; hooks
 (list  ;; edge entrances
  (list east  0 9)
  (list south 9 0) 
  (list north 9 18)
  (list west  18 9)
  )
 )

