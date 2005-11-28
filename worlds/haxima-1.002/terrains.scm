;;----------------------------------------------------------------------------
;; Terrains
;;----------------------------------------------------------------------------

(define (terrain-effect-burn obj)
  (kern-obj-apply-damage obj "burning" 10))

(define (terrain-effect-poison obj)
  (if (and (> (kern-dice-roll "1d20") 10)
           (kern-obj-is-being? obj)
           (kern-obj-add-effect obj ef_poison nil))
      (kern-log-msg "Noxious fumes!")))

(define terrains
  (list
   ;;    tag                name            pclass           sprite            t light step-on
   ;;    =================  ==============  =============    ==============    = ===== =======
   (list 't_stars           "stars"         pclass-space     s_stars           1 0 nil)
   (list 't_deep            "deep water"    pclass-deep      s_deep            1 0 nil)
   (list 't_sunlit_deep     "deep water"    pclass-deep      s_deep            1 64 nil)
   (list 't_shallow         "shallow water" pclass-deep      s_shallow         1 0 nil)
   (list 't_shoals          "shoals"        pclass-shoals    s_shoals          1 0 nil)

   (list 't_grass           "grass"         pclass-grass     s_grass           1 0 nil)
   (list 't_sunlit_grass    "grass"         pclass-grass     s_grass           1 64 nil)

   (list 't_trees           "trees"         pclass-trees     s_trees           1 0 nil)
   (list 't_forest_v        "forest"        pclass-forest    s_forest          1 0 nil)
   (list 't_forest          "forest"        pclass-forest    s_forest          0 0 nil)

   (list 't_hills           "hills"         pclass-forest    s_hills           1 0 nil)
   (list 't_mountains_v     "mountains"     pclass-mountains s_mountains       1 0 nil)
   (list 't_mountains       "mountains"     pclass-mountains s_mountains       0 0 nil)
   (list 't_fake_mountains  "mountains"     pclass-grass     s_mountains       0 0 nil)

   (list 't_bog             "bog"           pclass-forest    s_bog             1 0 'terrain-effect-poison)

   (list 't_lava            "lava"          pclass-grass     s_lava            1  128 'burn)
   (list 't_fake_lava       "lava"          pclass-grass     s_lava            1  128 nil)
   (list 't_deep_lava       "deep lava"     pclass-deep      s_deep_lava       1  0  'great-burn)
   (list 't_fire_terrain    "fire"          pclass-grass     s_field_fire      1  512 'burn)
   (list 't_fireplace       "fireplace"     pclass-grass     s_fireplace       1 2048 'burn)

   (list 't_cobblestone     "cobblestone"   pclass-grass     s_cobblestone     1 0 nil)
   (list 't_flagstones      "flagstones"    pclass-grass     s_flagstone       1 0 nil)
   (list 't_inv_wall        "flagstones"    pclass-repel     s_flagstone       1 0 'burn)
   (list 't_doorway         "doorway"       pclass-grass     s_doorway 1 0 nil)
   (list 't_leftwing        "castle wall"   pclass-wall      s_leftwing        1 0 nil)
   (list 't_rightwing       "castle wall"   pclass-wall      s_rightwing       1 0 nil)

   (list 't_ship_hull       "ship's bulwark"   pclass-wall      s_wall         1 0 nil)
   (list 't_ship_hull2      "ship's hull"   pclass-wall      s_wall            0 0 nil)
   (list 't_sh_hull_NE      "ship's hull"   pclass-wall      s_wall_b          1 0 nil)
   (list 't_sh_hull_NW      "ship's hull"   pclass-wall      s_wall_a          1 0 nil)
   (list 't_sh_hull_SE      "ship's hull"   pclass-wall      s_wall_c          1 0 nil)
   (list 't_sh_hull_SW      "ship's hull"   pclass-wall      s_wall_d          1 0 nil)
   (list 't_mast            "mast"          pclass-wall      s_mast            1 0 nil)
   (list 't_ships_wheel     "ship's wheel"  pclass-wall      s_ships_wheel     1 0 nil)
   (list 't_deck            "deck"          pclass-grass     s_deck            1 0 nil)

   (list 't_boulder         "boulder"       pclass-boulder   s_boulder         1 0 nil)

   (list 't_wall_rock_v     "rock wall"     pclass-wall      s_wall_rock       1 0 nil)
   (list 't_wall_rock       "rock wall"     pclass-wall      s_wall_rock       0 0 nil)

   (list 't_wall_v          "wall"          pclass-wall      s_wall_stone      1 0 nil)
   (list 't_wall            "wall"          pclass-wall      s_wall_stone      0 0 nil)
   (list 't_fake_wall       "wall"          pclass-forest    s_wall_stone      0 0 nil)

   (list 't_wall_torch      "wall torch"    pclass-wall      s_wall_torch      0 1024 'burn)
   (list 't_arrow_slit      "arrow slit"    pclass-wall      s_arrow_slit      1 0 nil)
   (list 't_window_in_stone "window"        pclass-wall      s_window_in_stone 1 0 nil)

   (list 't_secret_door     "secret door"   pclass-grass     s_secret_door     0 0 nil)

   (list 't_sea_wall_v      "sea wall"      pclass-wall      s_wall            1 0 nil)
   (list 't_sea_wall        "sea wall"      pclass-wall      s_wall            0 0 nil)

   (list 't_sea_wall_NE     "sea wall"      pclass-wall      s_wall_b          0 0 nil)
   (list 't_sea_wall_NW     "sea wall"      pclass-wall      s_wall_a          0 0 nil)
   (list 't_sea_wall_SE     "sea wall"      pclass-wall      s_wall_c          0 0 nil)
   (list 't_sea_wall_SW     "sea wall"      pclass-wall      s_wall_d          0 0 nil)

   (list 't_ankh            "ankh"          pclass-wall      s_ankh            1 0 nil)
   (list 't_altar           "altar"         pclass-wall      s_altar           1 0 nil)
   (list 't_pillar          "pillar"        pclass-wall      s_pillar          1 0 nil)
   (list 't_false_pillar    "pillar"        pclass-grass     s_pillar          1 0 nil)

   (list 't_counter_2x1_w   "counter"       pclass-wall      s_counter_2x1_w   1 0 nil)
   (list 't_counter_2x1_c   "counter"       pclass-wall      s_counter_2x1_c   1 0 nil)
   (list 't_counter_2x1_e   "counter"       pclass-wall      s_counter_2x1_e   1 0 nil)
   (list 't_counter_1x1     "counter"       pclass-wall      s_counter_1x1     1 0 nil)

   (list 't_bridge_WE       "bridge"       pclass-bridge    s_ew_bridge        1 0 nil)
   (list 't_bridge_NS       "bridge"       pclass-bridge    s_ns_bridge        1 0 nil)
   (list 't_chasm           "chasm"         pclass-space     s_null            1 0 nil)

   (list 't_trail_0         "trail"         pclass-grass     s_trail_0         1 0 nil)
   (list 't_trail_1         "trail"         pclass-grass     s_trail_1         1 0 nil)
   (list 't_trail_2         "trail"         pclass-grass     s_trail_2         1 0 nil)
   (list 't_trail_3         "trail"         pclass-grass     s_trail_3         1 0 nil)
   (list 't_trail_4         "trail"         pclass-grass     s_trail_4         1 0 nil)
   (list 't_trail_5         "trail"         pclass-grass     s_trail_5         1 0 nil)
   (list 't_trail_6         "trail"         pclass-grass     s_trail_6         1 0 nil)
   (list 't_trail_7         "trail"         pclass-grass     s_trail_7         1 0 nil)
   (list 't_trail_8         "trail"         pclass-grass     s_trail_8         1 0 nil)
   (list 't_trail_9         "trail"         pclass-grass     s_trail_9         1 0 nil)
   (list 't_trail_a         "trail"         pclass-grass     s_trail_a         1 0 nil)
   (list 't_trail_b         "trail"         pclass-grass     s_trail_b         1 0 nil)
   (list 't_trail_c         "trail"         pclass-grass     s_trail_c         1 0 nil)
   (list 't_trail_d         "trail"         pclass-grass     s_trail_d         1 0 nil)
   (list 't_trail_e         "trail"         pclass-grass     s_trail_e         1 0 nil)
   (list 't_trail_f         "trail"         pclass-grass     s_trail_f         1 0 nil)

   (list 't_A               "an A"          pclass-wall      s_A               1 0 nil)
   (list 't_B               "a B"           pclass-wall      s_B               1 0 nil)
   (list 't_C               "a C"           pclass-wall      s_C               1 0 nil)
   (list 't_D               "a D"           pclass-wall      s_D               1 0 nil)
   (list 't_E               "an E"          pclass-wall      s_E               1 0 nil)
   (list 't_F               "an F"          pclass-wall      s_F               1 0 nil)
   (list 't_G               "a G"           pclass-wall      s_G               1 0 nil)
   (list 't_H               "an H"          pclass-wall      s_H               1 0 nil)
   (list 't_I               "an I"          pclass-wall      s_I               1 0 nil)
   (list 't_J               "a J"           pclass-wall      s_J               1 0 nil)
   (list 't_K               "a K"           pclass-wall      s_K               1 0 nil)
   (list 't_L               "an L"          pclass-wall      s_L               1 0 nil)
   (list 't_M               "an M"          pclass-wall      s_M               1 0 nil)
   (list 't_N               "an N"          pclass-wall      s_N               1 0 nil)
   (list 't_O               "an O"          pclass-wall      s_O               1 0 nil)
   (list 't_fake_O          "an O"          pclass-forest    s_O               1 0 nil)
   (list 't_P               "a P"           pclass-wall      s_P               1 0 nil)
   (list 't_Q               "a Q"           pclass-wall      s_Q               1 0 nil)
   (list 't_R               "an R"          pclass-wall      s_R               1 0 nil)
   (list 't_S               "an S"          pclass-wall      s_S               1 0 nil)
   (list 't_T               "a T"           pclass-wall      s_T               1 0 nil)
   (list 't_U               "a U"           pclass-wall      s_U               1 0 nil)
   (list 't_V               "a V"           pclass-wall      s_V               1 0 nil)
   (list 't_W               "a W"           pclass-wall      s_W               1 0 nil)
   (list 't_X               "an X"          pclass-wall      s_X               1 0 nil)
   (list 't_Y               "a Y"           pclass-wall      s_Y               1 0 nil)
   (list 't_Z               "a Z"           pclass-wall      s_Z               1 0 nil)

   (list 't_rune_A          "a rune"        pclass-wall      s_rune_A          1 0 nil)
   (list 't_rune_B          "a rune"        pclass-wall      s_rune_B          1 0 nil)
   (list 't_rune_C          "a rune"        pclass-wall      s_rune_C          1 0 nil)
   (list 't_rune_D          "a rune"        pclass-wall      s_rune_D          1 0 nil)
   (list 't_rune_E          "a rune"        pclass-wall      s_rune_E          1 0 nil)
   (list 't_rune_F          "a rune"        pclass-wall      s_rune_F          1 0 nil)
   (list 't_rune_G          "a rune"        pclass-wall      s_rune_G          1 0 nil)
   (list 't_rune_H          "a rune"        pclass-wall      s_rune_H          1 0 nil)
   (list 't_rune_I          "a rune"        pclass-wall      s_rune_I          1 0 nil)
   (list 't_rune_J          "a rune"        pclass-wall      s_rune_J          1 0 nil)
   (list 't_rune_K          "a rune"        pclass-wall      s_rune_K          1 0 nil)
   (list 't_rune_L          "a rune"        pclass-wall      s_rune_L          1 0 nil)
   (list 't_rune_M          "a rune"        pclass-wall      s_rune_M          1 0 nil)
   (list 't_rune_N          "a rune"        pclass-wall      s_rune_N          1 0 nil)
   (list 't_rune_O          "a rune"        pclass-wall      s_rune_O          1 0 nil)
   (list 't_rune_P          "a rune"        pclass-wall      s_rune_P          1 0 nil)
   (list 't_rune_Q          "a rune"        pclass-wall      s_rune_Q          1 0 nil)
   (list 't_rune_R          "a rune"        pclass-wall      s_rune_R          1 0 nil)
   (list 't_rune_S          "a rune"        pclass-wall      s_rune_S          1 0 nil)
   (list 't_rune_T          "a rune"        pclass-wall      s_rune_T          1 0 nil)
   (list 't_rune_U          "a rune"        pclass-wall      s_rune_U          1 0 nil)
   (list 't_rune_V          "a rune"        pclass-wall      s_rune_V          1 0 nil)
   (list 't_rune_W          "a rune"        pclass-wall      s_rune_W          1 0 nil)
   (list 't_rune_X          "a rune"        pclass-wall      s_rune_X          1 0 nil)
   (list 't_rune_Y          "a rune"        pclass-wall      s_rune_Y          1 0 nil)
   (list 't_rune_Z          "a rune"        pclass-wall      s_rune_Z          1 0 nil)
   (list 't_rune_TH         "a rune"        pclass-wall      s_rune_TH         1 0 nil)
   (list 't_rune_EE         "a rune"        pclass-wall      s_rune_EE         1 0 nil)
   (list 't_rune_NG         "a rune"        pclass-wall      s_rune_NG         1 0 nil)
   (list 't_rune_EA         "a rune"        pclass-wall      s_rune_EA         1 0 nil)
   (list 't_rune_ST         "a rune"        pclass-wall      s_rune_ST         1 0 nil)
   (list 't_rune_DOT        "a rune"        pclass-wall      s_rune_DOTSEP     1 0 nil)
   ))

(map (lambda (terrain) (apply kern-mk-terrain terrain)) terrains)

(define bad-terrain-list
  (list t_bog
        t_lava
        t_deep_lava
        t_fire_terrain
        t_fireplace
        t_inv_wall
        t_wall_torch
        ))

(define (is-bad-terrain? kter)
  (in-list? kter bad-terrain-list))
