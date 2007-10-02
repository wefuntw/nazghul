;;----------------------------------------------------------------------------
;; Sprites
;;----------------------------------------------------------------------------
;; 's_some_sprite ss_some_sprite_set num_tiles tile_number wave_sprite facing_value
;; 
;; facing_value is the sum of all facings provided by this sprite.
;; The value is determined by adding:
;;    1 NorthWest
;;    2 North
;;    4 NorthEast
;;    8 West
;;   16 Here
;;   32 East
;;   64 SouthWest
;;  128 South
;;  256 SouthEast
;;  512 Up
;; 1024 Down
;; 
;; Common values include:
;;   0 Default facing (only 1 facing, used for all directions)
;;  40 WE facing
;; 170 NSEW facing
;;----------------------------------------------------------------------------

;(kern-mk-sprite 's_deep          ss_u4_shapes 1  0 #t 0 )
;(kern-mk-sprite 's_shallow       ss_u4_shapes 1  1 #t 0 )
;(kern-mk-sprite 's_shoals        ss_u4_shapes 1  2 #t 0 )
(kern-mk-sprite 's_bog           ss_u4_shapes 1  3 #f 0 )
(kern-mk-sprite 's_grass         ss_u4_shapes 1  4 #f 0 )

;(kern-mk-sprite 's_trees         ss_u4_shapes 1  5 #f 0 )
;(kern-mk-sprite 's_forest        ss_u4_shapes 1  6 #f 0 )
;(kern-mk-sprite 's_hills         ss_u4_shapes 1  7 #f 0 )
;(kern-mk-sprite 's_mountains     ss_u4_shapes 1  8 #f 0 )
;(kern-mk-sprite 's_dungeon       ss_u4_shapes 1  9 #f 0 )
(kern-mk-sprite 's_town          ss_u4_shapes 1 10 #f 0 )
(kern-mk-sprite 's_keep          ss_u4_shapes 1 11 #f 0 )
(kern-mk-sprite 's_hamlet        ss_u4_shapes 1 12 #f 0 )
(kern-mk-sprite 's_leftwing      ss_u4_shapes 1 13 #f 0 )
(kern-mk-sprite 's_castle        ss_u4_shapes 1 14 #f 0 )
(kern-mk-sprite 's_rightwing     ss_u4_shapes 1 15 #f 0 )
(kern-mk-sprite 's_cobblestone   ss_u4_shapes 1 22 #f 0 )
(kern-mk-sprite 's_ew_bridge     ss_u4_shapes 1 23 #f 0 )
(kern-mk-sprite 's_ballon        ss_u4_shapes 1 24 #f 0 )
(kern-mk-sprite 's_bridge_top    ss_u4_shapes 1 25 #f 0 )
(kern-mk-sprite 's_bridge_bottom ss_u4_shapes 1 26 #f 0 )
(kern-mk-sprite 's_ladder_up     ss_u4_shapes 1 27 #f 0 )
(kern-mk-sprite 's_ladder_down   ss_u4_shapes 1 28 #f 0 )
(kern-mk-sprite 's_ruin          ss_u4_shapes 1 29 #f 0 )
(kern-mk-sprite 's_shrine        ss_u4_shapes 1 30 #f 0 )

(kern-mk-sprite 's_pillar      ss_u4_shapes 1 48 #f 0 )
(kern-mk-sprite 's_wall_b      ss_u4_shapes 1 49 #f 0 )
(kern-mk-sprite 's_wall_a      ss_u4_shapes 1 50 #f 0 )
(kern-mk-sprite 's_wall_c      ss_u4_shapes 1 51 #f 0 )
(kern-mk-sprite 's_wall_d      ss_u4_shapes 1 52 #f 0 )
(kern-mk-sprite 's_mast        ss_u4_shapes 1 53 #f 0 )
(kern-mk-sprite 's_ships_wheel ss_u4_shapes 1 54 #f 0 )
;(kern-mk-sprite 's_boulder     ss_u4_shapes 1 55 #f 0 )
;(kern-mk-sprite 's_asleep      ss_u4_shapes 1 56 #f 0 )
;(kern-mk-sprite 's_wall_rock   ss_u4_shapes 1 57 #f 0 )
(kern-mk-sprite 's_door_locked ss_u4_shapes 1 58 #f 0 )
(kern-mk-sprite 's_door        ss_u4_shapes 1 59 #f 0 )
(kern-mk-sprite 's_chest       ss_u4_shapes 1 60 #f 0 )
(kern-mk-sprite 's_ankh        ss_u4_shapes 1 61 #f 0 )
(kern-mk-sprite 's_flagstone   ss_u4_shapes 1 62 #f 0 )
(kern-mk-sprite 's_deck        ss_u4_shapes 1 63 #f 0 )

(kern-mk-sprite 's_moongate_quarter        ss_u4_shapes 1 64 #f 0 )
(kern-mk-sprite 's_moongate_half           ss_u4_shapes 1 65 #f 0 )
(kern-mk-sprite 's_moongate_three_quarters ss_u4_shapes 1 66 #f 0 )
(kern-mk-sprite 's_moongate_full           ss_u4_shapes 1 67 #f 0 )

(kern-mk-sprite 's_field_poison ss_u4_shapes 1 68 #t 0 )
(kern-mk-sprite 's_field_energy ss_u4_shapes 1 69 #t 0 )
(kern-mk-sprite 's_field_fire   ss_u4_shapes 1 70 #t 0 )
(kern-mk-sprite 's_field_sleep  ss_u4_shapes 1 71 #t 0 )
(kern-mk-sprite 's_wall         ss_u4_shapes 1 72 #f 0 )
(kern-mk-sprite 's_secret_door  ss_u4_shapes 1 73 #f 0 )
(kern-mk-sprite 's_altar        ss_u4_shapes 1 74 #f 0 )
(kern-mk-sprite 's_lava         ss_u4_shapes 1 76 #t 0 )
(kern-mk-sprite 's_projectile   ss_u4_shapes 1 77 #f 0 )
(kern-mk-sprite 's_magic        ss_u4_shapes 1 78 #f 0 )
;;(kern-mk-sprite 's_hit          ss_u4_shapes 1 79 #f 0 )
;;(kern-mk-sprite 's_guard        ss_u4_shapes 2 80 #f 0 )
;;(kern-mk-sprite 's_townsman     ss_u4_shapes 2 82 #f 0 )
;;(kern-mk-sprite 's_bard         ss_u4_shapes 2 84 #f 0 )
;;(kern-mk-sprite 's_jester       ss_u4_shapes 2 86 #f 0 )
;;(kern-mk-sprite 's_beggar       ss_u4_shapes 2 88 #f 0 )
;;(kern-mk-sprite 's_child        ss_u4_shapes 2 90 #f 0 )
(kern-mk-sprite 's_bull         ss_u4_shapes 2 92 #f 0 )
(kern-mk-sprite 's_lord         ss_u4_shapes 2 94 #f 0 )

(kern-mk-sprite 's_A ss_u4_shapes 1  96 #f 0 )
(kern-mk-sprite 's_B ss_u4_shapes 1  97 #f 0 )
(kern-mk-sprite 's_C ss_u4_shapes 1  98 #f 0 )
(kern-mk-sprite 's_D ss_u4_shapes 1  99 #f 0 )
(kern-mk-sprite 's_E ss_u4_shapes 1 100 #f 0 )
(kern-mk-sprite 's_F ss_u4_shapes 1 101 #f 0 )
(kern-mk-sprite 's_G ss_u4_shapes 1 102 #f 0 )
(kern-mk-sprite 's_H ss_u4_shapes 1 103 #f 0 )
(kern-mk-sprite 's_I ss_u4_shapes 1 104 #f 0 )
(kern-mk-sprite 's_J ss_u4_shapes 1 105 #f 0 )
(kern-mk-sprite 's_K ss_u4_shapes 1 106 #f 0 )
(kern-mk-sprite 's_L ss_u4_shapes 1 107 #f 0 )
(kern-mk-sprite 's_M ss_u4_shapes 1 108 #f 0 )
(kern-mk-sprite 's_N ss_u4_shapes 1 109 #f 0 )
(kern-mk-sprite 's_O ss_u4_shapes 1 110 #f 0 )
(kern-mk-sprite 's_P ss_u4_shapes 1 111 #f 0 )
(kern-mk-sprite 's_Q ss_u4_shapes 1 112 #f 0 )
(kern-mk-sprite 's_R ss_u4_shapes 1 113 #f 0 )
(kern-mk-sprite 's_S ss_u4_shapes 1 114 #f 0 )
(kern-mk-sprite 's_T ss_u4_shapes 1 115 #f 0 )
(kern-mk-sprite 's_U ss_u4_shapes 1 116 #f 0 )
(kern-mk-sprite 's_V ss_u4_shapes 1 117 #f 0 )
(kern-mk-sprite 's_W ss_u4_shapes 1 118 #f 0 )
(kern-mk-sprite 's_X ss_u4_shapes 1 119 #f 0 )
(kern-mk-sprite 's_Y ss_u4_shapes 1 120 #f 0 )
(kern-mk-sprite 's_Z ss_u4_shapes 1 121 #f 0 )

(kern-mk-sprite 's_counter_2x1_c ss_u4_shapes 1 122 #f 0 )
(kern-mk-sprite 's_counter_2x1_e ss_u4_shapes 1 123 #f 0 )
(kern-mk-sprite 's_counter_2x1_w ss_u4_shapes 1 124 #f 0 )
(kern-mk-sprite 's_counter_1x1   ss_u4_shapes 1 125 #f 0 )

(kern-mk-sprite 's_blank          ss_u4_shapes 1 126 #f 0 )
(kern-mk-sprite 's_null           ss_u4_shapes 1 126 #f 0 )
(kern-mk-sprite 's_wall_stone     ss_u4_shapes 1 127 #f 0 )

(kern-mk-sprite 's_pirate_left    ss_u4_shapes 1 128 #f 0 )
(kern-mk-sprite 's_pirate_front   ss_u4_shapes 1 129 #f 0 )
(kern-mk-sprite 's_pirate_right   ss_u4_shapes 1 130 #f 0 )
(kern-mk-sprite 's_pirate_back    ss_u4_shapes 1 131 #f 0 )

;;(kern-mk-sprite 's_nixie          ss_u4_shapes 2 132 #f 0 )
(kern-mk-sprite 's_kraken         ss_u4_shapes 2 134 #f 0 )
(kern-mk-sprite 's_sea_serpent    ss_u4_shapes 2 136 #f 0 )
(kern-mk-sprite 's_sea_horse      ss_u4_shapes 2 138 #f 0 )
(kern-mk-sprite 's_whirlpool      ss_u4_shapes 2 140 #f 0 )
(kern-mk-sprite 's_tornado        ss_u4_shapes 2 142 #f 0 )

(kern-mk-sprite 's_rat            ss_u4_shapes 4 144 #f 0 )
(kern-mk-sprite 's_bat            ss_u4_shapes 4 148 #f 0 )
(kern-mk-sprite 's_spider         ss_u4_shapes 4 152 #f 0 )
(kern-mk-sprite 's_ghost          ss_u4_shapes 4 156 #f 0 )
(kern-mk-sprite 's_slime          ss_u4_shapes 4 160 #f 0 )
(kern-mk-sprite 's_slime_asleep   ss_u4_shapes 1 160 #f 0 )
;;(kern-mk-sprite 's_troll          ss_u4_shapes 4 164 #f 0 )
(kern-mk-sprite 's_gremlin        ss_u4_shapes 4 168 #f 0 )
(kern-mk-sprite 's_mimic          ss_u4_shapes 4 172 #f 0 )
(kern-mk-sprite 's_reaper         ss_u4_shapes 4 176 #f 0 )
(kern-mk-sprite 's_insects        ss_u4_shapes 4 180 #f 0 )
;;(kern-mk-sprite 's_gazer          ss_u4_shapes 4 184 #f 0 )
(kern-mk-sprite 's_deathknight         ss_u4_shapes 4 188 #f 0 )
(kern-mk-sprite 's_orc            ss_u4_shapes 4 192 #f 0 )
;;(kern-mk-sprite 's_skeleton       ss_u4_shapes 4 196 #f 0 )
;;(kern-mk-sprite 's_brigand        ss_u4_shapes 4 200 #f 0 )
(kern-mk-sprite 's_snake          ss_u4_shapes 4 204 #f 0 )
;;(kern-mk-sprite 's_ettin          ss_u4_shapes 4 208 #f 0 )
;;(kern-mk-sprite 's_headless       ss_u4_shapes 4 212 #f 0 )
(kern-mk-sprite 's_cyclops        ss_u4_shapes 4 216 #f 0 )
(kern-mk-sprite 's_wisp           ss_u4_shapes 4 220 #f 0 )
;;(kern-mk-sprite 's_wizard         ss_u4_shapes 4 224 #f 0 )
;;(kern-mk-sprite 's_lich           ss_u4_shapes 4 228 #f 0 )
(kern-mk-sprite 's_drake          ss_u4_shapes 4 232 #f 0 )
(kern-mk-sprite 's_zorn           ss_u4_shapes 4 236 #f 0 )
;;(kern-mk-sprite 's_demon          ss_u4_shapes 4 240 #f 0 )
(kern-mk-sprite 's_hydra          ss_u4_shapes 4 244 #f 0 )
;;(kern-mk-sprite 's_dragon         ss_u4_shapes 4 248 #f 0 )
;;(kern-mk-sprite 's_balron         ss_u4_shapes 4 252 #f 0 )

(kern-mk-sprite 's_frame_ulc   ss_frame 1  0 #f 0 )
(kern-mk-sprite 's_frame_td    ss_frame 1  1 #f 0 )
(kern-mk-sprite 's_frame_urc   ss_frame 1  2 #f 0 )
(kern-mk-sprite 's_frame_endu  ss_frame 1  3 #f 0 )  ; top of vertical bar, currently unused
(kern-mk-sprite 's_frame_tr    ss_frame 1  4 #f 0 )
(kern-mk-sprite 's_frame_plus  ss_frame 1  5 #f 0 )  ; center crosspiece, currently unused
(kern-mk-sprite 's_frame_tl    ss_frame 1  6 #f 0 )
(kern-mk-sprite 's_frame_vert  ss_frame 1  7 #f 0 )
(kern-mk-sprite 's_frame_llc   ss_frame 1  8 #f 0 )
(kern-mk-sprite 's_frame_tu    ss_frame 1  9 #f 0 )
(kern-mk-sprite 's_frame_lrc   ss_frame 1 10 #f 0 )
(kern-mk-sprite 's_frame_endb  ss_frame 1 11 #f 0 )  ; bottom of vertical bar, currently unused
(kern-mk-sprite 's_frame_endl  ss_frame 1 12 #f 0 )
(kern-mk-sprite 's_frame_horz  ss_frame 1 13 #f 0 )
(kern-mk-sprite 's_frame_endr  ss_frame 1 14 #f 0 )
(kern-mk-sprite 's_frame_dot   ss_frame 1 15 #f 0 )  ; disconnected disk, currently unused

(kern-mk-sprite 'ls_ankh          ss_u4_charset 1  0 #f 0 )
(kern-mk-sprite 'ls_shield        ss_u4_charset 1  1 #f 0 )
(kern-mk-sprite 'ls_holey_wall    ss_u4_charset 1  2 #f 0 )
(kern-mk-sprite 'ls_wall          ss_u4_charset 1  3 #f 0 )
(kern-mk-sprite 'ls_updown_arrow  ss_u4_charset 1  4 #f 0 )
(kern-mk-sprite 'ls_down_arrow    ss_u4_charset 1  5 #f 0 )
(kern-mk-sprite 'ls_up_arrow      ss_u4_charset 1  6 #f 0 )
(kern-mk-sprite 'ls_holey_ankh    ss_u4_charset 1  7 #f 0 )
(kern-mk-sprite 'ls_white_ball    ss_u4_charset 1  8 #f 0 )
(kern-mk-sprite 'ls_copyright     ss_u4_charset 1  9 #f 0 )
(kern-mk-sprite 'ls_trademark     ss_u4_charset 1 10 #f 0 )
(kern-mk-sprite 'ls_male          ss_u4_charset 1 11 #f 0 )
(kern-mk-sprite 'ls_female        ss_u4_charset 1 12 #f 0 )
(kern-mk-sprite 'ls_hbar          ss_u4_charset 1 13 #f 0 )
(kern-mk-sprite 'ls_vbar          ss_u4_charset 1 13 #f 0 )
(kern-mk-sprite 'ls_square        ss_u4_charset 1 14 #f 0 )
(kern-mk-sprite 'ls_blue_ball     ss_u4_charset 1 15 #f 0 )
(kern-mk-sprite 'ls_hbar_right    ss_u4_charset 1 16 #f 0 )
(kern-mk-sprite 'ls_hbar_left     ss_u4_charset 1 17 #f 0 )
(kern-mk-sprite 'ls_vbar_top      ss_u4_charset 1 16 #f 0 )
(kern-mk-sprite 'ls_vbar_bottom   ss_u4_charset 1 17 #f 0 )
(kern-mk-sprite 'ls_blank_one     ss_u4_charset 1 18 #f 0 )
(kern-mk-sprite 'ls_dot_dot_dot   ss_u4_charset 1 19 #f 0 )
(kern-mk-sprite 'ls_whirlpool     ss_u4_charset 4 28 #f 0 )
(kern-mk-sprite 'ls_blank_three   ss_u4_charset 1 32 #f 0 )

(kern-mk-sprite 's_rune_A      ss_rune 1  0 #f 0 )
(kern-mk-sprite 's_rune_B      ss_rune 1  1 #f 0 )
(kern-mk-sprite 's_rune_C      ss_rune 1  2 #f 0 )
(kern-mk-sprite 's_rune_D      ss_rune 1  3 #f 0 )
(kern-mk-sprite 's_rune_E      ss_rune 1  4 #f 0 )
(kern-mk-sprite 's_rune_F      ss_rune 1  5 #f 0 )
(kern-mk-sprite 's_rune_G      ss_rune 1  6 #f 0 )
(kern-mk-sprite 's_rune_H      ss_rune 1  7 #f 0 )
(kern-mk-sprite 's_rune_I      ss_rune 1  8 #f 0 )
(kern-mk-sprite 's_rune_J      ss_rune 1  9 #f 0 )
(kern-mk-sprite 's_rune_K      ss_rune 1 10 #f 0 )
(kern-mk-sprite 's_rune_L      ss_rune 1 11 #f 0 )
(kern-mk-sprite 's_rune_M      ss_rune 1 12 #f 0 )
(kern-mk-sprite 's_rune_N      ss_rune 1 13 #f 0 )
(kern-mk-sprite 's_rune_O      ss_rune 1 14 #f 0 )
(kern-mk-sprite 's_rune_P      ss_rune 1 15 #f 0 )
(kern-mk-sprite 's_rune_Q      ss_rune 1 16 #f 0 )
(kern-mk-sprite 's_rune_R      ss_rune 1 17 #f 0 )
(kern-mk-sprite 's_rune_S      ss_rune 1 18 #f 0 )
(kern-mk-sprite 's_rune_T      ss_rune 1 19 #f 0 )
(kern-mk-sprite 's_rune_U      ss_rune 1 20 #f 0 )
(kern-mk-sprite 's_rune_V      ss_rune 1 21 #f 0 )
(kern-mk-sprite 's_rune_W      ss_rune 1 22 #f 0 )
(kern-mk-sprite 's_rune_X      ss_rune 1 23 #f 0 )
(kern-mk-sprite 's_rune_Y      ss_rune 1 24 #f 0 )
(kern-mk-sprite 's_rune_Z      ss_rune 1 25 #f 0 )
(kern-mk-sprite 's_rune_TH     ss_rune 1 26 #f 0 )
(kern-mk-sprite 's_rune_EE     ss_rune 1 27 #f 0 )
(kern-mk-sprite 's_rune_NG     ss_rune 1 28 #f 0 )
(kern-mk-sprite 's_rune_EA     ss_rune 1 29 #f 0 )
(kern-mk-sprite 's_rune_ST     ss_rune 1 30 #f 0 )
(kern-mk-sprite 's_rune_DOTSEP ss_rune 1 31 #f 0 )

(kern-mk-sprite 's_crosshair            ss_addon 1  0 #f   0 )
(kern-mk-sprite 's_blackgate_quarter        ss_addon 1 1 #f 0 )
(kern-mk-sprite 's_blackgate_half           ss_addon 1 2 #f 0 )
(kern-mk-sprite 's_blackgate_three_quarters ss_addon 1 3 #f 0 )
(kern-mk-sprite 's_blackgate_full           ss_addon 1 4 #f 0 )
(kern-mk-sprite 's_horse                ss_addon 1  5 #f  40 )
(kern-mk-sprite 's_happy_monster_face   ss_addon 1  7 #f   0 )
(kern-mk-sprite 's_ship                 ss_addon 1  8 #f 170 )
(kern-mk-sprite 's_queen_spider         ss_addon 4 12 #f 0 )
(kern-mk-sprite 's_hdoor                ss_addon 1 19 #f 0 )
(kern-mk-sprite 's_hdoor_locked         ss_addon 1 20 #f 0 )
(kern-mk-sprite 's_portcullis_down      ss_addon 1 21 #f 0 )
(kern-mk-sprite 's_portcullis_up        ss_addon 1 22 #f 0 )
(kern-mk-sprite 's_forest_yellow        ss_addon 1 23 #f 0 )
(kern-mk-sprite 's_L_lever_up           ss_addon 1 24 #f 0 )
(kern-mk-sprite 's_L_lever_down         ss_addon 1 25 #f 0 )
(kern-mk-sprite 's_R_lever_up           ss_addon 1 26 #f 0 )
(kern-mk-sprite 's_R_lever_down         ss_addon 1 27 #f 0 )
(kern-mk-sprite 's_floor_plate          ss_addon 1 28 #f 0 )
(kern-mk-sprite 's_ns_bridge            ss_addon 1 29 #f 0 )
(kern-mk-sprite 's_forest_purple        ss_addon 1 30 #f 0 )
(kern-mk-sprite 's_forest_red           ss_addon 1 31 #f 0 )
(kern-mk-sprite 's_trees_orange         ss_addon 1 32 #f 0 )
(kern-mk-sprite 's_trees_yellow         ss_addon 1 33 #f 0 )
(kern-mk-sprite 's_trees_purple         ss_addon 1 34 #f 0 )
(kern-mk-sprite 's_trees_red            ss_addon 1 35 #f 0 )
(kern-mk-sprite 's_bed                  ss_addon 1 36 #f 0 )
(kern-mk-sprite 's_fireplace            ss_addon 2 37 #f 0 )
;;(kern-mk-sprite 's_gwen                 ss_addon 2 40 #f 0 )
(kern-mk-sprite 's_yellow_slime         ss_addon 4 42 #f 0 )
(kern-mk-sprite 's_yellow_slime_asleep  ss_addon 1 42 #f 0 )
(kern-mk-sprite 's_wall_torch           ss_addon 2 46 #f 0 )
(kern-mk-sprite 's_water_elemental      ss_addon 1 48 #t 0 )
(kern-mk-sprite 's_toy_horse                                  ss_addon 1 55 #f 0 )
;;(kern-mk-sprite 's_closed_solid_wood_door_in_stone            ss_addon 1 49 #f 0 )
;;(kern-mk-sprite 's_open_door_in_stone                         ss_addon 1 50 #f 0 )
;;(kern-mk-sprite 's_locked_solid_wood_door_in_stone            ss_addon 1 51 #f 0 )
;;(kern-mk-sprite 's_magically_locked_solid_wood_door_in_stone  ss_addon 3 52 #f 0 )
(kern-mk-sprite 's_rock_arch                                    ss_addon 1 49 #f 0 )
(kern-mk-sprite 's_stone_arch                                   ss_addon 1 50 #f 0 )
(kern-mk-sprite 's_door_wood                                    ss_addon 1 51 #f 0 )
(kern-mk-sprite 's_door_lock                                    ss_addon 1 52 #f 0 )
(kern-mk-sprite 's_door_windowed                                ss_addon 1 53 #f 0 )
(kern-mk-sprite 's_door_magiclock                               ss_addon 3 59 #f 0 )
;;(kern-mk-sprite 's_closed_solid_wood_door_in_rock             ss_addon 1 56 #f 0 )
;;(kern-mk-sprite 's_open_door_in_rock                          ss_addon 1 57 #f 0 )
;;(kern-mk-sprite 's_locked_solid_wood_door_in_rock             ss_addon 1 58 #f 0 )
;;(kern-mk-sprite 's_magically_locked_solid_wood_door_in_rock   ss_addon 3 59 #f 0 )
;;(kern-mk-sprite 's_closed_windowed_wood_door_in_rock          ss_addon 1 68 #f 0 )
;;(kern-mk-sprite 's_locked_windowed_wood_door_in_rock          ss_addon 1 69 #f 0 )
(kern-mk-sprite 's_spider_web                                 ss_addon 1 70 #f 0)
(kern-mk-sprite 's_corpse                                     ss_addon 1 71 #f 0)
;;(kern-mk-sprite 's_magically_locked_windowed_wood_door_in_rock ss_addon 3 76 #f 0 )
(kern-mk-sprite 's_deep_lava                                   ss_addon 1 79 #t 0)
(kern-mk-sprite 's_golden_skeleton_key  ss_addon 1 77 #f 0)
(kern-mk-sprite 's_arrow_slit       ss_addon 1 62 #f 0 )
(kern-mk-sprite 's_window_in_stone  ss_addon 1 63 #f 0 )
(kern-mk-sprite 's_trail_0  ss_addon 1 64 #f 0 )
(kern-mk-sprite 's_trail_1  ss_addon 1 65 #f 0 )
(kern-mk-sprite 's_trail_2  ss_addon 1 66 #f 0 )
(kern-mk-sprite 's_trail_3  ss_addon 1 67 #f 0 )
(kern-mk-sprite 's_trail_4  ss_addon 1 72 #f 0 )
(kern-mk-sprite 's_trail_5  ss_addon 1 73 #f 0 )
(kern-mk-sprite 's_trail_6  ss_addon 1 74 #f 0 )
(kern-mk-sprite 's_trail_7  ss_addon 1 75 #f 0 )
(kern-mk-sprite 's_trail_8  ss_addon 1 80 #f 0 )
(kern-mk-sprite 's_trail_9  ss_addon 1 81 #f 0 )
(kern-mk-sprite 's_trail_a  ss_addon 1 82 #f 0 )
(kern-mk-sprite 's_trail_b  ss_addon 1 83 #f 0 )
;;(kern-mk-sprite 's_chanticleer ss_addon 2 84 #f 0)
(kern-mk-sprite 's_stars       ss_addon 2 86 #f 0)
(kern-mk-sprite 's_trail_c  ss_addon 1 88 #f 0 )
(kern-mk-sprite 's_trail_d  ss_addon 1 89 #f 0 )
(kern-mk-sprite 's_trail_e  ss_addon 1 90 #f 0 )
(kern-mk-sprite 's_trail_f  ss_addon 1 91 #f 0 )
(kern-mk-sprite 's_townswoman ss_addon 2 92 #f 0)
;;(kern-mk-sprite 's_fat_townswoman ss_addon 2 97 #f 0)
;;(kern-mk-sprite 's_lady ss_addon 2 99 #f 0)
;;(kern-mk-sprite 's_doorway ss_addon 1 101 #f 0)
(kern-mk-sprite 's_goblin_child ss_addon 2 102 #f 0)
(kern-mk-sprite 's_purple_spider ss_addon 4 104 #f 0)
;;(kern-mk-sprite 's_brigandess ss_addon 4 108 #f 0)
(kern-mk-sprite 's_wolf ss_addon 4 112 #f 0)
(kern-mk-sprite 's_void_ship ss_addon 1 116 #f 170)
;;(kern-mk-sprite 's_human_knight ss_addon 4 120 #f 0 )
(kern-mk-sprite 's_red_slime ss_addon 4 124 #f 0)
(kern-mk-sprite 's_red_slime_asleep ss_addon 1 124 #f 0)
(kern-mk-sprite 's_active_altar ss_addon 4 128 #f 0)
(kern-mk-sprite 's_tentacle ss_addon 4 132 #f 0)
(kern-mk-sprite 's_sludge ss_addon 1 136 #t 0)
(kern-mk-sprite 's_dirt ss_addon 1 137 #f 0)
(kern-mk-sprite 's_gravel ss_addon 1 138 #f 0)
(kern-mk-sprite 's_great_kraken ss_addon 2 139 #f 0)
(kern-mk-sprite 's_shallow_sludge ss_addon 1 143 #t 0)
(kern-mk-sprite 's_weather_vane ss_addon 1 144 #f 170)
(kern-mk-sprite 's_mouse        ss_addon 2 148 #f 0)
(kern-mk-sprite 's_eye_closed   ss_addon 1 150 #f 0)
(kern-mk-sprite 's_eye_open     ss_addon 1 151 #f 0)

(kern-mk-sprite 's_full_moon                ss_moons 1 0 #f 0 )
(kern-mk-sprite 's_wane_three_quarter_moon  ss_moons 1 1 #f 0 )
(kern-mk-sprite 's_wane_half_moon           ss_moons 1 2 #f 0 )
(kern-mk-sprite 's_wane_quarter_moon        ss_moons 1 3 #f 0 )
(kern-mk-sprite 's_new_moon                 ss_moons 1 4 #f 0 )
(kern-mk-sprite 's_wax_quarter_moon         ss_moons 1 5 #f 0 )
(kern-mk-sprite 's_wax_half_moon            ss_moons 1 6 #f 0 )
(kern-mk-sprite 's_wax_three_quarter_moon   ss_moons 1 7 #f 0 )
(kern-mk-sprite 's_sun                      ss_moons 1 8 #f 0 )

(kern-mk-sprite 's_torch_sign ss_signs     1 0 #f 0)
(kern-mk-sprite 's_shield_sign ss_signs    1 1 #f 0)
(kern-mk-sprite 's_ankh_sign ss_signs      1 2 #f 0)
(kern-mk-sprite 's_beer_sign ss_signs      1 3 #f 0)
(kern-mk-sprite 's_bed_sign ss_signs       1 4 #f 0)
(kern-mk-sprite 's_potion_sign ss_signs    1 5 #f 0)
(kern-mk-sprite 's_mushroom_sign ss_signs  1 6 #f 0)
(kern-mk-sprite 's_axe_sign ss_signs  1 8 #f 0)
(kern-mk-sprite 's_key_sign ss_signs  1 9 #f 0)
(kern-mk-sprite 's_book_sign ss_signs  1 10 #f 0)

(define (mk-sprite tag offset)
  (kern-mk-sprite tag ss_runestones 1 offset #f 0))
(mk-sprite 's_runestone_a 0)
(mk-sprite 's_runestone_b 1) 
(mk-sprite 's_runestone_c 2) 
(mk-sprite 's_runestone_d 3)
(mk-sprite 's_runestone_e 4)
(mk-sprite 's_runestone_f 5)
(mk-sprite 's_runestone_g 6)
(mk-sprite 's_runestone_h 7)
(mk-sprite 's_runestone_i 8)
(mk-sprite 's_runestone_j 9)
(mk-sprite 's_runestone_k 10)
(mk-sprite 's_runestone_l 11)
(mk-sprite 's_runestone_m 12)
(mk-sprite 's_runestone_n 13)
(mk-sprite 's_runestone_o 14)
(mk-sprite 's_runestone_p 15)
(mk-sprite 's_runestone_q 16)
(mk-sprite 's_runestone_r 17)
(mk-sprite 's_runestone_s 18)
(mk-sprite 's_runestone_t 19)
(mk-sprite 's_runestone_u 20)
(mk-sprite 's_runestone_v 21)
(mk-sprite 's_runestone_w 22)
(mk-sprite 's_runestone_x 23)
(mk-sprite 's_runestone_y 24)
(mk-sprite 's_runestone_z 25)
(mk-sprite 's_runestone_ankh 31)

(kern-mk-sprite 's_fgob_stalker ss_humanoids  4 0 #f 0 )
(kern-mk-sprite 's_fgob_archer ss_humanoids   4 8 #f 0 )
(kern-mk-sprite 's_fgob_civilian ss_humanoids 4 16 #f 0 )
(kern-mk-sprite 's_fgob_shaman ss_humanoids   4 24 #f 0 )
(kern-mk-sprite 's_cgob_berserk ss_humanoids  4 4 #f 0 )
(kern-mk-sprite 's_cgob_slinger ss_humanoids  4 12 #f 0 )
(kern-mk-sprite 's_cgob_civilian ss_humanoids 4 20 #f 0 )
(kern-mk-sprite 's_cgob_shaman ss_humanoids   4 28 #f 0 )
(kern-mk-sprite 's_gint_party ss_humanoids 4 32 #f 0 )
(kern-mk-sprite 's_deathknight ss_humanoids 4 36 #f 0 )
(kern-mk-sprite 's_gint_mage_party ss_humanoids 4 40 #f 0 )
(kern-mk-sprite 's_troll ss_humanoids 4 48 #f 0 )
(kern-mk-sprite 's_troll_geomancer ss_humanoids 4 44 #f 0 )
(kern-mk-sprite 's_headless ss_humanoids 4 52 #f 0 )
(kern-mk-sprite 's_demon ss_humanoids 4 56 #f 0 )
(kern-mk-sprite 's_ratling ss_humanoids 4 64 #f 0)
(kern-mk-sprite 's_ratling_sorcerer ss_humanoids 4 68 #f 0)
(kern-mk-sprite 's_deatharcher ss_humanoids 4 72 #f 0 )
(kern-mk-sprite 's_skeleton       ss_humanoids 4 76 #f 0 )
(kern-mk-sprite 's_spearskeleton     ss_humanoids 4 80 #f 0 )
(kern-mk-sprite 's_skeletonarcher    ss_humanoids 4 84 #f 0 )
(kern-mk-sprite 's_lich           ss_humanoids 4 88 #f 0 )
(kern-mk-sprite 's_nixie_civilian    ss_humanoids 4 92 #f 0 )
(kern-mk-sprite 's_nixie_spear          ss_humanoids 4 96 #f 0 )
(kern-mk-sprite 's_nixie_sword          ss_humanoids 4 100 #f 0 )

(kern-mk-sprite 's_gint ss_bigobjects 4 0 #f 0 )
(kern-mk-sprite 's_gint_mage ss_bigobjects 4 4 #f 0 )
(kern-mk-sprite 's_balron   ss_bigobjects 4 8 #f 0 )
(kern-mk-sprite 's_dragon   ss_bigobjects 4 16 #f 0 )
(kern-mk-sprite 's_dragon_asleep   ss_bigobjects 1 20 #f 0 )

;;----------------------------------------------------------------------------
;;;; (kern-mk-sprite 's_wanderer ss_addon 2 94 #f 0)
;;;; (kern-mk-sprite 's_avatar             ss_u4_shapes 1 31 #f 0 )
;;;; (kern-mk-sprite 's_companion_wizard   ss_u4_shapes 2 32 #f 0 )
;;;; (kern-mk-sprite 's_companion_bard     ss_u4_shapes 2 34 #f 0 )
;;;; (kern-mk-sprite 's_companion_fighter  ss_u4_shapes 2 36 #f 0 )
;;;; (kern-mk-sprite 's_companion_druid    ss_u4_shapes 2 38 #f 0 )
;;;; (kern-mk-sprite 's_companion_tinker   ss_u4_shapes 2 40 #f 0 )
;;;; (kern-mk-sprite 's_companion_paladin  ss_u4_shapes 2 42 #f 0 )
;;;; (kern-mk-sprite 's_companion_ranger   ss_u4_shapes 2 44 #f 0 )
;;;; (kern-mk-sprite 's_companion_shepherd ss_u4_shapes 2 46 #f 0 )

(kern-mk-sprite 's_wanderer ss_people 4 0 #f 0 )
(kern-mk-sprite 's_avatar   ss_people 4 4 #f 0 )
(kern-mk-sprite 's_companion_wizard ss_people 4 8 #f 0 )
(kern-mk-sprite 's_companion_bard ss_people 4 12 #f 0 )
(kern-mk-sprite 's_companion_fighter ss_people 4 16 #f 0 )
(kern-mk-sprite 's_companion_druid ss_people 4 20 #f 0 )
(kern-mk-sprite 's_companion_tinker ss_people 4 24 #f 0 )
(kern-mk-sprite 's_companion_paladin ss_people 4 28 #f 0 )
(kern-mk-sprite 's_companion_ranger ss_people 4 32 #f 0 )
(kern-mk-sprite 's_companion_shepherd ss_people 4 36 #f 0 )
(kern-mk-sprite 's_old_mage ss_people 4 40 #f 0 )
(kern-mk-sprite 's_black_mage ss_people 4 44 #f 0 )
(kern-mk-sprite 's_guard ss_people 4 48 #f 0 )
(kern-mk-sprite 's_plain_mage ss_people 4 52 #f 0 )
(kern-mk-sprite 's_townsman ss_people 2 56 #f 0 )
(kern-mk-sprite 's_townswoman ss_people 2 58 #f 0 )
(kern-mk-sprite 's_brigand ss_people 4 60 #f 0 )
(kern-mk-sprite 's_red_wizard ss_people 4 64 #f 0 )
(kern-mk-sprite 's_xbowguard ss_people 2 68 #f 0 )
(kern-mk-sprite 's_lady ss_people 2 70 #f 0 )
(kern-mk-sprite 's_cloaked_female ss_people 4 72 #f 0 )
(kern-mk-sprite 's_brigandess ss_people 4 76 #f 0 )
(kern-mk-sprite 's_fat_townswoman ss_people 4 80 #f 0 )
(kern-mk-sprite 's_knight ss_people 4 84 #f 0 )
(kern-mk-sprite 's_minstrel ss_people 2 88 #f 0 )
(kern-mk-sprite 's_beggar ss_people 2 90 #f 0 )
(kern-mk-sprite 's_jester ss_people 4 92 #f 0 )
(kern-mk-sprite 's_child ss_people 2 96 #f 0 )
(kern-mk-sprite 's_asleep      ss_people 1 98 #f 0 )
(kern-mk-sprite 's_ranger_captain ss_people 4 104 #f 0)
(kern-mk-sprite 's_old_ranger ss_people 4 108 #f 0)
(kern-mk-sprite 's_old_townsman ss_people 4 112 #f 0)

(kern-mk-sprite 's_carabid ss_monsters 4 0 #f 0)
(kern-mk-sprite 's_carabid_asleep ss_monsters 1 0 #f 0)
(kern-mk-sprite 's_griffin ss_monsters 4 4 #f 0)
(kern-mk-sprite 's_griffin_asleep ss_monsters 1 4 #f 0)
(kern-mk-sprite 's_griffin_chick ss_monsters 4 12 #f 0)
(kern-mk-sprite 's_griffin_chick_asleep ss_monsters 1 12 #f 0)
(kern-mk-sprite 's_gazer          ss_monsters 4 8 #f 0 )
(kern-mk-sprite 's_gazer_asleep   ss_monsters 1 16 #f 0 )
(kern-mk-sprite 's_dragon_party   ss_monsters 4 20 #f 0 )

(kern-mk-sprite 's_tower ss_buildings 2 0 #f 0)

(kern-mk-sprite 's_trees         ss_overlays 1  20 #f 0 )
(kern-mk-sprite 's_forest        ss_overlays 1  21 #f 0 )
(kern-mk-sprite 's_hills         ss_overlays 1  22 #f 0 )
(kern-mk-sprite 's_mountains     ss_overlays 1  23 #f 0 )
(kern-mk-sprite 's_dungeon       ss_overlays 1  24 #f 0 )
(kern-mk-sprite 's_statue        ss_overlays 1  25 #f 0 )
;(kern-mk-sprite 's_secret_rock   ss_overlays 1  26 #f 0 )
(kern-mk-sprite 's_blank   		 ss_overlays 1  27 #f 0 )
(kern-mk-sprite 's_boulder_over  ss_overlays 1  68 #f 0 )
(kern-mk-sprite 's_boulder       ss_overlays 1  69 #f 0 )
(kern-mk-sprite 's_wall_rock     ss_overlays 1  72 #f 0 )
(kern-mk-sprite 's_secret_rock     ss_overlays 1  73 #f 0 )
(kern-mk-sprite 's_window_in_rock     ss_overlays 1  74 #f 0 )
(kern-mk-sprite 's_nat_rock           ss_overlays 1  75 #f 0 )
(kern-mk-sprite 's_nat_rock_s         ss_overlays 1  76 #f 0 )
(kern-mk-sprite 's_nat_rock_n         ss_overlays 1  77 #f 0 )
(kern-mk-sprite 's_nat_rock_w         ss_overlays 1  78 #f 0 )
(kern-mk-sprite 's_nat_rock_e         ss_overlays 1  79 #f 0 )


(kern-mk-sprite 's_bulwark_ew     ss_ship 1  0 #f 0 )
(kern-mk-sprite 's_bulwark_ns     ss_ship 1  1 #f 0 )
(kern-mk-sprite 's_deck_w         ss_ship 1  2 #f 0 )
(kern-mk-sprite 's_deck_e         ss_ship 1  3 #f 0 )
(kern-mk-sprite 's_deck_n         ss_ship 1  4 #f 0 )
(kern-mk-sprite 's_deck_s         ss_ship 1  5 #f 0 )
(kern-mk-sprite 's_stair_n         ss_ship 1  6 #f 0 )
(kern-mk-sprite 's_stair_s         ss_ship 1  7 #f 0 )
(kern-mk-sprite 's_bulwark_ne         ss_ship 1 8 #f 0 )
(kern-mk-sprite 's_bulwark_se         ss_ship 1 9 #f 0 )
(kern-mk-sprite 's_bulwark_nw         ss_ship 1 10 #f 0 )
(kern-mk-sprite 's_bulwark_sw         ss_ship 1 11 #f 0 )
(kern-mk-sprite 's_stair_w         ss_ship 1  12 #f 0 )
(kern-mk-sprite 's_stair_e         ss_ship 1  13 #f 0 )
(kern-mk-sprite 's_tank_d         ss_ship 1  14 #f 0 )
(kern-mk-sprite 's_tank_l         ss_ship 1  15 #f 0 )
(kern-mk-sprite 's_tank_nw         ss_ship 1  16 #f 0 )
(kern-mk-sprite 's_tank_ne         ss_ship 1  17 #f 0 )
(kern-mk-sprite 's_tank_sw         ss_ship 1  24 #f 0 )
(kern-mk-sprite 's_tank_se         ss_ship 1  25 #f 0 )
(kern-mk-sprite 's_shipswheel      ss_ship 1  18 #f 170 )
(kern-mk-sprite 's_cannon          ss_ship 1  26 #f 170 )

;;----------------------------------------------------------------------------
;; Terrain overlay pieces
(define (mk-sprite tag offset)
  (kern-mk-sprite tag ss_overlays 1 offset #f 0))
(mk-sprite 's_grass_nw 0)
(mk-sprite 's_grass_ne 1)
(mk-sprite 's_grass_se 2)
(mk-sprite 's_grass_sw 3)
(mk-sprite 's_grass_n  8)
(mk-sprite 's_grass_e  9)
(mk-sprite 's_grass_s  10)
(mk-sprite 's_grass_w  11)

;;----------------------------------------------------------------------------
;; Hill overlay pieces
(define (mk-sprite tag offset)
  (kern-mk-sprite tag ss_overlays 1 offset #f 0))
(mk-sprite 's_hill_e  12)
(mk-sprite 's_hill_s  13)
(mk-sprite 's_hill_w  14)
(mk-sprite 's_hill_n  15)

;;----------------------------------------------------------------------------
;; Trees overlay pieces
(mk-sprite 's_treesi_nw 28)
(mk-sprite 's_treesi_ne 29)
(mk-sprite 's_treesi_se 30)
(mk-sprite 's_treesi_sw 31)
(mk-sprite 's_treeso_nw 32)
(mk-sprite 's_treeso_ne 33)
(mk-sprite 's_treeso_se 34)
(mk-sprite 's_treeso_sw 35)
(mk-sprite 's_grasso_nw 36)
(mk-sprite 's_grasso_ne 37)
(mk-sprite 's_grasso_se 38)
(mk-sprite 's_grasso_sw 39)
(mk-sprite 's_grassi_c  7)
(mk-sprite 's_trees_nw 48)
(mk-sprite 's_trees_ne 49)
(mk-sprite 's_trees_se 50)
(mk-sprite 's_trees_sw 51)
(mk-sprite 's_trees_c 52)
(mk-sprite 's_hills_c 53)
(mk-sprite 's_hills_nw 56)
(mk-sprite 's_hills_ne 57)
(mk-sprite 's_hills_se 58)
(mk-sprite 's_hills_sw 59)
(mk-sprite 's_mount_c 54)
(mk-sprite 's_mount_nw 60)
(mk-sprite 's_mount_ne 61)
(mk-sprite 's_mount_se 62)
(mk-sprite 's_mount_sw 63)
(mk-sprite 's_forest_c 55)
(mk-sprite 's_forest_nw 64)
(mk-sprite 's_forest_ne 65)
(mk-sprite 's_forest_se 66)
(mk-sprite 's_forest_sw 67)

(kern-mk-sprite 's_deep          ss_overlays 1  4 #t 0 )
(kern-mk-sprite 's_shallow       ss_overlays 1  5 #t 0 )
(kern-mk-sprite 's_shoals        ss_overlays 1  6 #t 0 )

;; Character effect icons shown in the ztats window
(kern-mk-sprite 's_torchlight	ss_effects 1  0 #f 0 )
(kern-mk-sprite 's_light	ss_effects 1  1 #f 0 )
(kern-mk-sprite 's_poison	ss_effects 1 2 #f 0 )
(kern-mk-sprite 's_disease	ss_effects 1 3 #f 0 )
(kern-mk-sprite 's_im_poison	ss_effects 1 4 #f 0 )
(kern-mk-sprite 's_sleep	ss_effects 1 5 #f 0 )
(kern-mk-sprite 's_protect	ss_effects 1 6 #f 0 )
(kern-mk-sprite 's_charm	ss_effects 1 7 #f 0 )
(kern-mk-sprite 's_invis	ss_effects 1 8 #f 0 )
(kern-mk-sprite 's_spider_calm	ss_effects 1 9 #f 0 )
(kern-mk-sprite 's_drunk	ss_effects 1 10 #f 0 )
(kern-mk-sprite 's_im_disease	ss_effects 1 11 #f 0 )
(kern-mk-sprite 's_tangle	ss_effects 1 12 #f 0 )
(kern-mk-sprite 's_im_paralyse	ss_effects 1 13 #f 0 )
(kern-mk-sprite 's_im_fire	ss_effects 1 14 #f 0 )
(kern-mk-sprite 's_im_death	ss_effects 1 15 #f 0 )
(kern-mk-sprite 's_im_charm	ss_effects 1 16 #f 0 )
(kern-mk-sprite 's_im_sleep	ss_effects 1 17 #f 0 )
(kern-mk-sprite 's_paralyse	ss_effects 1 18 #f 0 )

;; Global effect icons shown in the foogod window
(kern-mk-sprite 's_time_stop    ss_effects 1 19 #f 0)
(kern-mk-sprite 's_quicken      ss_effects 1 20 #f 0)
(kern-mk-sprite 's_magic_negated ss_effects 1 21 #f 0)
(kern-mk-sprite 's_reveal        ss_effects 1 22 #f 0)
(kern-mk-sprite 's_xray_vision   ss_effects 1 23 #f 0)


;; convenient alia
(define s_shepherd s_companion_shepherd)
(define s_ranger s_companion_ranger)
(define s_blue_wizard s_companion_wizard)
(define s_wizard s_red_wizard)
(define s_fighter s_companion_fighter)
(define s_gwen s_cloaked_female)
(define s_silas s_plain_mage)
(define s_enchanter s_old_mage)
(define s_necromancer s_black_mage)
(define s_chanticleer s_minstrel)

;; Humanoid paper-doll-ready sprites
(define (mk-sprite tag sprite-set offset n-frames)
  (kern-mk-sprite tag sprite-set n-frames offset #f 0))
(mk-sprite 's_hum_body   ss_bodies     0 4)

(mk-sprite 's_hum_beard          ss_adornments 0 1)
(mk-sprite 's_hum_med_hair_gold  ss_adornments 4 1)
(mk-sprite 's_hum_long_hair_gold ss_adornments 5 1)

(mk-sprite 's_hum_pants  ss_clothes    0 1)
(mk-sprite 's_hum_shirt  ss_clothes    4 1)
(mk-sprite 's_hum_robe   ss_clothes    8 4)
(mk-sprite 's_hum_belt   ss_clothes    12 1)
(mk-sprite 's_hum_mantle ss_clothes    16 1)

;;----------------------------------------------------------------------------
;; Color conversion matrices - used as parms to the
;; kern-sprite-apply-matrix. By convention, names are mat_<color>, where
;; <color> is the target color and the source is assumed to be gray. To
;; translate other colors, eg from red to blue, use a name like mat_red_blue.
;;
(define mat_red '((0 0 2)
                  (0 0 0)
                  (0 0 0)
                  (0 0 0)))

(define mat_green '((0 0 0)
                    (0 2 0)
                    (0 0 0)
                    (0 0 0)))

(define mat_blue '((0 0 0)
                   (0 0 0)
                   (0 0 2)
                   (0 0 0)))

(define mat_white '((3 0 0)
                    (0 3 0)
                    (0 0 3)
                    (0 0 0)))

(define mat_yellow '((3 0 0)
                     (0 3 0)
                     (0 0 0)
                     (0 0 0)))

(define mat_gold_to_midnight '((0 0 0.25)
                               (0 0.25 0)
                               (0.25 0 0)
                               (0 0 0)))

(define mat_blue_to_green '((1 0 0)
                            (0 0 1)
                            (0 1 0)
                            (0 0 0)))

;;----------------------------------------------------------------------------
;; Sprites derived from other sprites via color conversion
(define (mk-sprite tag matrix)
  (kern-sprite-apply-matrix (kern-sprite-clone s_hum_robe tag) matrix))

(mk-sprite 's_hum_robe_red    mat_red)
(mk-sprite 's_hum_robe_green  mat_green)
(mk-sprite 's_hum_robe_blue   mat_blue)
(mk-sprite 's_hum_robe_white  mat_white)
(mk-sprite 's_hum_robe_yellow mat_yellow)

(define (mk-sprite tag matrix)
  (kern-sprite-apply-matrix (kern-sprite-clone s_hum_mantle tag) matrix))

(mk-sprite 's_hum_mantle_red    mat_red)
(mk-sprite 's_hum_mantle_green  mat_green)
(mk-sprite 's_hum_mantle_blue   mat_blue)
(mk-sprite 's_hum_mantle_white  mat_white)
(mk-sprite 's_hum_mantle_yellow mat_yellow)

(define (mk-sprite tag matrix base)
  (kern-sprite-apply-matrix (kern-sprite-clone base tag) matrix))

(mk-sprite 's_hum_med_hair_midnight  mat_gold_to_midnight s_hum_med_hair_gold)
(mk-sprite 's_hum_long_hair_midnight mat_gold_to_midnight s_hum_long_hair_gold)


;;--------------------------------------------------------------------------
;; 'special effects'

(kern-mk-sprite 's_heart	     ss_sfx   1  0 #f 0 )
(kern-mk-sprite 's_hit	        ss_sfx   1  1 #f 0 )
(kern-mk-sprite 's_magicflash	  ss_sfx   1  2 #f 0 )
(kern-mk-sprite 's_lightning	  ss_sfx   3  3 #f 495 )
