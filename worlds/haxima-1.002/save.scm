;; save.scm -- a nazghul session file
;; Load the standard definitions file
(load "naz.scm")

(kern-load "game.scm")

(kern-load "camping-map.scm")

(kern-load "gregors-hut-zones.scm")

(kern-load "ilya.scm")

(kern-load "moongate-clearing-zones.scm")

(kern-load "gregor.scm")

(kern-load "af-entry.scm")

(kern-mk-place 'p_abandoned_cellar "Musty Cellar"
  nil ;; sprite
  (kern-mk-map
    nil     32 32 pal_expanded
    (list
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ {{ rr rr {{ {{ {{ rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ .. {{ {{ {{ {{ .. {{ {{ rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ .. .. .. .. .. .. .. .. {{ {{ rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ .. .. .. .. .. .. .. .. .. .. {{ rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ {{ .. {{ {{ {{ .. .. .. .. {{ rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ {{ rr {{ {{ .. .. .. {{ rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ {{ {{ {{ {{ {{ rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ .. {{ {{ rr rr rr "
      "rr rr rr rr rr x! .. x! rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ {{ {{ rr rr rr "
      "rr rr rr rr rr .. .. .. rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ rr rr rr rr "
      "rr rr rr rr rr .. .. .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ {{ rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr x! .. x! rr rr rr rr rr rr rr rr rr rr {{ {{ {{ .. {{ {{ rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ .. .. .. .. {{ {{ rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ .. .. .. .. .. {{ {{ rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ .. {{ {{ {{ rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr {{ {{ {{ rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
    )
  )
  #f #t #f #f
  ;; subplaces
  nil
  ;; neighbors
  (list
    (list ;; begin above neighbor
      (kern-mk-place 'p_abandoned_farm "Abandoned Farm"
        s_hamlet ;; sprite
        (kern-mk-map
          nil           32 32 pal_expanded
          (list
            "tt tt || || || || || || || || || || || tt tt .. .. .. tt || || || || || || || || tt tt tt tt tt "
            "tt tt || || || || || || || || || || || || tt .. .. .. tt || || || || tt || || || || tt tt bb tt "
            "|| || || || || || || || || || tt || || || tt .. .. .. .. tt || || tt tt tt || || || || tt tt tt "
            "|| || || || || || || || || tt tt tt || || tt tt .. .. .. tt || tt tt tt tt tt || || || tt tt tt "
            "|| || || || || || || || || || tt || || || tt tt .. .. .. tt || || tt tt tt tt || || || || || tt "
            "|| || || || || || || || || || || || || || tt .. .. .. .. tt || || || tt || tt tt tt || || || || "
            "|| || || || || || || || || || || || || tt tt .. .. .. tt tt tt || || || || tt || tt tt tt tt || "
            "|| || || tt tt || || || || || tt tt tt tt tt .. .. .. tt tt tt tt tt || tt tt || || || tt tt tt "
            "|| || || tt tt tt tt tt tt tt tt .. .. .. .. .. .. tt tt tt tt tt tt tt tt || || || tt tt bb tt "
            "|| || || tt tt tt tt tt tt tt .. .. bb bb bb bb bb bb bb bb .. tt tt tt tt tt tt || || tt tt tt "
            "|| || tt tt .. .. .. .. .. .. .. bb .. .. .. .. .. .. tt tt tt .. tt bb tt tt tt tt || || tt || "
            "|| || tt tt .. bb rr rr ws rr rr rr .. .. .. .. .. .. .. .. .. .. .. tt bb tt tt tt || || || || "
            "|| || tt tt .. rr .. cc cc cc cc rr .. .. .. .. .. .. .. .. .. && .. .. bb tt tt tt || || || || "
            "|| tt tt tt .. rr cc cc cc cc cc rr .. .. .. .. .. .. .. .. .. .. .. .. bb tt bb tt || || || || "
            "tt tt tt tt .. ws cc cc cc cc cc ws .. .. .. .. .. .. .. .. .. bb .. tt bb tt tt .. .. .. || || "
            ".. tt tt .. .. rr cc cc cc cc cc rr .. .. .. .. .. .. .. .. .. .. .. .. bb tt .. .. .. .. .. || "
            ".. .. .. .. .. rr cc cc cc cc cc rr .. .. .. .. .. .. .. .. .. .. .. .. bb .. .. .. tt .. .. .. "
            ".. .. .. .. .. rr rr rr cc rr rr bb rr cc rr .. .. .. .. .. .. .. .. .. bb .. .. tt bb tt .. .. "
            "tt .. .. .. .. rr cc cc cc cc cc cc .. cc rr .. .. .. .. .. .. .. .. .. bb .. tt tt tt tt tt tt "
            "tt tt .. .. .. ws cc cc cc cc cc cc cc cc rr .. .. .. .. .. .. .. .. .. bb .. tt tt tt tt tt bb "
            "tt tt tt .. .. rr cc cc cc cc cc .. cc cc rr rr rr rr ws rr rr bb rr bb .. .. tt tt tt tt tt tt "
            "tt tt tt .. .. rr cc cc cc [[ @@ ]] cc cc rr cc cc cc cc cc .. .. rr .. .. tt tt || || || tt tt "
            "|| || tt tt .. ws cc cc cc cc cc cc cc cc rr cc cc cc cc cc cc cc rr .. tt tt || || || || || tt "
            "|| || tt tt .. rr cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc ws .. tt || || || || || || tt "
            "|| || || tt .. rr rr rr cc cc cc cc cc cc rr cc cc cc cc cc cc .. rr tt tt || || || tt || || || "
            "|| || || tt .. rr cc cc cc cc cc [[ @@ ]] rr cc cc cc cc cc .. .. bb tt tt || || || || || || || "
            "|| || || tt .. rr rr rr rr ws rr rr rr rr rr rr rr rr ws rr rr rr rr tt tt || || || || || || tt "
            "|| || || tt .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. tt tt tt tt || || || || || tt tt "
            "|| || tt tt tt tt tt tt tt tt tt tt tt tt .. .. .. .. .. tt tt tt tt tt tt tt || || || || tt tt "
            "|| || tt tt || || || || || || || || tt tt tt .. .. .. tt tt tt || || || tt tt || || || || tt tt "
            "|| || || || || || || || || || || || || tt tt tt .. tt tt tt || || || || || || || || || tt tt tt "
            "|| || || || || || || || || || || || || || tt tt .. tt tt || || || tt || || || || || tt tt tt tt "
          )
        )
        #f #f #f #f
        ;; subplaces
        nil
        ;; neighbors
        nil
        ;; contents
        (list
          (list
            (kern-mk-char
              nil
              " a wood spider"
              sp_spider
              nil
              s_spider
              7
              0 36 84
              0 0
              0 0
              14 0
              0 1
              #f ;; dead?
              nil
              nil
              'spider-ai
              nil ;; inventory
              nil
              ;; hooks
              (list
              )
            )
          9 22)
          (list
            (bind
              (kern-mk-obj t_ladder_down 1)
              (list
                'p_abandoned_cellar
                6
                25
              )
            ) ;; bind
          6 25)
          (list
            (kern-mk-char
              nil
              " a queen spider"
              sp_queen_spider
              nil
              s_queen_spider
              7
              0 36 72
              0 0
              0 0
              34 0
              0 1
              #f ;; dead?
              nil
              nil
              'spider-ai
              nil ;; inventory
              nil
              ;; hooks
              (list
              )
            )
          9 23)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          7 25)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          13 17)
        ) ;; end of objects
        (list
          'af-entry
        )
        (list ;; edge entrances
          (list 0 31 31) ;; Northwest
          (list 1 16 31) ;; North
          (list 2 0 31) ;; Northeast
          (list 3 31 16) ;; West
          (list 4 16 16) ;; Here
          (list 5 0 16) ;; East
          (list 6 31 0) ;; Southwest
          (list 7 16 0) ;; South
          (list 8 0 0) ;; SoutheastUp
        )
      ) ;; end of place p_abandoned_farm

    9) ;; end above neighbor
  )
  ;; contents
  (list
    (list
      (bind
        (kern-mk-obj t_ladder_up 1)
        (list
          'p_abandoned_farm
          6
          25
        )
      ) ;; bind
    6 25)
    (list
      (kern-mk-field web-type 256)    6 11)
    (list
      (kern-mk-field web-type 256)    5 12)
    (list
      (kern-mk-field web-type 256)    6 12)
    (list
      (bind
        (kern-mk-obj spider-egg-type 1)
        (list
          10
        )
      ) ;; bind
    5 13)
    (list
      (kern-mk-field web-type 256)    5 13)
    (list
      (bind
        (kern-mk-obj spider-egg-type 1)
        (list
          10
        )
      ) ;; bind
    7 12)
    (list
      (kern-mk-field web-type 256)    7 12)
    (list
      (kern-mk-field web-type 256)    6 13)
    (list
      (kern-mk-field web-type 256)    5 14)
    (list
      (kern-mk-field web-type 256)    7 13)
    (list
      (kern-mk-field web-type 256)    6 14)
    (list
      (kern-mk-field web-type 256)    9 12)
    (list
      (kern-mk-field web-type 256)    8 13)
    (list
      (kern-mk-field web-type 256)    7 14)
    (list
      (bind
        (kern-mk-obj spider-egg-type 1)
        (list
          10
        )
      ) ;; bind
    6 15)
    (list
      (kern-mk-field web-type 256)    6 15)
    (list
      (kern-mk-field web-type 256)    10 12)
    (list
      (kern-mk-field web-type 256)    9 13)
    (list
      (kern-mk-field web-type 256)    7 15)
    (list
      (kern-mk-field web-type 256)    11 12)
    (list
      (bind
        (kern-mk-char
          nil
          "a troll "
          sp_troll
          oc_troll
          s_troll
          6
          0 36 72
          0 0
          0 0
          26 0
          0 1
          #f ;; dead?
          nil
          nil
          'troll-ai
          nil ;; inventory
          nil
          ;; hooks
          (list
          )
        )
        (list
          #f
        )
      ) ;; bind
    11 12)
    (list
      (kern-mk-field web-type 256)    10 13)
    (list
      (bind
        (kern-mk-obj spider-egg-type 1)
        (list
          10
        )
      ) ;; bind
    9 14)
    (list
      (kern-mk-field web-type 256)    9 14)
    (list
      (kern-mk-field web-type 256)    7 16)
    (list
      (kern-mk-field web-type 256)    11 13)
    (list
      (kern-mk-field web-type 256)    10 14)
    (list
      (bind
        (kern-mk-obj spider-egg-type 1)
        (list
          10
        )
      ) ;; bind
    11 14)
    (list
      (kern-mk-field web-type 256)    11 14)
    (list
      (kern-mk-field web-type 256)    9 16)
    (list
      (bind
        (kern-mk-obj spider-egg-type 1)
        (list
          10
        )
      ) ;; bind
    10 16)
    (list
      (kern-mk-field web-type 256)    10 16)
    (list
      (kern-mk-field web-type 256)    10 16)
    (list
      (kern-mk-field web-type 256)    10 17)
    (list
      (kern-mk-field web-type 256)    11 17)
    (list
      (kern-mk-obj t_puska 1)
    10 18)
    (list
      (bind
        (kern-mk-obj spider-egg-type 1)
        (list
          10
        )
      ) ;; bind
    11 18)
    (list
      (kern-mk-field web-type 256)    11 18)
  ) ;; end of objects
  (list
  )
  (list ;; edge entrances
    (list 0 31 31) ;; Northwest
    (list 1 16 31) ;; North
    (list 2 0 31) ;; Northeast
    (list 3 31 16) ;; West
    (list 4 16 16) ;; Here
    (list 5 0 16) ;; East
    (list 6 31 0) ;; Southwest
    (list 7 16 0) ;; South
    (list 8 0 0) ;; SoutheastUp
  )
) ;; end of place p_abandoned_cellar

(kern-load "slimy-cavern-zones.scm")

(kern-load "roland.scm")

(kern-mk-place 'p_slimy_cavern "Slimy Cavern"
  nil ;; sprite
  (kern-mk-map
    nil     16 32 pal_expanded
    (list
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr .. .. .. rr "
      "rr rr rr rr rr .. .. && .. .. rr rr .. .. .. rr "
      "rr rr rr rr bb .. .. .. .. .. bb rr rr .. rr rr "
      "rr bb .. .. bb .. .. .. .. .. bb .. .. .. rr rr "
      "rr bb .. .. .. bb bb .. bb bb .. .. .. .. .. rr "
      "rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr "
      "rr bb .. .. .. .. .. .. .. .. .. .. .. .. rr rr "
      "rr rr bb .. .. .. .. .. .. .. .. .. rr rr rr rr "
      "rr rr rr .. .. .. .. .. .. .. .. .. rr .. .. rr "
      "rr .. .. .. .. .. .. rr rr .. .. rr rr .. .. rr "
      "rr .. rr .. rr bb rr rr rr rr .. rr rr .. rr rr "
      "rr %% rr .. .. .. rr .. .. rr .. rr rr .. rr rr "
      "~~ bb bb rr .. .. rr .. .. .. .. .. .. .. rr rr "
      "rr ~~ bb ~~ .. .. rr rr .. rr rr .. rr rr rr rr "
      "rr rr %% ~~ ~~ ~~ bb rr rr rr rr .. rr rr rr rr "
      "rr .. .. .. .. ~~ bb bb rr rr .. .. .. rr rr rr "
      "rr .. rr .. %% rr bb ~~ bb %% .. .. .. rr rr rr "
      "rr .. rr rr rr rr rr bb ~~ ~~ %% .. .. %% rr rr "
      "rr .. rr rr rr .. .. rr %% ~~ bb ~~ bb ~~ ~~ rr "
      "rr .. .. .. rr .. %% %% %% %% %% .. %% bb ~~ ~~ "
      "rr rr rr .. rr .. .. rr rr .. .. .. %% rr rr rr "
      "rr rr rr .. rr rr rr rr rr .. .. .. .. .. bb rr "
      "rr rr .. .. .. rr rr .. .. .. rr .. .. .. .. rr "
      "rr .. .. .. .. .. .. .. rr rr rr .. .. .. .. rr "
      "rr .. .. .. .. rr rr rr rr rr rr rr .. .. rr rr "
      "rr rr .. .. rr rr rr .. .. .. rr rr rr .. rr rr "
      "rr rr rr .. rr rr .. .. .. .. .. rr rr .. rr rr "
      "rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr "
      "rr .. rr rr rr rr .. .. .. .. .. rr .. rr .. rr "
      "rr .. rr rr rr rr rr .. .. .. rr rr .. .. .. rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
    )
  )
  #f #t #f #f
  ;; subplaces
  nil
  ;; neighbors
  nil
  ;; contents
  (list
    (list
      (bind
        (kern-mk-obj t_slime_generator 1)
        (list
          9
          17
        )
      ) ;; bind
    11 17)
    (list
      (bind
        (kern-mk-obj tf_ns_bridge 1)
        '()
      ) ;; bind
    11 19)
    (list
      (bind
        (kern-mk-char
          nil
          " a bandit"
          sp_human
          oc_bandit
          s_brigand
          8
          0 60 60
          0 0
          0 0
          22 0
          12 1
          #f ;; dead?
          nil
          nil
          nil
          (kern-mk-container
            t_chest
            ;; trap
            'spike-trap
            ;; contents
            (list
              (list 1 t_heal_potion)
              (list 4 t_gold_coins)
              (list 5 t_leather_helm)
              (list 5 t_mace)
              (list 5 t_dagger)
              (list 5 t_armor_leather)
            )
          )
          (list
            t_leather_helm
            t_mace
            t_dagger
            t_armor_leather
          )
          ;; hooks
          (list
          )
        )
        (list
          #f
        )
      ) ;; bind
    5 4)
    (list
      (kern-mk-container
        t_chest
        ;; trap
        nil
        ;; contents
        (list
          (list 2 t_food)
          (list 1 t_2h_sword)
          (list 1 t_armor_chain)
          (list 1 t_iron_helm)
        )
      )
    9 2)
    (list
      (bind
        (kern-mk-char
          nil
          " a bandit"
          sp_human
          oc_bandit
          s_brigand
          8
          0 60 60
          0 0
          0 0
          22 0
          12 1
          #f ;; dead?
          nil
          nil
          nil
          (kern-mk-container
            t_chest
            ;; trap
            'spike-trap
            ;; contents
            (list
              (list 14 t_bolt)
              (list 1 t_shield)
              (list 6 t_gold_coins)
              (list 2 t_picklock)
              (list 5 t_leather_helm)
              (list 5 t_mace)
              (list 5 t_dagger)
              (list 5 t_armor_leather)
            )
          )
          (list
            t_leather_helm
            t_mace
            t_dagger
            t_armor_leather
          )
          ;; hooks
          (list
          )
        )
        (list
          #f
        )
      ) ;; bind
    9 2)
    (list
      (bind
        (kern-mk-char
          nil
          " a bandit"
          sp_human
          oc_bandit
          s_brigand
          8
          0 60 60
          0 0
          0 0
          22 0
          12 1
          #f ;; dead?
          nil
          nil
          nil
          (kern-mk-container
            t_chest
            ;; trap
            'spike-trap
            ;; contents
            (list
              (list 1 t_dagger)
              (list 18 t_bolt)
              (list 1 t_shield)
              (list 6 t_gold_coins)
              (list 5 t_leather_helm)
              (list 5 t_mace)
              (list 5 t_oil)
              (list 5 t_armor_leather)
            )
          )
          (list
            t_leather_helm
            t_mace
            t_oil
            t_armor_leather
          )
          ;; hooks
          (list
          )
        )
        (list
          #f
        )
      ) ;; bind
    9 4)
    (list
      (bind
        (kern-mk-obj t_ladder_up 1)
        (list
          'p_moongate_clearing
          20
          1
        )
      ) ;; bind
    8 30)
    (list
      (bind
        (kern-mk-obj tf_ns_bridge 1)
        '()
      ) ;; bind
    4 15)
    (list
      (bind
        (kern-mk-char
          'ch_roland
          "Roland"
          sp_human
          nil
          s_knight
          2
          16 70 76
          0 0
          0 0
          26 0
          9 3
          #f ;; dead?
          'roland-conv
          nil
          'roland-ai
          nil ;; inventory
          nil
          ;; hooks
          (list
          )
        )
        (list
          #f
          #f
          #f
        )
      ) ;; bind
    14 1)
    (list
      (bind
        (kern-mk-obj t_door 1)
        (list
          #f
          0
          '()
          #f
          #t
          #f
          (list
            (list
              's_closed_windowed_wood_door_in_rock
              #f
              5
            )
            (list
              's_open_door_in_rock
              #f
              0
            )
            (list
              's_locked_windowed_wood_door_in_rock
              #f
              5
            )
            (list
              's_magically_locked_windowed_wood_door_in_rock
              #f
              5
            )
          )
        )
      ) ;; bind
    13 3)
  ) ;; end of objects
  (list
    'slimy-cavern-entry
  )
  (list ;; edge entrances
    (list 0 15 31) ;; Northwest
    (list 1 8 31) ;; North
    (list 2 0 31) ;; Northeast
    (list 3 15 16) ;; West
    (list 4 8 16) ;; Here
    (list 5 0 16) ;; East
    (list 6 15 0) ;; Southwest
    (list 7 8 0) ;; South
    (list 8 0 0) ;; SoutheastUp
  )
) ;; end of place p_slimy_cavern

(kern-load "trigrave-zones.scm")

(kern-load "jim.scm")

(kern-load "gwen.scm")

(kern-load "chanticleer.scm")

(kern-load "earl.scm")

(kern-load "trigrave-entry.scm")

(kern-mk-place 'p_lost_halls "Lost Halls"
  nil ;; sprite
  (kern-mk-map
    nil     64 39 pal_expanded
    (list
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr xx xx xx xx xx xx xx xx rr "
      "rr xx xx rr .. rr rr .. .. rr rr rr rr rr rr rr rr rr rr %% rr rr rr rr rr rr rr rr rr rr rr .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr .. .. rr rr rr xx ,L ,A ,R ,D ,E ,R xx rr "
      "rr xx cc cc .. .. .. .. .. .. [[ @@ ]] rr rr rr rr rr rr .. rr rr rr rr rr rr rr rr rr .. .. .. .. .. rr rr rr .. .. rr rr .. .. rr rr rr rr rr .. .. .. .. .. rr rr xx ,, ,, ,, ,, ,, ,, xx rr "
      "rr rr cc cc .. .. .. .. .. .. .. .. .. .. .. rr rr rr .. .. .. rr rr rr rr rr rr rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr rr rr .. .. .. .. .. .. rr rr xx ,, ,, ,, ,, ,, ,, xx rr "
      "rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr rr rr .. .. .. .. .. rr rr rr .. .. .. .. .. .. rr .. .. .. .. .. .. .. .. .. .. .. .. rr rr rr .. .. .. .. bb rr rr xx ,, ,, ,, ,, ,, ,, xx rr "
      "rr .. .. .. .. .. .. .. .. .. .. && .. .. .. rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr .. .. .. .. rr .. .. .. .. .. .. .. rr rr rr rr rr .. rr rr rr rr xx xx xx ,, ,, xx xx xx rr "
      "rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr rr .. .. rr rr .. .. .. .. .. .. .. rr rr rr ,, ,, ,, ,, ,, rr xx xx xx xx ,, ,, xx xx xx rr "
      "rr .. .. .. .. .. .. .. .. .. bb .. bb .. .. rr .. .. .. .. xx xx xx xx xx .. .. .. .. .. .. rr rr rr rr rr rr rr .. .. .. .. .. .. .. rr rr ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, xx rr "
      "rr rr .. .. .. .. && .. .. .. .. .. .. .. .. rr rr xx xx xx .. .X .. .O .. xx xx xx .. .. rr rr rr rr rr rr rr .. .. .. .. rr rr .. .. rr rr ,, ,, pp ,, pp ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, xx rr "
      "rr rr rr .. .. .. .. .. .. .. .. %% %% rr rr xx xx rr rr xx ,, ,, ,, ,, ,, xx ,, ,, xx xx .. rr rr rr rr rr .. ,, ,, ,, ,, rr rr ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, xx rr "
      "rr rr rr .. .. .. .. .. .. %% %% %% rr rr xx rr rr ,, ,, xx ,, ,, ,, ,, ,, xx ,, ,, ,, ,, xx .. .. .. rr .. ,, ,, rr .. .. .. .. .. .. rr rr .. ,, pp ,, pp ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, xx rr "
      "rr rr rr .. .. .. .. .. rr rr ~~ ~~ rr xx rr ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, cc ,, ,, ,, ,, ,, ,, rr rr rr .. .. .. .. .. rr rr ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, xx rr "
      "rr rr rr rr .. .. rr rr rr rr -- -- xx rr ,, ,, ,, ,, rr rr rr ,, ,, ,, ,, xx ,, ,, ,, ,, ,, ,, xx .. rr .. rr rr rr rr .. .. .. .. .. rr rr rr ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, xx rr "
      "rr rr rr rr .. .. rr rr rr rr rr rr xx ,, ,, ,, ,, rr rr rr rr rr ,, ,, ,, rr rr rr ,, ,, ,, rr xx rr .. .. .. .. rr rr .. .. .. .. .. rr rr rr rr rr rr rr rr xx xx xx ,, ,, xx xx xx xx xx rr "
      "rr rr rr .. .. .. rr rr rr rr rr xx rr ,, ,, ,, ,, rr rr rr rr rr rr ,, ,, rr rr rr rr ,, ,, rr rr xx .. .. .. .. rr rr rr .. rr .. .. rr rr rr rr rr rr rr rr xx xx xx ,, ,, xx xx xx xx rr rr "
      "rr rr rr .. .. .. .. rr rr rr rr xx rr ,, ,, ,, ,, rr rr rr rr tt tt ,, ,, rr rr rr rr ,, ,, rr rr xx rr .. .. .. rr rr rr rr rr .. .. rr rr cc cc cc cc rr rr xx ,, ,, ,, ,, ,, ,, xx xx rr rr "
      "rr rr rr .. .. .. .. rr rr rr rr xx rr rr rr && rr rr rr rr tt .. .. .. ,, rr rr rr rr ,, ,, ,, rr xx rr rr .. .. .. rr rr rr rr .. .. ,, cc cc cc cc cc cc rr xx ,, ,, ,, ,, ,, ,, xx xx rr rr "
      "rr rr rr .. .. .. rr rr rr rr xx rr rr rr rr rr rr rr rr tt xx xx xx xx xx .. rr rr rr rr ,, ,, ,, ,, xx rr .. .. .. .. rr rr rr .. .. ,, cc cc 00 00 cc cc rr xx ,, ,, ,, ,, ,, ,, xx xx rr rr "
      "rr rr rr .. .. .. rr rr rr rr xx rr rr ,, ,, ,, rr rr rr rr xx ,, ,, ,, xx bb rr rr rr ,, ,, ,, ,, ,, xx .. .. .. .. .. rr rr rr .. .. pp cc cc 00 00 cc cc rr xx xx xx ,, ,, xx xx xx xx rr rr "
      "rr rr rr rr .. .. rr rr rr rr xx rr ,, ,, rr ,, rr rr rr rr xx ,, .. ,, xx .. rr rr rr ,, ,, ,, ,, ,, xx .. .. .. .. .. bb rr && .. .. ,, cc cc 00 00 cc cc rr xx xx xx ,, ,, xx xx xx xx rr rr "
      "rr rr rr rr .. .. rr rr rr rr xx ,, .. rr ,, .. ,, rr rr ,, xx rr ,, ,, rr rr rr ,, ,, ,, ,, ,, .. ,, xx .. .. .. .. .. .. rr && .. .. ,, cc cc 00 00 cc cc rr rr tt tt .. .. .. tt tt tt rr rr "
      "rr rr rr rr .. .. .. rr rr .. .. ,, .. ,, ,, ,, ,, ,, ,, ,, xx xx xx xx xx ,, ,, ,, ,, ,, ,, .. bb .. xx .. .. .. .. && .. rr && .. .. ,, cc cc 00 00 cc cc rr rr tt .. bb .. .. .. bb tt tt rr "
      "rr rr .. .. .. .. .. .. .. .. xx ,, ,, .. ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, rr rr rr rr ,, ,, .. xx .. .. .. .. .. .. rr rr rr .. .. pp cc cc 00 00 cc cc rr tt tt .. .. tt bb .. .. tt tt rr "
      "rr rr .. .. .. .. .. .. .. .. .. xx rr ,, ,, rr rr rr rr ,, rr rr rr ,, ,, ,, rr rr rr rr rr rr ,, xx .. .. .. bb .. .. rr rr rr .. .. ,, cc cc cc cc cc cc rr tt .. bb .. .. .. .. tt tt rr rr "
      "rr .. .. .. bb .. .. .. .. .. .. xx rr rr rr rr rr rr ,, ,, ,, ,, rr rr rr rr rr rr rr rr rr rr rr xx .. .. .. .. rr rr rr rr rr .. .. ,, cc cc cc cc cc rr rr rr tt tt .. .. bb tt tt rr rr rr "
      "rr .. .. .. .. .. .. .. bb .. .. rr xx rr rr rr bb ,, ,, ,, .. ,, rr rr rr rr rr ,, ,, ,, rr xx xx rr .. rr rr rr rr rr rr rr rr .. .. rr rr bb cc cc rr rr rr rr rr rr tt .. .. rr rr rr rr rr "
      "rr rr .. .. .. .. .. .. .. .. .. rr xx rr rr rr ,, ,, ,, .. bb .. ,, rr rr rr ,, ,, ,, ,, ,, rr xx .. .. rr rr rr rr rr rr .. rr .. .. rr rr rr rr rr rr rr rr rr rr rr .. bb .. rr rr rr rr rr "
      "rr rr .. .. .. .. .. .. .. .. rr rr rr xx rr rr ,, ,, ,, ,, .. ,, ,, rr rr ,, ,, ,, ,, ,, ,, xx .. .. .. .. rr rr .. .. .. .. .. .. .. .. .. .. .. bb rr rr rr rr rr rr .. .. .. rr rr rr rr rr "
      "rr rr rr .. .. .. .. .. rr rr rr rr rr rr xx ,, ,, ,, ,, ,, ,, ,, rr rr rr ,, ,, && ,, ,, ,, .. .. .. .. .. rr .. .. .. .. .. .. .. .. .. .. .. .. .. bb rr rr ,R rr .. .. .. .. rr ;S rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr xx xx rr ,, rr rr rr rr rr rr rr ,, ,, .. .. .. rr rr .. .. .. .. .. .. rr rr rr rr rr bb .. .. && .. .. .. rr rr bb tt .. bb .. .. %% bb rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr xx .. xx ,, ,, rr rr rr xx xx .. .. .. rr rr rr rr .. rr rr rr rr rr .. .. .. rr rr .. .. .. .. .. .. rr rr .. .. .. .. bb .. %% %% bb rr rr "
      "rr rr rr rr .. .. .. rr rr rr rr rr rr rr rr rr .. .. .. .. .. .. xx xx xx rr rr .. rr rr rr rr rr .. .. rr rr rr rr .. .. .. && .. rr .. .. .. .. .. rr rr bb .. .. bb .. .. %% %% tt %% ;T rr "
      "rr rr rr .. .. .. .. .. .. .. rr rr .. rr rr rr .. .. .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr .. .. rr rr rr rr .. .. .. .. .. rr xx xx ,, xx xx rr rr bb .. bb tt tt .. __ __ __ __ rr rr "
      "rr rr .. .. .. .. .. .. .. .. .. .. .. .. rr rr rr .. .. .. .. .. .. rr rr rr rr rr rr rr .. .. rr .. .. .. .. .. .. .. .. .. .. rr rr xx ,, ,, ,, xx rr ;A %% .. .. .. tt .. .. __ __ __ __ rr "
      "rr rr .. .. .. .. .. .. .. .. .. .. .. .. rr rr rr rr rr .. .. .. rr rr rr rr rr .. .. .. .. .. .. .. .. .. .. .. .. .. rr rr rr rr rr xx ,, ,, ,, xx rr rr rr bb .. bb .. .. .. __ .. .. __ rr "
      "rr rr rr .. .. .. .. .. rr rr rr .. .. rr rr rr rr rr rr rr .. rr rr rr rr rr rr .. .. .. .. .. .. .. .. rr rr .. rr rr rr rr rr rr rr bb ,, ,, ,, xx rr rr rr rr tt %% __ __ bb __ __ __ __ rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr .. rr rr rr rr rr rr rr .. .. .. .. .. rr rr rr rr .. .. .. .. rr rr rr rr xx bb xx xx xx rr rr rr ,Q %% __ __ __ __ __ __ bb rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr x! rr rr rr rr rr rr rr rr .. .. rr rr rr rr rr rr .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr bb __ __ __ __ bb ,P rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
    )
  )
  #f #t #f #f
  ;; subplaces
  nil
  ;; neighbors
  nil
  ;; contents
  (list
    (list
      (bind
        (kern-mk-obj tf_ew_bridge 1)
        '()
      ) ;; bind
    59 34)
    (list
      (bind
        (kern-mk-obj t_ladder_up 1)
        (list
          'p_shard
          46
          12
        )
      ) ;; bind
    1 4)
    (list
      (kern-mk-obj t_dungeon_spider_generator 1)
    15 28)
    (list
      (kern-mk-obj t_dungeon_troll_generator 1)
    41 32)
    (list
      (kern-mk-obj t_dungeon_troll_generator 1)
    48 30)
    (list
      (kern-mk-obj t_dungeon_troll_generator 1)
    38 21)
    (list
      (kern-mk-obj t_dungeon_troll_generator 1)
    28 28)
    (list
      (kern-mk-obj t_dungeon_troll_generator 1)
    11 6)
    (list
      (bind
        (kern-mk-obj t_slime_generator 1)
        (list
          11
          9
        )
      ) ;; bind
    10 8)
    (list
      (bind
        (kern-mk-obj t_slime_generator 1)
        (list
          60
          30
        )
      ) ;; bind
    57 31)
  ) ;; end of objects
  (list
  )
  (list ;; edge entrances
    (list 0 63 38) ;; Northwest
    (list 1 32 38) ;; North
    (list 2 0 38) ;; Northeast
    (list 3 63 19) ;; West
    (list 4 32 19) ;; Here
    (list 5 0 19) ;; East
    (list 6 63 0) ;; Southwest
    (list 7 32 0) ;; South
    (list 8 0 0) ;; SoutheastUp
  )
) ;; end of place p_lost_halls

(kern-load "enchanters-tower-zones.scm")

(kern-load "zane.scm")

(kern-load "shroom.scm")

(kern-mk-place 'p_green_tower_lower "Beneath Green Tower"
  nil ;; sprite
  (kern-mk-map
    nil     64 64 pal_expanded
    (list
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr ~~ ~~ || || || || rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr ~~ || || || || || rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || || || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr ~~ || || || || rr rr rr rr rr rr rr xx xx xx xx x! xx xx x! xx xx xx xx rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr xx tt xx tt tt || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr ~~ || || || || rr rr rr rr rr rr rr xx cc cc xx cc cc cc cc xx cc cc xx rr rr rr rr rr rr rr rr rr rr rr rr rr rr .. .. .. xx tt tt tt || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr ~~ ~~ || || || rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc cc cc xx rr rr rr rr rr rr rr rr rr rr rr rr rr .. .. .. .. tt tt tt tt || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || ~~ || || || rr rr rr rr rr rr rr xx cc cc xx cc cc cc cc xx cc cc xx rr rr rr rr rr rr rr rr rr rr rr rr rr @@ tt @@ tt xx tt tt tt || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || ~~ || || || rr rr rr rr rr rr rr xx xx xx x! cc cc cc cc x! xx xx xx rr rr rr rr rr rr rr rr rr rr rr rr .. .. .. .. .. xx tt tt || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || ~~ || || || rr rr rr rr rr rr rr xx cc cc xx cc cc cc cc xx cc cc xx rr rr rr rr rr rr rr rr rr rr rr tt tt tt tt tt tt xx || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || ~~ ~~ || || rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc cc cc xx rr rr rr rr rr rr rr rr rr rr rr xx xx xx xx tt xx xx || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || || ~~ || || rr rr rr rr rr rr rr xx cc cc xx cc cc cc cc xx cc cc xx rr rr rr rr rr rr rr rr rr rr .. .. .. xx .. .. .. xx || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || || ~~ || || rr rr rr rr rr rr rr xx xx xx x! cc cc cc cc x! xx xx xx rr rr rr rr rr rr rr tt tt .. .. .. .. ?? .. .. .. ?? tt tt tt tt tt tt tt "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr .. .. ~~ ~~ ~~ rr rr rr rr rr rr rr xx cc cc xx cc cc cc cc xx cc cc xx rr rr rr rr rr rr || || tt xx .. .. .. xx .. .. .. xx || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || || || ~~ rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc cc cc ?? || rr rr rr rr rr xx xx tt xx xx tt xx xx xx .. xx xx || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || || || ~~ rr rr rr rr rr rr rr xx cc cc xx cc cc cc cc xx cc cc xx tt rr ~~ ~~ ~~ ~~ ~~ || tt || || || || || || || || || || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || || ~~ ~~ rr rr rr rr rr rr rr xx xx xx xx x! cc cc x! xx xx xx xx xx xx ~~ xx xx -- ~~ ~~ .. || || || || || || || || || || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr || || ~~ || .. || tt ~~ ~~ ~~ .. .. .. .. xx cc cc cc cc xx ~~ ~~ ~~ -- __ __ __ xx -- -- ~~ ~~ || || || || || || || || || || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr || ~~ ~~ || .. || tt ~~ tt ~~ .. .. ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ -- __ __ __ xx __ -- ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ || || || ~~ ~~ ~~ ~~ || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr || ~~ tt bb .. bb .. ~~ tt ~~ .. .. ~~ tt xx cc cc cc cc xx cc cc ~~ -- __ __ __ xx __ -- ~~ ~~ || || || || || || ~~ || || || ~~ || || ~~ ~~ || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr ~~ ~~ .. .. .. .. ~~ .. ~~ ~~ ~~ ~~ tt xx x! cc cc x! xx cc cc ~~ -- -- -- -- xx -- ~~ ~~ tt tt || || || || || == || || || ~~ || || tt ~~ ~~ "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr || ~~ ~~ ~~ ~~ ~~ ~~ .. .. .. .. .. .. xx cc cc cc cc xx cc cc ~~ ~~ ~~ ~~ ~~ xx ~~ ~~ .. || tt || || || || || ~~ ~~ ~~ ~~ ~~ || tt tt tt || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr .. .. .. .. .. .. .. .. rr rr rr xx cc cc cc cc cc cc cc cc cc cc cc cc xx .. .. .. tt tt || || || || || || || || || || || || tt || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc xx cc cc cc cc cc cc cc x! .. .. .. bb tt || || || || || || tt || || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr xx x! cc cc x! xx ,C ,I ,S ,T ,E ,R ,N xx .. .. .. tt tt || tt || || || tt tt tt || || || || || || || "
      "rr rr rr rr rr rr rr rr rr rr rr xx xx xx xx xx xx xx xx xx xx rr rr rr rr rr rr xx xx xx xx cc cc cc cc xx xx xx xx xx xx xx xx xx .. .. .. bb tt tt tt tt || || || tt || || || rr || rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx ,B ,A ,R ,R ,A ,C ,K ,S xx rr rr rr rr xx xx xx cc cc xx cc cc cc cc xx cc cc xx xx xx cc cc ?? .. .. .. tt tt || tt || || || || || || || || rr tt tt cc rr "
      "rr rr rr rr rr rr rr rr rr rr rr x! cc cc cc cc cc cc cc cc x! rr rr xx xx xx cc cc cc cc xx cc cc cc cc xx cc cc cc cc xx xx xx xx .. .. .. bb tt || || tt rr rr rr rr rr rr rr rr cc cc cc rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc xx rr rr xx cc cc cc cc cc cc xx cc cc cc cc xx cc cc cc cc cc cc xx xx .. .. .. tt tt || || tt rr cc cc cc cc cc cc cc cc cc cc rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc xx rr xx xx cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc xx xx .. .. .. tt tt || || tt rr cc rr rr rr rr rr rr cc cc cc rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc xx rr xx cc cc cc cc cc cc cc xx cc cc cc cc xx cc cc cc cc cc cc cc xx xx xx x! xx xx xx x! xx xx cc rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc xx rr xx cc cc cc cc cc cc cc xx cc cc cc cc xx cc cc cc cc cc cc cc xx xx ,C ,O ,U ,N ,C ,I ,L xx cc rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc xx rr xx xx xx xx cc xx xx xx x! cc cc cc cc x! xx xx xx cc xx xx xx xx xx cc cc cc cc cc cc cc xx cc rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx xx x! xx cc cc xx x! xx xx xx x! cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc x! cc cc cc cc cc cc cc x! cc rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 00 00 00 cc cc xx cc rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 00 00 00 cc cc xx cc rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx xx x! xx cc cc xx x! xx xx xx x! cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc x! cc cc cc cc cc cc cc x! cc rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc xx rr xx xx xx xx cc xx xx xx x! cc cc cc cc x! xx xx xx cc xx xx xx xx xx cc cc cc cc cc cc && xx cc rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr x! cc cc cc cc cc cc cc cc x! rr xx cc cc cc cc cc cc cc xx cc cc cc cc xx cc cc cc cc cc cc cc xx xx xx x! xx xx xx x! xx xx cc rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc xx rr xx cc cc cc cc cc cc cc xx cc cc cc cc xx cc cc cc cc cc cc cc ?? cc cc cc cc cc cc cc cc cc cc rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr x! cc cc cc cc cc cc cc cc x! rr xx xx cc cc cc cc cc cc xx cc cc cc cc xx cc cc cc cc cc cc xx xx rr rr rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc xx rr rr xx cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc xx rr rr rr rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx ,T ,R ,A ,I ,N ,I ,N ,G xx rr rr xx xx xx cc cc cc cc xx cc cc cc cc xx cc cc cc cc xx xx xx rr rr rr rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr xx xx xx xx xx xx xx xx xx xx rr rr rr rr xx xx xx cc cc xx cc cc cc cc xx cc cc xx xx xx rr rr rr rr rr rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr xx xx xx xx cc cc cc cc xx xx xx xx rr rr rr rr rr rr rr rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr xx xx xx xx x! cc cc x! xx xx xx xx xx xx xx xx xx xx rr rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc cc cc cc xx [[ @@ @@ ]] xx rr rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr .. .. .. .. .. .. rr .. .. .. .. .. .. .. .. .. .. .. rr .. .. .. .. .. rr rr x! cc cc cc cc cc cc cc cc cc cc cc x! cc cc cc cc xx xx rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr .. .. .. .. .. .. rr .. .. .. .. .. .. .. .. .. .. .. rr .. .. .. .. .. rr rr xx cc cc 00 cc cc 00 cc cc 00 cc cc cc cc cc cc cc && xx rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr .. .. .. .. .. .. rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr rr xx cc cc 00 cc cc 00 cc cc 00 cc cc cc cc cc cc cc && xx rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr .. rr rr rr rr rr rr .. .. .. .. .. .. .. .. .. .. .. rr .. .. .. .. .. rr rr xx cc cc 00 cc cc 00 cc cc 00 cc cc cc cc cc cc cc && xx rr rr rr rr rr rr cc rr rr rr rr rr rr rr rr rr rr rr "
      "rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr .. .. .. .. .. rr rr x! cc cc cc cc cc cc cc cc cc cc cc x! cc cc cc cc && xx rr rr rr rr rr rr cc rr ,C ,R ,Y ,P ,T rr rr rr rr rr "
      "rr .. pp .. pp .. pp .. pp .. pp .. pp .. pp .. pp .. .. rr rr rr rr rr rr rr rr xx cc cc cc cc cc cc cc cc cc cc cc xx cc cc cc cc xx xx rr rr rr rr rr cc cc cc cc cc cc cc cc cc rr rr rr rr "
      "rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr rr rr rr rr rr rr rr xx ,D ,I ,N ,I ,N ,G @@ ,H ,A ,L ,L xx [[ @@ @@ ]] xx rr rr rr rr rr rr cc rr rr cc cc cc cc cc cc cc rr rr rr "
      "rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr rr rr rr rr rr rr rr xx xx x! xx xx xx x! xx xx xx x! xx xx xx xx xx xx xx rr rr rr rr rr rr cc rr cc cc cc cc cc cc cc rr rr rr rr "
      "rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr cc rr rr cc rr rr rr cc rr rr rr rr rr "
      "rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr cc rr cc cc cc rr cc cc cc rr rr rr rr "
      "rr .. pp .. pp .. pp .. pp .. pp .. pp .. pp .. pp .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr cc rr rr cc rr rr rr cc rr rr rr rr rr "
      "rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. rr .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr cc rr cc cc cc rr cc cc cc rr rr rr rr "
      "rr .. rr rr rr rr rr rr .. .. .. .. .. .. .. .. .. .. .. rr .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr cc rr rr cc rr rr rr cc rr rr rr rr rr "
      "rr .. .. .. .. .. .. rr .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc rr cc cc cc rr cc cc cc rr rr rr rr "
      "rr .. .. .. .. .. .. rr .. .. .. .. .. .. .. .. .. .. .. rr .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr cc rr rr rr cc rr rr rr rr rr "
      "rr .. .. .. .. .. .. rr .. .. .. .. .. .. .. .. .. .. .. rr .. .. .. .. .. rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr cc cc cc rr cc cc cc rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr cc rr rr rr cc rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
      "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
    )
  )
  #f #t #f #f
  ;; subplaces
  nil
  ;; neighbors
  (list
    (list ;; begin above neighbor
      (kern-mk-place 'p_green_tower "Green Tower"
        s_town ;; sprite
        (kern-mk-map
          nil           64 64 pal_expanded
          (list
            "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt bb .. /7 .. bb tt || || || || || || || || || || || || || || || || || || || || || || || || || || || || "
            "|| || || || || || || || || || || || rr rr rr rr rr rr rr || || || || || || || || || || tt tt .. /7 .. tt tt || || || || || || || || || || || || || || || || || || || || || || || || || || || || "
            "|| || rr rr rr rr rr || || || rr rr rr && cc cc cc cc rr || || || || || || || || || || tt bb .. /7 .. bb tt || || || || || || || || || || || || xx xx xx xx xx xx xx xx xx tt tt || || || || || "
            "|| || rr cc cc cc rr || || || rr cc rr cc cc cc cc cc rr || || || || || || || || || tt tt tt .. /7 .. tt tt || || || || || || || || || || || || xx .. .. .. .. .. .. .. xx tt tt tt || || || || "
            "|| || rr cc cc cc rr || || || rr cc cc cc cc cc cc cc rr || || || || || || || || || tt tt bb .. /4 /d /d /d /d /d /d /d /d /d /d /d /d /d /1 /d .. .. .. .. .. .. .. .. ws tt tt tt || || || || "
            "|| || rr cc cc cc rr || || || rr cc rr cc cc cc rr rr rr || || || || || || || || tt tt tt tt .. /7 .. bb tt || || || || || || || || || || /7 tt xx @@ @@ @@ @@ @@ @@ @@ xx tt tt tt || || || || "
            "|| || rr rr cc rr rr || || || rr cc rr cc cc cc cc cc rr || || || || || || || || tt tt tt bb .. /7 .. tt tt || || || || || || || || || || /7 .. .. .. .. .. .. .. .. .. xx tt tt || || || || || "
            "|| || || || /7 || || || || || || /7 rr rr rr rr rr rr rr || || || || || || || tt tt tt tt tt .. /7 .. tt tt || || || || || || || || || || /7 tt xx .S .H .R .O .O .M .S xx || || || || || || || "
            "|| || || || /8 /d /d /d /1 /d /d /a || || || || || || || || || || || || || || tt tt tt tt bb .. /7 .. bb tt || || || || || || || || || tt /7 tt xx xx xx xx xx xx xx xx xx || || || || || || || "
            "|| || || || || || || || /7 || || || || || || || || || || || || || || || || tt tt tt tt tt tt .. /7 .. tt tt || || || || || || || || tt tt /7 tt xx .. .. .. xx .. .. .. xx || || || || || || || "
            "|| || || rr rr rr || || /7 || || || || || || || || || || || || || || || || tt tt tt tt tt bb .. /7 .. bb tt || || || || || || || || tt tt /8 /d .. .. .. .. ?? .. .. .. ?? tt tt tt tt tt tt tt "
            "|| rr rr rr cc rr rr || /4 /d /d /d /d /d /d /d /d /d /d /2 || || || || tt tt tt tt tt tt tt .. /7 .. tt tt || || || || tt tt tt tt tt tt tt tt xx .. .. tt xx .. .. .. xx || || || || || || || "
            "|| rr cc cc cc cc rr rr /7 || || || || || || || || || || /7 || || || || tt tt tt tt tt tt bb .. /7 .. bb tt || || || || tt .. tt tt tt || || || xx xx ws xx xx xx .. xx xx || || || || || || || "
            "|| rr cc cc cc cc cc cc /a || || || || || || || || tt || /7 || || || tt tt tt tt tt tt tt tt .. /7 .. tt tt || tt tt tt tt .. .. tt || || || || || || || || || || || || || || || || || || || || "
            "|| rr rr cc cc cc rr rr || || || || || tt || || tt tt tt /7 || || || tt tt tt tt tt tt tt bb .. /7 .. bb tt || tt || || tt tt tt tt || || || || || || || || || || || || || || || || || || || || "
            "|| || rr rr && rr rr || tt || || || tt tt bb || || tt || /7 || tt tt tt tt tt tt tt tt tt tt .. /7 .. tt tt || tt || || || || || || || || || || || || || || || || || || || || || || || || || || "
            "|| || || rr rr rr || tt tt tt || tt tt .. tt || || tt bb /7 bb .. bb tt bb tt bb tt bb tt .. .. /7 .. .. tt bb tt bb tt tt bb tt bb tt bb tt tt || || || || || || || || || || || || || || || || "
            "|| || || tt || || || || tt || tt tt .. .. .. tt || tt .. /7 .. .. .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. .. .. .. .. .. .. .. .. bb tt || || || || || || || || || || || || || || || "
            "|| || tt tt tt || || || || || || tt tt .. tt || || bb .. /4 /d /d /d /d /d /d /d /d /d /d /d /d /5 /d /d /d /d /d /d /d /d /d /d /d /d /2 .. || tt || || || || || || || || || || || || || || || "
            "|| || || tt || || || || || tt tt tt tt tt tt || || tt .. /7 .. .. .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. .. .. .. .. .. .. /7 .. tt tt || || || || || || || || || || || || || || || "
            "|| || || || || || || tt tt tt tt tt tt tt || || || bb .. /7 .. .. .. bb tt bb tt bb tt .. .. .. /7 .. .. .. bb tt tt bb tt bb tt .. .. /7 .. bb tt || || || || || || || || || || || || || || || "
            "|| || || || || || tt tt tt .. tt tt tt || || || || tt .. /7 .. .. tt tt tt tt tt tt tt bb .. .. /7 .. .. bb tt tt tt tt tt tt bb tt .. /7 .. tt tt || || || || || || || || || || || || || || || "
            "|| || || || || bb tt tt .. .. .. tt tt tt || || || bb .. /7 .. bb tt || || || || || tt xx w+ xx cc xx w+ xx tt || || || || || tt tt .. /7 .. bb tt || || || || || || || || || || || || || || || "
            "|| || || || || tt tt .. .. .. .. .. tt tt || || || || .. /7 .. tt tt || || || || xx w+ xx cc cc cc cc cc xx xx xx || || || || tt bb .. /7 .. tt tt || || || || || || || || || || || || || || || "
            "|| || || || || tt tt tt .. .. .. tt tt tt || || || bb .. /7 .. bb tt || || xx xx xx cc cc cc cc cc cc cc cc cc xx xx xx || || tt tt .. /7 .. bb tt || || || || || || || || || || || || || || || "
            "|| || || || || tt tt tt tt .. tt tt tt || || || || || .. /7 .. tt tt || xx xx cc cc cc cc cc cc cc cc cc cc cc cc cc xx xx || tt bb .. /7 .. tt tt || || || || || || || || || || || || || || || "
            "|| || tt tt tt tt || tt tt tt tt bb || || tt tt || bb .. /7 .. bb tt || xx cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc xx || tt tt .. /7 .. tt tt || || || || || || || || || || || || || || || "
            "|| || tt || || || || || tt tt tt || || || || || || tt .. /7 .. tt tt xx xx cc cc cc xx x! xx xx cc xx xx x! xx cc cc cc xx xx tt bb .. /7 .. bb tt || || || || || || || || || || || || || || tt "
            "tt tt tt || || || || || || || || || || || || || tt bb .. /7 .. bb tt xx cc cc cc xx xx || tt .. cc .. tt || xx xx cc cc cc xx tt tt .. /7 .. tt tt || || || || || || || || || || || || || || tt "
            "bb tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt .. .. /7 .. tt bb xx cc cc cc x! || tt .. .. cc .. .. tt || x! cc cc cc xx bb .. .. /7 .. bb tt || || || || || || || || || || || || || || tt "
            ".. .. bb tt bb tt bb tt bb tt bb tt bb tt bb bb .. .. .. /7 .. .. .. w+ cc cc cc xx tt .. bb .. cc .. bb .. tt xx cc cc cc w+ .. .. .. /7 .. tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt "
            ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. /7 .. .. .. xx cc cc cc xx .. .. .. .. cc .. .. .. .. xx cc cc cc xx .. .. .. /7 .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
            "/d /d /d /d /d /d /d /d /d /d /d /d /d /d /d /d /d /d /d /5 /d /d /d cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc /d /d /d /5 /d /d /d /d /d /d /d /d /d /d /d /d /d /d /d /d /d /d "
            ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. /7 .. .. .. xx cc cc cc xx .. .. .. .. cc .. .. .. .. xx cc cc cc xx .. .. .. /7 .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
            ".. .. bb tt bb tt bb tt bb tt bb tt bb tt tt tt bb .. .. /7 .. .. .. w+ cc cc cc xx tt .. bb .. cc .. bb .. tt xx cc cc cc w+ .. .. .. /7 .. tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt "
            "bb tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt .. /7 .. .. bb xx cc cc cc x! || tt .. .. cc .. .. tt || x! cc cc cc xx bb .. .. /7 .. bb tt || || || || || || || || || || || tt tt tt tt "
            "tt tt || || || || tt tt tt tt tt tt tt tt || || tt tt .. /7 .. .. tt xx cc cc cc xx xx || tt .. cc .. tt || xx xx cc cc cc xx tt .. .. /7 .. tt tt || || || || || || || || || || || || || || tt "
            "tt tt || || || || tt tt tt tt tt tt tt tt || || tt bb .. /7 .. bb tt xx xx cc cc cc xx x! xx xx cc xx xx x! xx cc cc cc xx xx tt bb .. /7 .. bb tt || || || || || || || || || || || || || || || "
            "|| || || || || || || tt tt tt tt tt tt tt || || tt tt .. /7 .. tt tt || xx cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc xx || tt tt .. /7 .. tt tt || || || || || || || || || || || || || || || "
            "|| || || || || || || || tt tt tt tt tt tt || || tt bb .. /7 .. bb tt || xx xx cc cc cc cc cc cc cc cc cc cc cc cc cc xx xx || tt bb .. /7 .. bb tt || || || || || || || || || || || || || || || "
            "|| || || || || || || || || || || || || || || || tt tt .. /7 .. tt tt || || xx xx xx cc cc cc cc cc cc cc cc cc xx xx xx || || tt tt .. /7 .. tt tt || || || || || || || || || || || || || || || "
            "|| || || || || || || || || || || || || || || || tt bb .. /7 .. bb tt || || || || xx w+ xx cc cc cc cc cc xx xx xx || || || || tt bb .. /7 .. bb tt || || || || || || || || || || || || || || || "
            "|| || || || || || || || || || || || || || rr rr tt tt .. /7 .. tt tt || || || || || tt xx w+ xx cc xx w+ xx tt || || || || tt tt tt .. /7 .. tt tt || || || || || || || || || || || || || || || "
            "|| || || || || || || || || || || || || || || || tt bb .. /7 .. bb tt tt tt tt tt tt tt bb .. .. /7 .. .. bb tt tt tt tt tt tt tt bb .. /7 .. bb tt tt tt tt tt tt tt || || || || || || || || || "
            "|| || || || || || || tt tt tt tt || || || || || tt tt .. /7 .. .. tt bb tt bb tt bb .. .. .. .. /7 .. .. .. .. bb tt bb tt bb tt .. .. /7 .. .. tt bb tt bb tt bb tt || || || || || || || || || "
            "|| || || || || tt rr tt rr rr tt rr rr || || || tt bb .. /7 .. .. .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. .. tt tt || || || || || || || || || "
            "|| || || rr rr tt tt tt || || tt tt rr rr rr || tt tt .. /8 /d /d /d /d /d /d /d /d /d /d /d /d /5 /d /d /d /d /d /d /d /d /d /d /d /d /9 /d /d /d /d /d /2 .. bb tt || || || || || || || || || "
            "|| || || rr || || || tt tt tt || tt tt || rr || || bb .. .. .. .. .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. /7 .. tt tt || || || || || || || || || "
            "|| || || || tt tt tt tt .. .. tt || tt tt || rr rr || || tt bb tt bb tt bb tt bb tt bb tt bb .. /7 .. tt bb tt bb tt bb tt bb tt bb tt bb tt bb tt tt bb /4 /2 bb tt || || || || || || || || || "
            "|| rr rr || tt tt || .. .. bb .. tt tt tt tt || rr rr || tt tt tt tt tt tt tt tt tt tt tt tt .. /7 .. tt tt tt tt tt tt tt tt tt tt tt xx xx xx xx ws xx cc cc xx ws xx xx xx xx || || || || || "
            "|| || || || tt tt .. .. .. .. .. tt .. tt tt || || rr || || || || || || || || || || || || tt .. /7 .. tt || || || || || || || || || || xx cc cc cc cc cc cc cc cc cc cc cc cc xx || || || || || "
            "|| tt tt tt tt .. .. .. .. .. .. .. .. .. tt tt || tt tt || || || || || || || || || || || tt .. /7 .. tt || || || || || || || || || || xx cc cc cc cc cc cc cc cc cc cc cc cc xx || || || || || "
            "|| tt tt tt .. bb .. .. .. .. .. .. .. bb .. tt .. tt tt tt tt tt tt || || || || || || || tt .. /7 .. tt || || || || || || || || || || xx cc cc 00 cc cc cc cc cc cc 00 cc cc xx || || || || || "
            "|| || || tt .. .. .. .. .. aa .. .. .. .. .. tt || rr || || || || tt || || || || || || || tt .. /7 .. tt || || || || || || || || || || xx cc cc 00 cc cc && && cc cc 00 cc cc xx || || || || || "
            "|| rr || tt tt tt tt .. .. .. .. .. .. tt tt || || rr || || || || tt || || || || || || || tt .. /7 .. tt || || || || || || || || xx xx xx cc cc 00 cc cc cc cc cc cc 00 cc cc xx xx xx || || || "
            "|| rr || || || .. tt .. .. .. .. .. .. tt tt || rr || || || rr rr tt rr rr || || || || tt tt .. /7 .. tt || || || || || || || || xx cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc xx || || || "
            "|| rr rr || tt tt tt bb .. .. .. bb .. tt tt || rr || || rr rr tt tt tt rr rr || || || tt tt .. /7 .. tt || || || || || || || || xx cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc xx || || || "
            "|| || rr || tt tt tt tt tt .. .. .. .. tt || rr rr || || rr tt tt || tt || rr || || || tt tt .. /7 .. tt || || || || || || || || xx cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc xx || || || "
            "|| || || || || || || || tt tt tt tt tt || tt rr || || || rr tt || || || || rr || || || tt tt .. /7 .. || || || || || || || || xx xx cc xx xx @@ @@ @@ @@ @@ @@ @@ @@ @@ @@ xx xx cc xx xx || || "
            "|| || || rr rr || || || tt tt tt || tt tt || rr || || || rr tt tt || || || rr || || || tt tt .. /7 .. tt || || || || || || || xx cc cc cc xx cc cc cc cc cc cc cc cc cc cc cc cc cc cc xx || || "
            "|| || || || rr rr || rr rr rr || rr rr rr rr || || || || rr rr || || || tt rr || || || tt tt .. /7 .. tt || || || || || || || xx cc cc cc xx .W .H .I .T .E @@ .S .T .A .G xx cc cc cc xx || || "
            "|| || || || || || || || || || || || || || || || || || || || rr rr rr rr tt || || || tt tt tt .. /7 .. tt || || || || || || || xx cc cc cc xx xx xx xx xx xx xx xx xx xx xx xx cc cc cc xx || || "
            "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt tt .. /7 .. tt tt || || || || || || xx xx xx xx xx || || || || || || || || || || xx xx xx xx xx || || "
            "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt .. .. /7 .. .. tt tt || || || || || || || || || || || || || || || || || || || || || || || || || || || "
          )
        )
        #f #f #f #f
        ;; subplaces
        nil
        ;; neighbors
        nil
        ;; contents
        (list
          (list
            (bind
              (kern-mk-obj t_lever 1)
              (list
                #f
                'gtl-drawbridge-1
                #f
                '()
              )
            ) ;; bind
          35 29)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          7 13)
          (list
            (bind
              (kern-mk-obj t_ladder_down 1)
              (list
                'p_green_tower_lower
                32
                32
              )
            ) ;; bind
          32 32)
          (list
            (kern-tag 'white-stag-inn-room-door
              (bind
                (kern-mk-obj t_door 1)
                (list
                  #f
                  0
                  '()
                  #f
                  #t
                  #f
                  (list
                    (list
                      's_closed_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_open_door_in_stone
                      #f
                      0
                    )
                    (list
                      's_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_magically_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                  )
                )
              ) ;; bind
            ) ;; kern-tag
          44 58)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #t
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          48 10)
          (list
            (kern-mk-obj t_bed 1)
          51 9)
          (list
            (kern-mk-container
              t_chest
              ;; trap
              'burn-trap
              ;; contents
              (list
                (list 50 sulphorous_ash)
                (list 50 garlic)
                (list 50 ginseng)
                (list 50 blood_moss)
                (list 50 black_pearl)
                (list 50 spider_silk)
                (list 50 mandrake)
                (list 50 nightshade)
              )
            )
          53 9)
          (list
            (kern-mk-container
              t_chest
              ;; trap
              'poison-trap
              ;; contents
              (list
                (list 10 t_cure_potion)
                (list 10 t_heal_potion)
                (list 10 t_mana_potion)
                (list 10 t_poison_immunity_potion)
                (list 1 t_inv_potion)
              )
            )
          54 9)
          (list
            (kern-mk-obj t_bed 1)
          43 61)
          (list
            (kern-mk-container
              t_chest
              ;; trap
              'sleep-trap
              ;; contents
              (list
                (list 1 t_armor_leather)
                (list 1 t_sword)
                (list 1 t_shield)
                (list 1 t_leather_helm)
              )
            )
          55 9)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          41 32)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          32 22)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #t
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          54 12)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #t
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          59 58)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          57 59)
          (list
            (kern-mk-char
              'ch_wanderer
              "The Wanderer"
              sp_human
              oc_wanderer
              s_companion_ranger
              1
              0 70 62
              0 1
              10 5
              29 0
              3 1
              #f ;; dead?
              nil
              nil
              nil
              nil ;; inventory
              nil
              ;; hooks
              (list
              )
            )
          46 3)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          11 6)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          32 42)
          (list
            (kern-mk-obj t_bed 1)
          17 4)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          48 4)
          (list
            (bind
              (kern-mk-obj t_lever 1)
              (list
                #f
                'gtl-portcullis-1
                #f
                '()
              )
            ) ;; bind
          29 29)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          23 32)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          51 49)
          (list
            (kern-mk-obj t_bed 1)
          58 61)
          (list
            (kern-mk-container
              t_chest
              ;; trap
              nil
              ;; contents
              (list
                (list 100 t_arrow)
                (list 1 t_bow)
              )
            )
          4 11)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          52 49)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          16 6)
          (list
            (kern-mk-obj t_bed 1)
          2 13)
          (list
            (kern-mk-container
              t_chest
              ;; trap
              'burn-trap
              ;; contents
              (list
                (list 100 t_bolt)
                (list 1 t_crossbow)
                (list 1 t_shield)
                (list 2 t_cure_potion)
                (list 5 t_heal_potion)
              )
            )
          17 6)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          48 6)
          (list
            (bind
              (kern-mk-char
                'ch_shroom
                "Shroom"
                sp_human
                nil
                s_companion_druid
                2
                8 74 68
                0 0
                0 0
                26 0
                9 3
                #f ;; dead?
                'shroom-conv
                sch_shroom
                nil
                nil ;; inventory
                nil
                ;; hooks
                (list
                )
              )
              (list
                #t
                #t
              )
            ) ;; bind
          49 6)
        ) ;; end of objects
        (list
        )
        (list ;; edge entrances
          (list 0 63 63) ;; Northwest
          (list 1 32 63) ;; North
          (list 2 0 63) ;; Northeast
          (list 3 63 32) ;; West
          (list 4 32 32) ;; Here
          (list 5 0 32) ;; East
          (list 6 63 0) ;; Southwest
          (list 7 32 0) ;; South
          (list 8 0 0) ;; SoutheastUp
        )
      ) ;; end of place p_green_tower

    9) ;; end above neighbor
  )
  ;; contents
  (list
    (list
      (kern-tag 'gtl-drawbridge-1
        (bind
          (kern-mk-obj tf_drawbridge 1)
          (list
            #f
            '()
            #f
            's_ns_bridge
          )
        ) ;; bind
      ) ;; kern-tag
    32 16)
    (list
      (bind
        (kern-mk-obj t_ladder_up 1)
        (list
          'p_green_tower
          32
          32
        )
      ) ;; bind
    32 32)
    (list
      (kern-tag 'gtl-portcullis-1
        (bind
          (kern-mk-obj t_portcullis 1)
          (list
            #f
            'gtl-portcullis-2
            #f
            '()
          )
        ) ;; bind
      ) ;; kern-tag
    32 18)
    (list
      (kern-tag 'gtl-portcullis-2
        (bind
          (kern-mk-obj t_portcullis 1)
          (list
            #f
            '()
            #f
            '()
          )
        ) ;; bind
      ) ;; kern-tag
    33 18)
  ) ;; end of objects
  (list
  )
  (list ;; edge entrances
    (list 0 63 63) ;; Northwest
    (list 1 32 63) ;; North
    (list 2 0 63) ;; Northeast
    (list 3 63 32) ;; West
    (list 4 32 32) ;; Here
    (list 5 0 32) ;; East
    (list 6 63 0) ;; Southwest
    (list 7 32 0) ;; South
    (list 8 0 0) ;; SoutheastUp
  )
) ;; end of place p_green_tower_lower

(kern-mk-place 'p_shard "The Shard Surface"
  nil ;; sprite
  (kern-mk-composite-map
    nil     4 3
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ {{ ^^ {{ ^^ ^^ ^^ ^^ ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ {{ {{ {{ ^^ ^^ ^^ ^^ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ** ** ** "
        "** ** ** ** ** ** ** ** ** ^^ ^^ ^^ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** "
        "** ** ** ** ** ** ** ** ** ^^ ^^ ^^ {{ ^^ %% %% %% %% ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** "
        "** ** ** ** ** ** ** ** ** ^^ ^^ %% %% %% %% ^^ %% %% %% %% %% %% tt tt tt %% __ %% ^^ ^^ ^^ ** "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ %% ^^ ^^ ^^ ^^ %% %% %% %% %% %% %% tt %% __ __ __ ^^ ^^ ^^ ^^ "
        "** ** ** ** ** ** ** ** ^^ ^^ %% %% ^^ ^^ ^^ ^^ %% tt tt %% %% ^^ %% %% %% %% __ %% ^^ ^^ ^^ ^^ "
        "** ** ** ** ** ** ** ** ^^ ^^ %% ^^ ^^ ^^ ^^ %% %% tt tt %% ^^ ^^ ^^ %% tt %% %% %% {{ {{ ^^ {{ "
        "** ** ** ** ** ** ** ** ^^ ^^ %% %% %% %% %% %% tt ^^ tt %% %% ^^ %% %% tt tt tt tt ~~ {{ {{ {{ "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ %% ^^ %% %% %% %% tt tt tt %% %% %% tt tt tt %% %% ~~ ~~ ~~ ~~ "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ %% %% %% ^^ ^^ %% tt tt tt tt tt tt tt .. tt %% %% %% %% %% %% "
        "** ** ** ** ** ** ** ** ** ^^ ^^ ^^ %% ^^ ^^ ^^ %% %% %% .. tt tt tt %% %% tt tt tt %% tt %% %% "
        "** ** ** ** ** ** ** ** ** ^^ ^^ ^^ %% %% ^^ ^^ %% %% %% ^^ .. tt tt %% %% %% .. tt {{ {{ {{ tt "
        "** ** ** ** ** ** ** ** ** ^^ ^^ %% %% %% ^^ %% %% %% %% .. .. tt %% %% ^^ %% %% tt {{ {{ {{ tt "
        "** ** ** ** ** ** ** ** ** ^^ ^^ %% ^^ %% ^^ %% %% %% tt tt tt tt %% ^^ ^^ ^^ %% %% {{ {{ {{ tt "
        "** ** ** ** ** ** ** ** ** ^^ ^^ %% %% %% ^^ ^^ %% %% %% %% tt tt %% %% ^^ %% %% %% %% tt tt %% "
        "** ** ** ** ** ** ** ** ** ^^ ^^ ^^ %% %% ^^ ^^ %% %% __ %% %% tt tt tt %% %% %% %% %% tt %% %% "
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ %% %% %% %% __ __ __ %% tt ^^ tt tt tt tt %% %% %% %% __ "
        "** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ %% %% %% __ %% %% tt tt tt tt tt tt %% %% ^^ %% %% "
        "** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ tt %% %% %% tt tt %% %% %% tt tt %% ^^ ^^ ^^ %% "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ tt tt tt tt tt %% %% __ %% %% tt tt %% ^^ %% tt "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ .. .. .. .. tt %% __ __ __ %% tt tt %% %% %% tt "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ .. .. .. .. tt %% %% __ %% %% tt tt tt tt tt tt "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ {{ .. .. .. tt tt %% %% %% tt tt .. .. .. .. .. "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ {{ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ {{ {{ {{ ^^ ^^ ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ {{ {{ {{ {{ {{ ^^ ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ {{ {{ {{ ^^ ^^ ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ {{ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ^^ ^^ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "{{ {{ {{ {{ {{ {{ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "~~ ~~ ~~ ~~ ~~ {{ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ** ** ** ** ** ** ** ** "
        "~~ %% %% %% ~~ {{ ^^ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ** ** ** ** ** ** ** "
        "%% %% %% {{ ~~ {{ ^^ ^^ ^^ ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** ** ** ** ** "
        "tt tt {{ ^^ ~~ {{ ^^ ^^ ^^ ^^ ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ ^^ ^^ ^^ ** ** ** ** ** ** "
        "tt %% %% {{ ~~ ~~ ~~ ^^ ^^ ^^ ^^ ^^ ** ** ** ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ** ** ** ** "
        "%% %% __ {{ {{ ^^ ~~ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ** ** "
        "%% __ __ __ {{ ^^ ~~ ^^ ^^ ~~ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** "
        "%% %% __ %% {{ ^^ ~~ ^^ -- __ -- ^^ ^^ ^^ ^^ ^^ ^^ -- -- ^^ ^^ ^^ ^^ -- -- ^^ ^^ ^^ ^^ ^^ ^^ ** "
        "__ %% %% {{ {{ ^^ ~~ ~~ __ __ __ ~~ ~~ ~~ ^^ {{ -- -- -- -- -- -- -- -- -- -- -- -- ^^ ^^ ^^ ^^ "
        "__ __ %% {{ ^^ ^^ ^^ ^^ -- __ -- ^^ ^^ ~~ ~~ ~~ ~~ __ __ __ __ __ __ __ __ __ -- -- ^^ ^^ ^^ ^^ "
        "__ %% %% {{ ^^ ^^ ^^ ^^ ^^ ~~ ^^ ^^ ^^ ~~ ^^ {{ __ __ __ __ __ __ __ __ __ __ -- -- ^^ ^^ ^^ ^^ "
        "%% %% tt {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ~~ {{ ~~ __ __ __ __ __ __ __ __ __ __ -- -- -- -- ^^ ^^ "
        "tt tt tt {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ -- -- -- __ __ __ -- -- -- -- -- -- __ __ __ __ __ __ -- -- -- "
        ".. .. .. .. {{ ^^ ^^ ^^ ^^ ^^ ^^ {{ -- __ __ __ -- -- .. .. .. .. -- __ __ __ __ __ __ __ __ __ "
        ".. .. .. .. {{ {{ ^^ ^^ ^^ ^^ ^^ {{ -- __ __ __ -- .. .. .. .. .. -- -- __ __ __ __ __ __ __ __ "
        ".. .. .. .. .. {{ {{ ^^ ^^ ^^ {{ {{ -- __ __ __ -- .. .. .. .. .. .. -- -- __ __ __ __ __ __ __ "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ^^ ^^ "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** ** ** ^^ ^^ "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ** ** ** ** ** ** ** "
        "** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ {{ {{ tt tt tt tt tt {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ {{ {{ {{ {{ tt tt tt tt tt tt tt tt {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ** ** ** ** ** ** ^^ ^^ ^^ {{ {{ tt tt tt tt tt tt || || || || || {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ** ** ** ** ** ** ^^ ^^ {{ {{ tt tt tt tt || || || || %% %% %% || tt ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ** ** ** ** ** ** ^^ ^^ {{ tt tt || || || || || || %% %% ~~ %% || || || tt ^^ ^^ ^^ ^^ ^^ {{ "
        "** ** ** ** ** ** ^^ ^^ ^^ {{ tt tt || %% %% %% %% || || %% ~~ %% %% %% || tt ^^ ^^ ^^ ^^ {{ {{ "
        "** ** ** ** ** ** ^^ ^^ ^^ {{ tt tt || %% ~~ %% || || || || ~~ %% ~~ %% || tt tt ^^ ^^ ^^ {{ {{ "
        "** ** ** ** ** ** ^^ ^^ {{ {{ tt tt || %% ~~ %% || || || || ~~ || ~~ %% || || || || {{ {{ {{ {{ "
        "** ** ** ** ** ** ^^ ^^ {{ {{ tt tt || || ~~ || || tt tt tt ~~ ~~ ~~ || %% %% %% || tt {{ {{ {{ "
        "** ** ** ** ** ** ^^ ^^ ^^ {{ tt tt || || ~~ tt tt tt {{ tt tt tt ~~ || %% ~~ %% || tt tt {{ .. "
        "** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ tt tt || || ~~ tt tt {{ ^^ {{ tt ~~ ~~ || || ~~ %% || tt .. .. .. "
        "** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ tt tt || || ~~ ~~ tt tt {{ tt tt ~~ || || ~~ ~~ || || tt .. .. .. "
        "** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ tt tt || || || ~~ tt tt tt tt tt ~~ ~~ ~~ ~~ || || || tt .. .. .. "
        "** ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ tt tt || || || ~~ ~~ tt tt tt tt ~~ || || || || || || tt ^. {{ .. "
        "^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ .. tt tt tt || || || ~~ tt ~~ ~~ ~~ ~~ || || || || || tt tt ^^ {{ {{ "
        "^^ ^^ ^^ {{ {{ .. .. .. .. .. tt tt tt || || || ~~ ~~ ~~ || || || || || tt tt tt tt ^^ ^^ {{ {{ "
        "^^ ^^ ^^ {{ .. .. .. .. .. .. .. tt tt tt || || || || ~~ || || || || tt tt .. .. .. ^^ ^^ ^^ {{ "
        "^^ ^^ -- -- -- -- -- -- .. .. .. tt tt tt || || || || ~~ || -- -- -- -- -- -- .. .. ^^ ^^ ^^ {{ "
        "-- -- -- __ __ __ __ -- -- -- -- -- tt tt tt tt -- -- ~~ -- -- __ __ __ __ -- -- __ .. ^^ ^^ {{ "
        "__ __ __ __ __ __ __ __ __ __ __ -- tt tt tt tt -- __ __ __ __ __ __ __ __ __ -- -- -- .. ^^ ^^ "
        "__ __ __ __ __ __ __ __ __ __ __ -- .. .. .. .. -- __ __ __ __ __ __ __ __ __ __ __ -- .. ^^ ^^ "
        "-- -- -- -- -- -- -- -- __ __ __ -- .. .. .. -- -- __ __ __ __ __ __ __ __ __ __ __ -- .. ^^ ^^ "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ {{ {{ {{ {{ .. .. .. .. .. .. .. .. .. .. .. .. .. .. {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ {{ {{ {{ .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. {{ .. .. .. ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "{{ {{ {{ .. .. .. .. tt tt tt tt tt tt tt tt tt tt tt tt .. .. .. .. .. .. .. .. ^^ ^^ ^^ ^^ ^^ "
        "{{ {{ {{ .. .. tt tt tt tt tt tt tt tt tt tt tt tt tt tt .. .. .. .. .. .. .. .. ^^ ^^ ^^ ^^ ^^ "
        "{{ {{ .. .. .. tt tt tt || || || || || || || || || tt tt tt .. .. .. .. .. .. .. .. ^^ ^^ ^^ ^^ "
        "{{ .. .. .. .. tt tt || || || || || || || || || || tt tt tt -- -- -- .. .. .. .. .. .. .. ^^ ^^ "
        ".. .. .. .. tt tt tt || || ~~ ~~ ~~ ~~ ~~ ~~ || || || tt -- -- -- -- .. .. .. .. .. .. .. .. ^^ "
        ".. .. tt tt tt tt tt || || || || || || || ~~ || || || tt -- -- -- -- -- .. .. .. .. .. .. .. ^^ "
        ".. .. tt tt tt || || || || || || || || || ~~ ~~ || || || -- -- -- -- -- .. .. .. .. .. .. .. ^^ "
        ".. .. tt tt || || || || || || || || || || || ~~ ~~ || -- -- -- -- -- -- -- -- .. .. .. .. __ -- "
        ".. .. tt tt || || ~~ ~~ ~~ ~~ ~~ ~~ ~~ || || || -- -- -- -- -- __ -- -- -- -- -- -- -- -- -- -- "
        ".. .. tt tt || || || || || || || || ~~ ~~ ~~ ~~ -- -- -- -- -- __ __ __ -- -- -- -- -- -- -- -- "
        ".. .. tt tt tt || || || || || || || || || ~~ || || || -- -- __ __ __ __ __ __ __ __ __ __ __ __ "
        ".. .. tt tt tt || || || || ~~ ~~ ~~ ~~ ~~ ~~ || || || -- -- __ __ __ __ __ __ __ __ __ __ __ __ "
        ".. .. .. tt tt || || ~~ ~~ ~~ || || || || || || || tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ "
        "{{ .. .. tt tt || || || || || || || || || || || || -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "{{ .. .. tt tt tt || || || || || || || tt tt tt tt -- -- __ -- __ __ __ __ __ __ __ __ __ __ __ "
        "{{ {{ .. .. tt tt tt tt tt tt tt tt tt tt tt tt tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "{{ {{ .. .. .. .. tt tt tt tt tt tt tt tt tt .. .. -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "{{ {{ {{ .. .. .. .. .. .. .. .. .. .. .. .. .. .. -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "{{ {{ {{ {{ {{ {{ {{ .. .. .. .. .. .. {{ {{ {{ {{ -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ {{ {{ {{ .. .. tt tt tt tt tt .. {{ {{ {{ .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ {{ .. .. .. .. {{ {{ ^^ {{ {{ .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ {{ {{ {{ .. {{ ^^ ^^ ^^ {{ .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ {{ {{ .. {{ {{ ^^ {{ {{ .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ .. .. {{ {{ {{ .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ .. .. .. .. .. {{ "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ .. {{ {{ "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ .. {{ {{ "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ .. .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ .. .. .. .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ .. .. .. .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ {{ ~~ {{ {{ {{ {{ .. .. .. .. .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ {{ ~~ .. .. .. .. .. .. .. .. .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ {{ {{ {{ .. ~~ .. .. ~~ .. .. .. .. .. .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ ~~ ~~ ~~ .. .. ~~ .. .. .. .. .. .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ {{ .. ~~ .. .. ~~ .. .. .. .. .. .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ .. .. ~~ ~~ ~~ ~~ .. .. .. .. .. .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ .. .. .. .. .. ~~ .. .. .. .. .. .. .. .. "
        "** ** ** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ .. .. .. .. .. /d ~~ /d /d /d /d /d /7 .. .. "
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ {{ .. .. .. .. .. .. ~~ .. .. .. .. .. /8 /d /d "
        "** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ .. .. .. .. .. .. ~~ ~~ ~~ ~~ .. .. .. .. .. "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ .. .. .. .. .. .. .. .. .. ~~ .. .. .. .. ~~ "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ .. .. .. ~~ ~~ .. .. .. ~~ .. .. .. .. ~~ "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ ^^ ^^ {{ {{ .. .. .. .. ~~ .. .. .. ~~ ~~ -- -- -- -- "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ ^^ ^^ {{ {{ .. .. ~~ ~~ ~~ ~~ .. .. .. .. -- __ __ -- "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ {{ ^^ ^^ {{ .. .. .. .. .. ~~ ~~ ~~ ~~ -- -- __ __ -- "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ {{ ^^ {{ {{ .. .. .. .. .. .. ~~ .. -- -- __ __ -- -- "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ ^^ ^^ ^^ {{ .. .. .. .. ~~ ~~ .. ~~ .. .. -- -- -- -- -- "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ {{ ^^ ^^ {{ .. .. .. .. .. ~~ ~~ ~~ .. .. -- -- tt tt ~~ "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ .. .. ~~ ~~ ~~ ~~ .. .. .. .. -- -- tt tt tt "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ .. .. .. .. .. .. .. .. .. -- -- tt tt tt tt "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        ".. .. .. .. .. .. {{ {{ {{ {{ {{ -- -- __ __ __ -- .. .. .. .. .. .. .. -- __ __ __ __ __ -- -- "
        ".. .. .. {{ .. .. .. .. .. .. .. -- __ __ __ __ -- -- .. .. .. .. .. .. -- __ __ __ __ __ -- -- "
        ".. .. {{ {{ {{ .. .. .. .. .. .. -- -- __ __ __ __ -- -- -- .. .. .. .. -- __ __ -- -- -- -- -- "
        ".. {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ .. -- __ __ __ __ __ __ -- .. .. .. -- -- __ __ -- -- -- -- -- "
        "{{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ -- -- __ __ __ __ __ -- -- -- -- -- __ __ __ -- -- ^^ ^^ ^^ "
        "{{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ -- __ __ __ __ __ __ __ __ __ __ __ __ -- -- ^^ ^^ ^^ ^^ "
        "{{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ -- __ __ __ __ __ __ __ __ __ __ __ __ -- -- ^^ ^^ ^^ ^^ "
        "{{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ -- -- -- -- -- -- -- -- -- __ __ __ -- -- -- ^^ ^^ ^^ ^^ "
        "{{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ -- ^^ ^^ ^^ ^^ ^^ -- -- -- __ -- ^^ ^^ ^^ ^^ ^^ ^^ "
        ".. .. .. {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ -- -- -- ^^ ^^ ^^ ^^ ^^ ^^ "
        ".. .. .. {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        ".. .. .. ~~ {{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        ".. .. .. ~~ {{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ tt {{ tt {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        ".. .. .. ~~ .. .. .. {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ tt .. .. .. tt {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        ".. .. .. ~~ .. ~~ ~~ ~~ ~~ ~~ ~~ ^^ ^^ ^^ ^^ ^^ {{ {{ .. .. .. {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        ".. .. .. ~~ .. ~~ .. {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ {{ tt .. /3 .. tt {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        ".. .. .. ~~ ~~ ~~ .. .. {{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ {{ tt /7 tt {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ .. {{ "
        ".. .. .. .. .. ~~ ~~ ~~ ~~ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ {{ /7 {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ .. .. .. "
        ".. ~~ ~~ ~~ ~~ ~~ .. .. ~~ ~~ ~~ {{ ^^ {{ {{ ^^ ^^ ^^ ^^ /7 ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ .. .. .. .. "
        ".. ~~ .. .. .. .. .. .. .. .. {{ {{ ^^ {{ {{ ^^ ^^ ^^ ^^ /7 ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ .. .. .. "
        "/d ~~ /d /d /2 .. .. .. .. .. {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ /7 ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ .. {{ "
        ".. ~~ .. .. /7 .. .. .. .. .. .. {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ /7 ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "~~ ~~ .. .. /7 .. .. .. .. .. .. {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ /7 ^^ ^^ ^^ ^^ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ "
        ".. .. .. .. /7 .. .. .. .. {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ /7 ^^ ^^ ^^ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        ".. .. .. .. /7 .. .. .. .. {{ {{ {{ ^^ ^^ ^^ ^^ {{ ^. ^^ /7 ^^ ^^ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ {{ "
        ".. .. .. .. /7 .. .. .. .. {{ {{ ^^ ^^ ^^ ^^ {{ {{ {{ {{ /7 {{ {{ {{ {{ tt {{ {{ {{ ^^ ^^ ^^ {{ "
        ".. .. .. .. /8 /d /d /d /d /2 {{ ^^ ^^ ^^ ^^ {{ tt tt tt /7 tt tt tt tt tt tt tt tt {{ ^^ {{ {{ "
        ".. .. .. .. .. .. .. .. {{ /7 {{ ^^ ^^ {{ {{ {{ tt tt tt /7 tt tt tt tt tt tt tt tt {{ {{ {{ tt "
        "~~ .. .. .. .. .. .. {{ {{ /7 {{ ^^ ^^ ^^ {{ .. .. .. .. /7 tt tt tt tt tt tt tt tt tt tt tt tt "
        "-- -- ~~ .. .. .. {{ {{ {{ /8 /d /d /d /d /d /d /d /2 .. /7 .. .. tt tt tt tt || || || || || || "
        "tt ~~ -- ~~ ~~ ~~ ~~ ~~ ~~ {{ {{ {{ ^^ ^^ {{ .. .. /8 /d /9 /2 .. tt tt tt || || || || || || || "
        "tt tt ~~ -- {{ {{ {{ {{ ~~ ~~ {{ {{ ^^ ^^ {{ {{ .. .. .. .. /7 .. .. .. tt || || || || || || || "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "-- .. .. .. .. .. .. -- __ __ __ -- -- -- -- -- __ __ __ __ -- -- -- -- __ __ __ -- -- .. ^^ ^^ "
        ".. .. {{ {{ {{ {{ .. -- __ __ __ __ __ __ __ __ __ __ __ -- -- .. .. -- __ __ __ -- .. .. .. ^^ "
        ".. {{ {{ {{ {{ {{ {{ -- -- __ __ __ __ __ __ __ __ __ __ -- .. .. .. -- -- __ __ -- -- .. .. {{ "
        "{{ {{ ^^ ^^ ^^ ^^ {{ {{ {{ __ __ __ __ __ __ __ __ __ -- -- .. .. .. .. -- __ __ __ -- -- -- -- "
        "^. ^. ^. ^. ^. ^. ^. ^. {{ -- -- __ __ __ __ -- -- -- -- ^. ^. ^. ^. ^. -- __ __ __ __ __ __ __ "
        "^. ^. ^. ^. ^. ^. ^. ^. ^. ^. -- -- -- -- -- -- ^. ^. ^. ^. ^. ^. ^. ^. -- __ __ __ __ __ __ __ "
        "^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. -- -- __ __ __ __ __ __ "
        "^. tt tt tt ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^. ^^ -- -- -- -- __ __ __ "
        "tt tt tt tt tt ^^ ^^ ^^ ^^ ^^ || ^^ ^. ^. ^. ^. ^. ^. ^. ^. ^^ tt tt ^^ ^^ ^^ ^^ ^^ -- -- __ __ "
        "tt tt tt tt tt tt ^^ ^^ ^^ || || || ^. ^. ^. ^. ^. ^. ^. tt tt tt tt tt ^^ ^^ ^^ ^^ ^^ -- -- __ "
        "tt tt tt tt tt tt tt ^^ tt || || || ^. ^. ^. ^. ^. ^. ^. tt tt tt tt tt ^^ ^^ ^^ ^^ ^^ -- -- __ "
        "^^ tt tt tt ^^ tt tt tt tt tt || ^^ ^. ^. ^. ^. ^. tt tt tt tt tt tt ^^ ^^ ^^ ^^ ^^ ^^ -- -- __ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ tt tt tt tt ^^ ^^ ^^ || || || || tt tt ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ -- -- __ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ tt tt || || ^^ ^^ || || || || || tt ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ -- -- -- -- "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ tt tt || || || || || || || || || || || ^^ ^^ ^^ ^^ ^^ ^^ ^^ .. -- -- -- "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ tt tt || || || || || || || || || || || || ^^ ^^ ^^ ^^ ^^ ^^ .. .. .. -- "
        "^^ ^^ ^^ ^^ ^^ {{ {{ {{ tt tt || || || || || || || || || || || || || || ^^ ^^ ^^ ^^ .. .. .. -- "
        "{{ {{ {{ {{ ^^ {{ tt tt tt || || || || || || || || || || || || || || || ^^ ^^ ^^ ^^ ^^ .. .. .. "
        ".. .. .. {{ {{ {{ tt || || || || || || || || || || || || || || || || || ^^ ^^ ^^ ^^ ^^ ^^ .. .. "
        "{{ {{ .. .. {{ tt tt || || || || || || || || || || || || || || || || || ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ {{ {{ .. .. tt tt || || || || || || || || || || || || || || || || || || ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ {{ .. tt tt tt || || || || || || || || || || || || || || || || || || ^^ ^^ ^^ ^^ ^^ ^^ tt "
        "^^ {{ {{ tt tt tt || || || || || || || || || || || || || || || || || || || || || ^^ ^^ ^^ ^^ tt "
        "{{ {{ tt tt tt || || || || || || || || || || || || || || || || || || || || || || || || || tt tt "
        "{{ tt tt || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt "
        "tt tt || || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt "
        "tt || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt "
        "tt || || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt "
        "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt "
        "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt tt "
        "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt tt "
        "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt tt "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "{{ ^. {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "^^ ^. ^. ^. -- {{ {{ {{ {{ {{ {{ {{ {{ {{ {{ .. -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "^. ^. ^. ^. -- -- __ __ __ __ __ -- -- -- -- -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- ^. ^. -- -- __ __ __ __ __ __ __ -- -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt -- -- -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt -- -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ .. .. .. .. .. .. .. .. .. .. -- -- tt tt tt tt "
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ ^^ {{ {{ .. .. .. .. .. .. .. .. .. .. ~~ -- -- -- tt tt tt "
        "** ** ** ** ** ** ** ** ** ** ^^ ^^ {{ {{ .. .. .. .. .. .. .. .. .. .. -- -- -- __ -- -- tt tt "
        "** ** ** ** ** ** ** ** ** ^^ ^^ ^^ {{ .. .. .. {{ {{ {{ {{ .. .. .. .. -- -- __ __ __ -- tt tt "
        "** ** ** ** ** ** ** ** ^^ ^^ ^^ ^^ {{ .. .. {{ {{ ^^ ^^ {{ {{ .. .. .. -- -- -- __ -- -- tt tt "
        "** ** ** ** ** ** ** ^^ ^^ ^^ ^^ ^^ {{ .. .. {{ ^^ ^^ ^^ ^^ {{ .. .. -- -- -- -- -- -- tt tt tt "
        "** ** ** ** ** ** {{ {{ ^^ ^^ ^^ ^^ {{ .. .. {{ ^^ ^^ ^^ ^^ {{ .. .. -- -- -- -- tt tt tt tt tt "
        "** ** ** ** {{ {{ {{ ^^ ^^ ^^ ^^ ^^ {{ .. .. {{ {{ ^^ ^^ {{ {{ .. .. -- -- -- tt tt tt tt tt tt "
        "^^ ^^ {{ {{ {{ {{ ^^ ^^ ^^ ^^ {{ {{ .. .. .. .. {{ {{ {{ {{ .. .. .. -- -- -- tt tt tt {{ {{ {{ "
        "^^ ^^ ^^ {{ {{ {{ ^^ ^^ ^^ {{ {{ .. .. .. .. .. .. .. .. .. .. .. -- -- -- -- -- tt tt {{ ^^ ^^ "
        "^^ ^^ ^^ {{ {{ ^^ ^^ ^^ {{ {{ .. .. .. .. .. .. .. .. .. .. .. -- -- -- -- ~~ -- -- -- ^^ ^^ ^^ "
        "^^ ^^ ^^ {{ ^^ ^^ ^^ ^^ {{ .. .. .. .. .. .. .. .. .. .. .. .. -- ~~ -- -- -- -- -- -- ^^ ^^ ^^ "
        "^^ ^^ ^^ {{ ^^ ^^ ^^ ^^ {{ .. .. .. .. .. .. __ __ __ .. .. ~~ ~~ -- -- -- -- -- -- ^^ ^^ ^^ ^^ "
        "^^ ^^ {{ {{ {{ ^^ ^^ ^^ .. .. .. .. .. .. __ __ __ __ __ __ __ __ __ -- -- -- -- -- -- ^^ ^^ ^^ "
        "^^ ^^ ^^ {{ ^^ ^^ ^^ ^^ .. .. .. .. .. __ __ __ __ __ __ __ __ __ __ __ -- __ __ __ -- ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ ^^ {{ {{ {{ .. .. .. .. .. __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ -- -- ^^ ^^ "
        "^^ ^^ ^^ ^^ {{ {{ ~~ ~~ ~~ .. .. .. .. .. __ __ __ __ __ .. __ __ __ __ __ __ __ __ __ -- ^^ ^^ "
        "^^ ^^ ^^ {{ {{ ~~ ~~ ~~ ~~ ~~ ~~ .. .. .. .. __ __ __ .. .. .. -- __ __ __ __ __ __ __ -- -- -- "
        "^^ ^^ ^^ {{ ~~ ~~ -- ~~ ~~ ~~ ~~ .. .. .. .. .. .. .. .. .. .. -- __ __ __ __ __ __ __ __ __ __ "
        "^^ ^^ ^^ {{ ~~ -- -- -- -- -- ~~ ~~ .. .. .. .. .. .. .. .. -- -- -- -- -- __ __ __ __ __ __ __ "
        "^^ ^^ ^^ {{ ~~ -- -- -- -- -- ~~ ~~ ~~ ~~ .. .. .. .. -- -- -- ~~ ~~ ~~ -- -- __ __ __ __ __ __ "
        "^^ ^^ ^^ {{ ~~ ~~ -- -- -- -- ~~ ~~ ~~ ~~ ~~ -- -- -- -- -- ~~ ~~ .. ~~ ~~ -- __ __ __ __ __ __ "
        "^^ ^^ ^^ {{ {{ ~~ ~~ -- -- ~~ ~~ .. ~~ ~~ ~~ ~~ ~~ ~~ ~~ -- ~~ .. .. .. ~~ -- __ -- -- -- -- -- "
        "^^ ^^ ^^ ^^ {{ {{ ~~ ~~ ~~ ~~ .. .. .. ~~ -- -- -- -- -- -- ~~ ~~ .. ~~ ~~ -- -- -- -- {{ {{ {{ "
        "^^ ^^ ^^ ^^ ^^ {{ {{ {{ ~~ ~~ ~~ .. ~~ ~~ -- -- -- -- -- -- -- ~~ ~~ ~~ -- -- -- {{ {{ {{ ^^ {{ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ ~~ ~~ ~~ ~~ ~~ -- -- -- -- -- -- -- -- -- -- -- -- ~~ {{ {{ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ ~~ ~~ -- -- -- -- ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ {{ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ ~~ ~~ ~~ ~~ ~~ ~~ {{ {{ {{ {{ {{ {{ ~~ ~~ {{ {{ {{ ^^ ^^ ^^ ^^ {{ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ {{ {{ {{ ^^ ^^ ^^ ^^ {{ {{ {{ {{ ^^ ^^ ^^ ^^ {{ {{ {{ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ -- -- "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ -- "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ -- "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "tt tt ~~ {{ {{ ^^ {{ {{ {{ ~~ {{ {{ {{ ^^ ^^ {{ tt tt tt .. /8 /d /d /d /d /d || || || || || || "
        "tt tt ~~ {{ ^^ ^^ ^^ ^^ {{ ~~ ~~ {{ ^^ ^^ ^^ {{ {{ {{ {{ .. .. .. .. .. tt || || || || || || || "
        "tt tt ~~ {{ ^^ ^^ ^^ ^^ {{ {{ {{ {{ ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ {{ tt tt tt || || || || || || || "
        "tt tt ~~ {{ {{ ^^ ^^ ^^ ^^ ^^ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ tt tt || || || || || || "
        "tt tt ~~ ~~ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ tt || || || || || || "
        "tt tt tt ~~ ~~ ~~ ~~ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ ^^ ^^ ^^ ^^ {{ tt || || || || || || "
        "tt tt tt tt tt tt tt {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ ~~ {{ {{ ^^ ^^ ^^ {{ tt tt tt tt tt tt tt "
        "tt tt tt tt tt {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ ~~ -- ~~ {{ ^^ ^^ ^^ {{ tt {{ {{ {{ {{ {{ tt "
        "{{ {{ tt {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ ~~ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ "
        "^^ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ~~ ^^ ^^ ^^ ^^ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ~~ ^^ ^^ ^^ {{ {{ ~~ {{ {{ ^^ ^^ ^^ ^^ ^^ "
        "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^. ^. ^^ ~~ ~~ ^^ ~~ ~~ ~~ ~~ -- ~~ {{ ^^ ^^ ^^ ^^ ^^ "
        "{{ ^^ ^^ ^^ ^^ {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ~~ ^^ ^^ ~~ ^^ {{ {{ ~~ {{ {{ ^^ ^^ {{ {{ {{ "
        "{{ ^^ {{ {{ {{ {{ .. .. {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ ~~ ~~ ~~ ~~ ~~ ^^ ^^ {{ {{ {{ ^^ ^^ {{ {{ {{ {{ "
        "{{ {{ {{ .. .. .. .. .. .. {{ {{ ^^ ^^ ^^ ^^ ^^ ~~ ^^ ^^ ^^ ~~ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ tt "
        ".. .. .. .. .. .. .. .. .. .. {{ ^^ ^^ ^^ ^^ ~~ ~~ ^^ ^^ ^^ ~~ ~~ ~~ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ tt "
        "-- __ __ __ __ __ __ __ .. .. {{ {{ ^^ ^^ __ ~~ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ .. .. "
        "-- __ __ __ __ __ __ __ .. .. .. .. __ __ __ __ __ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ {{ {{ {{ .. .. "
        "__ __ __ __ __ __ __ __ .. .. .. .. __ __ __ __ __ __ __ ^^ ^^ ^^ __ __ __ {{ {{ {{ {{ .. .. .. "
        "__ __ __ __ __ __ __ __ .. .. .. .. __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ {{ {{ .. .. .. "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ .. "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "{{ -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "{{ -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "{{ -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "{{ -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt "
        "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt "
        "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt "
        "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt "
        "|| || || || || || || || || || || || || || || || || || || || || || || || || || || || || tt tt tt "
        "|| || || || || || || || || || || || tt tt tt tt tt tt || || || || || || || || || || || tt tt tt "
        "|| || || || || || || || || tt tt tt tt {{ {{ {{ {{ tt || || || || || || || || tt tt tt tt tt tt "
        "tt tt || || || || tt tt tt tt {{ {{ {{ {{ ^^ ^^ {{ tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt "
        "{{ tt tt || || || tt {{ {{ {{ {{ ^^ ^^ ^^ ^^ ^^ {{ tt ~~ ~~ ~~ ~~ ~~ ~~ tt tt tt tt tt tt tt -- "
        "{{ {{ tt || || tt tt {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ {{ tt tt tt tt tt tt ~~ tt tt tt tt tt tt tt -- "
        "{{ {{ tt tt tt tt {{ {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ {{ tt {{ {{ {{ tt tt tt ~~ tt tt tt -- -- -- -- -- "
        "{{ tt tt tt tt tt {{ {{ {{ {{ {{ {{ {{ ^^ ^^ {{ {{ ^^ ^^ {{ {{ tt tt ~~ ~~ ~~ ~~ ~~ -- -- -- -- "
        "{{ tt tt tt .. .. .. {{ {{ tt tt tt {{ ^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ tt tt tt ~~ tt -- -- -- -- -- -- "
        "tt tt tt tt .. .. .. .. .. .. .. tt {{ {{ ^^ ^^ ^^ ^^ ^^ ^^ {{ tt tt tt ~~ tt tt -- -- -- -- -- "
        "tt .. .. .. .. .. .. .. .. .. .. .. .. {{ {{ {{ ^^ ^^ ^^ ^^ {{ {{ tt tt ~~ tt -- -- -- -- tt tt "
        "tt .. .. .. .. .. .. .. .. .. .. -- -- .. .. {{ {{ ^^ ^^ ^^ ^^ {{ {{ {{ ~~ -- -- -- tt tt tt tt "
        ".. .. .. .. .. .. .. .. -- -- -- -- -- -- .. .. {{ ^^ ^^ ^^ ^^ ^^ {{ {{ -- -- -- -- tt tt tt tt "
        ".. .. .. .. .. .. .. .. .. -- -- -- -- -- -- .. {{ ^^ ^^ ^^ ^^ {{ {{ {{ -- -- -- -- -- tt tt tt "
        ".. .. .. .. .. .. .. .. .. -- -- __ __ -- -- -- {{ ^^ ^^ ^^ ^^ {{ {{ -- -- ~~ -- -- -- -- tt tt "
        ".. .. .. .. .. .. .. .. -- -- -- __ __ -- -- -- {{ {{ {{ ^^ {{ -- -- -- -- ~~ -- -- ~~ -- -- -- "
        ".. .. .. .. .. .. -- -- -- -- -- __ __ __ -- -- -- -- {{ ^^ {{ -- -- -- ~~ ~~ ~~ __ -- ~~ -- -- "
        ".. .. .. .. -- -- -- -- -- -- __ __ __ __ __ -- -- -- {{ {{ {{ -- -- __ __ ~~ __ __ __ __ ~~ ~~ "
        "__ __ __ -- -- -- -- -- __ __ __ __ __ __ __ __ -- -- -- -- -- -- -- __ __ __ __ __ __ __ __ __ "
        "__ __ __ -- -- -- __ __ __ __ __ __ __ __ __ __ -- -- -- -- -- -- __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
      )
    )
    (kern-mk-map nil 32 32 pal_expanded
      (list
        "tt tt -- -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt tt -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- -- -- ~~ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- -- ~~ ~~ ~~ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- tt -- -- ~~ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- tt tt -- -- -- -- -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- tt tt -- -- tt tt tt -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- -- tt tt tt tt -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- -- -- tt tt tt tt -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt -- -- -- tt tt tt -- -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt -- ~~ -- -- -- -- -- ~~ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "tt -- -- ~~ ~~ ~~ ~~ ~~ -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- ~~ -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- -- ~~ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "-- ~~ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "~~ -- __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
        "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
      )
    )
  )
  #f #f #t #f
  ;; subplaces
  (list
    (list
      (kern-mk-place 'p_moongate_clearing "Moongate Clearing"
        s_shrine ;; sprite
        (kern-mk-map
          nil           23 28 pal_expanded
          (list
            "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ tt tt tt tt tt ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ "
            "^^ {{ {{ {{ ^^ ^^ ^^ ^^ tt tt tt || || ^^ ^^ ^^ {{ {{ {{ ^^ {{ {{ ^^ "
            "^^ {{ {{ {{ {{ ^^ tt tt tt || tt tt || || ^^ ^^ {{ tt {{ ^^ ^^ {{ ^^ "
            "^^ {{ {{ {{ {{ {{ tt || || || || tt || || || ^^ tt tt {{ {{ ^^ {{ ^^ "
            "^^ ^^ {{ {{ {{ tt || || || || tt tt tt || || tt tt tt tt {{ {{ {{ ^^ "
            "^^ ^^ ^^ ^^ tt tt || || || tt tt tt tt tt tt tt tt tt tt tt {{ ^^ ^^ "
            "^^ ^^ ^^ ^^ || || || || tt tt tt bb tt tt tt tt tt tt || ^^ ^^ ^^ ^^ "
            "^^ ^^ ^^ ^^ || || || tt tt bb .. .. .. bb tt tt tt || || || ^^ ^^ || "
            "^^ ^^ ^^ ^^ || || tt tt tt tt .. .. .. tt tt tt tt tt || || || || || "
            "^^ ^^ || || || || tt tt bb .. .. .. .. .. bb tt tt tt tt tt tt tt tt "
            "^^ || || || || || tt tt .. .. .. .. .. .. .. tt tt tt tt tt tt tt tt "
            "{{ || || || || || tt bb .. .. .. .. .. .. .. bb tt tt tt tt tt tt {{ "
            "{{ {{ || || || tt tt tt .. .. .. .. .. .. .. tt tt tt {{ {{ tt {{ {{ "
            "^^ {{ {{ {{ {{ tt tt tt bb .. .. .. .. .. bb tt tt {{ {{ {{ {{ {{ {{ "
            "^^ ^^ ^^ {{ {{ {{ tt tt tt tt .. .. .. tt tt tt {{ ^^ ^^ {{ {{ ^^ ^^ "
            "^^ ^^ ^^ ^^ {{ {{ {{ tt tt bb .. .. .. bb tt tt {{ ^^ ^^ ^^ {{ {{ ^^ "
            "^^ ^^ .. ^^ ^^ ^^ {{ {{ tt tt .. .. .. tt tt tt tt {{ ^^ ^^ {{ {{ ^^ "
            "^^ .. .. .. .. ^^ {{ {{ tt bb .. .. .. bb tt tt {{ {{ {{ {{ {{ ^^ ^^ "
            "^^ .. .. .. .. ^^ {{ {{ tt tt .. .. .. tt tt tt tt tt tt {{ ^^ ^^ ^^ "
            "^^ .. .. .. .. ^^ {{ {{ tt bb .. .. .. bb tt bb tt bb tt tt ^^ ^^ ^^ "
            "^^ ^^ .. ^^ ^^ ^^ {{ {{ tt tt .. .. .. .. .. .. .. .. tt tt ^^ ^^ ^^ "
            "^^ ^^ ^^ ^^ ^^ ^^ ^^ {{ tt bb .. .. .. .. .. .. .. .. bb tt ^^ ^^ ^^ "
            "^^ ^^ ,H ,A ,I ,L ^^ ^^ tt tt .. .. .. .. .. .. .. .. tt tt ^^ ^^ ^^ "
            "^^ .. .. .. .. .. .. ^^ tt tt bb .. bb tt bb .. .. .. bb tt tt ^^ ^^ "
            "^^ .. .. .. .. .. .. .. .. .. .. .. tt tt tt .. .. .. tt tt tt tt ^^ "
            "^^ .. .. .. .. .. .. ^^ tt || tt tt tt tt bb .. .. .. bb tt tt tt tt "
            "^^ ,S ,E ,E ,K ,E ,R ^^ || || || tt tt tt .. .. .. .. .. tt tt tt tt "
            "^^ ^^ ^^ ^^ ^^ ^^ ^^ ^^ tt || tt tt tt bb .. .. .. .. .. bb tt tt tt "
          )
        )
        #f #f #f #f
        ;; subplaces
        nil
        ;; neighbors
        nil
        ;; contents
        (list
          (list
            (bind
              (kern-mk-obj t_dungeon 1)
              (list
                'p_slimy_cavern
                8
                30
              )
            ) ;; bind
          20 1)
          (list
            (kern-tag 'black-gate
              (bind
                (kern-mk-obj t_moongate 1)
                (list
                  '()
                  #f
                  '()
                  #f
                  #f
                )
              ) ;; bind
            ) ;; kern-tag
          11 11)
          (list
            (kern-mk-container
              t_chest
              ;; trap
              nil
              ;; contents
              (list
                (list 10 t_food)
                (list 100 t_gold_coins)
                (list 23 sulphorous_ash)
                (list 35 ginseng)
                (list 32 garlic)
                (list 20 spider_silk)
                (list 16 blood_moss)
                (list 12 black_pearl)
                (list 3 nightshade)
                (list 2 mandrake)
                (list 5 t_heal_potion)
                (list 3 t_cure_potion)
                (list 1 t_xen_corp_scroll)
                (list 1 t_in_mani_corp_scroll)
                (list 5 t_torch)
                (list 3 t_picklock)
                (list 1 t_shield)
                (list 1 t_sword)
                (list 1 t_sling)
                (list 5 t_oil)
                (list 1 t_manual)
              )
            )
          1 24)
        ) ;; end of objects
        (list
        )
        (list ;; edge entrances
          (list 0 22 27) ;; Northwest
          (list 1 16 27) ;; North
          (list 2 0 27) ;; Northeast
          (list 3 22 10) ;; West
          (list 4 11 14) ;; Here
          (list 5 0 11) ;; East
          (list 6 22 0) ;; Southwest
          (list 7 11 0) ;; South
          (list 8 0 0) ;; SoutheastUp
        )
      ) ;; end of place p_moongate_clearing

    51 46) ;; coords of p_moongate_clearing
    (list
      (kern-mk-place 'p_gregors_hut "Gregor's Hut"
        s_hamlet ;; sprite
        (kern-mk-map
          nil           32 32 pal_expanded
          (list
            "|| || || || tt tt .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. .. .. .. .. .. tt tt tt tt "
            "|| || || || tt .. .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. .. .. tt tt tt tt tt tt tt "
            "|| || tt tt tt tt .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. .. .. tt || || || tt tt tt "
            "|| tt tt tt tt tt .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. .. tt tt || || || tt tt tt "
            "tt tt tt tt tt tt .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. tt tt || || tt || || tt .. "
            "tt .. .. .. tt tt .. .. .. .. .. .. .. .. .. .. /7 .. .. .. .. .. tt tt tt || tt tt tt || tt .. "
            ".. .. .. .. tt tt tt tt .. .. .. .. .. .. .. .. /7 .. .. .. .. .. .. tt tt || || tt || || tt .. "
            ".. .. .. .. /0 /d /d /d /d /d /d /d /d /d /d /d /9 /d /d /d /d /d /d /2 tt tt || || || tt tt .. "
            ".. .. .. /0 /a tt tt tt .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. /8 /d /d /2 tt tt tt .. .. "
            ".. .. .. /7 tt tt tt tt tt rr rr ws rr rr rr ws rr rr rr rr rr bb bb bb bb bb /8 /d /2 tt .. .. "
            ".. .. .. /7 tt tt tt tt tt rr cc cc cc cc cc cc cc rr cc cc rr .. .. .. .. .. bb .. /7 .. .. .. "
            ".. .. .. /7 .. tt tt tt tt rr cc cc cc cc cc cc cc rr cc cc rr tt .. .. .. .. bb .. /7 .. .. .. "
            ".. .. .. /7 .. .. tt || || rr cc cc [[ @@ ]] cc cc rr cc cc rr tt tt .. .. .. bb .. /7 .. .. .. "
            ".. .. .. /7 .. .. tt || || rr cc cc cc cc cc cc cc rr cc cc rr tt tt tt .. .. bb .. /7 .. .. .. "
            ".. .. .. /7 .. .. rr rr rr rr cc cc cc cc cc cc cc cc cc cc rr tt tt || tt .. bb .. /7 .. .. .. "
            ".. .. .. /7 .. .. ws cc cc rr rr cc rr && rr rr rr rr rr rr rr tt tt tt .. .. bb .. /7 .. .. .. "
            "/d /d /d /6 .. .. rr cc cc cc cc cc cc cc cc cc cc rr .. .. rr .. .. .. .. .. bb .. /4 /d /d /d "
            ".. .. .. /7 .. .. rr rr rr rr cc cc cc cc cc cc cc rr .. .. rr .. .. .. .. .. bb .. /7 tt tt tt "
            ".. .. .. /7 .. .. rr cc cc rr cc cc cc cc cc cc cc rr .. .. .. .. .. .. .. .. bb tt /7 tt tt tt "
            ".. .. .. /7 .. .. ws cc cc cc cc cc cc cc cc cc cc rr .. .. .. .. .. .. .. .. bb tt /7 tt tt %% "
            ".. .. .. /7 .. .. rr rr rr rr rr ws rr cc rr ws rr rr .. rr rr bb bb bb bb bb /0 /d /a tt %% %% "
            ".. .. .. /7 .. .. .. .. .. .. .. tt tt /7 .. tt tt tt /4 /d /d /d /d /d /d /d /a tt tt %% %% %% "
            ".. .. .. /7 .. .. .. .. .. .. .. .. .. /7 .. .. .. .. /7 .. .. .. .. .. .. tt tt tt %% %% ~~ ~~ "
            ".. .. .. /8 /d /d /d /d /d /d /d /d /d /9 /d /1 /d /d /a .. .. .. .. .. tt tt tt %% ~~ ~~ ~~ %% "
            ".. .. .. .. .. .. .. tt tt tt .. .. .. .. .. /7 .. .. tt .. .. .. tt tt tt tt tt %% ~~ %% %% %% "
            "tt tt .. .. .. .. .. tt tt tt .. .. .. .. .. /7 .. .. tt tt tt .. .. .. tt ~~ ~~ ~~ ~~ %% %% %% "
            "|| tt tt .. .. .. .. tt tt tt tt .. .. .. .. /7 .. .. tt tt tt tt tt .. .. ~~ .. tt %% %% tt .. "
            "|| || tt tt .. .. .. .. tt tt tt .. .. .. .. /7 .. .. .. tt tt tt tt ~~ ~~ -- .. .. .. tt tt .. "
            "|| || tt tt tt .. .. .. .. .. .. .. .. .. .. /8 /2 .. .. tt tt tt ~~ ~~ ~~ ~~ tt tt .. tt || .. "
            "|| || || tt tt tt .. .. .. .. .. .. .. .. .. .. /7 .. .. tt tt tt ~~ tt tt tt tt tt .. .. .. .. "
            "|| || || || || tt tt .. .. .. .. .. .. .. .. .. /7 .. .. tt tt ~~ ~~ tt .. .. tt tt || .. .. .. "
            "|| || || || || || tt tt .. .. .. .. .. .. .. .. /7 .. .. tt tt ~~ tt tt .. tt tt || || .. .. .. "
          )
        )
        #f #f #f #f
        ;; subplaces
        nil
        ;; neighbors
        nil
        ;; contents
        (list
          (list
            (bind
              (kern-mk-char
                'ch_ilya
                "Ilya"
                sp_human
                nil
                s_child
                2
                0 70 65
                0 0
                0 0
                30 0
                9 9
                #f ;; dead?
                'ilya-conv
                sch_ilya
                nil
                nil ;; inventory
                nil
                ;; hooks
                (list
                )
              )
              (list
                #f
                #f
              )
            ) ;; bind
          21 10)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          17 14)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          13 20)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          18 20)
          (list
            (bind
              (kern-mk-char
                'ch_gregor
                "Gregor"
                sp_human
                nil
                s_townsman
                2
                0 70 65
                0 0
                0 0
                30 0
                9 9
                #f ;; dead?
                'gregor-conv
                sch_gregor
                nil
                nil ;; inventory
                nil
                ;; hooks
                (list
                )
              )
              '()
            ) ;; bind
          10 10)
          (list
            (bind
              (kern-mk-obj tf_ew_bridge 1)
              '()
            ) ;; bind
          25 26)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          9 16)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          11 15)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          9 19)
        ) ;; end of objects
        (list
        )
        (list ;; edge entrances
          (list 0 31 31) ;; Northwest
          (list 1 16 31) ;; North
          (list 2 0 31) ;; Northeast
          (list 3 31 16) ;; West
          (list 4 16 16) ;; Here
          (list 5 0 16) ;; East
          (list 6 31 0) ;; Southwest
          (list 7 16 0) ;; South
          (list 8 0 0) ;; SoutheastUp
        )
      ) ;; end of place p_gregors_hut

    40 30) ;; coords of p_gregors_hut
    (list
      p_abandoned_farm
    62 50) ;; coords of p_abandoned_farm
    (list
      (kern-mk-place 'p_trigrave "Trigrave"
        s_town ;; sprite
        (kern-mk-map
          nil           32 32 pal_expanded
          (list
            "tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt bb .. .. .. bb tt tt tt tt tt tt tt tt tt tt tt "
            "tt xx xx xx xx xx xx xx xx xx xx xx xx xx tt tt tt .. .. .. tt tt tt tt xx xx xx xx xx xx xx tt "
            "tt xx cc cc x! .G .R .A .Y @@ x! cc cc xx tt tt bb .. .. .. bb tt tt tt xx .I .R .O .N @@ xx tt "
            "tt xx cc cc x! @@ .D .O .V .E x! cc cc xx tt tt tt .. .. .. tt tt tt tt xx .W .O .R .K .S xx tt "
            "tt cc cc cc cc cc cc cc cc cc cc cc cc xx tt tt bb .. .. .. bb tt tt tt ws cc cc cc cc cc xx tt "
            "tt xx xx xx x! @@ .I .N .N @@ x! xx xx xx tt tt tt .. .. .. .. .. bb tt xx cc cc cc cc cc xx tt "
            "tt xx cc cc xx cc cc cc cc cc xx cc cc xx tt tt bb .. .. .. .. .. .. .. cc cc cc cc cc __ xx tt "
            "tt xx cc cc cc cc cc cc cc cc cc cc cc xx tt tt tt .. .. .. .. .. bb tt xx cc cc cc cc !! xx tt "
            "tt xx xx xx x! cc cc cc cc cc x! xx xx xx tt tt bb .. .. .. bb tt tt tt ws cc cc cc cc cc xx tt "
            "tt xx cc cc cc cc cc cc cc cc cc cc cc xx tt tt tt .. .. .. tt tt tt tt xx xx cc xx cc xx xx tt "
            "tt xx cc cc xx cc cc cc cc cc xx cc cc xx tt tt bb .. .. .. bb tt tt tt xx cc cc x! cc cc xx tt "
            "tt xx xx xx xx ws x! cc x! ws xx xx xx xx tt tt tt .. .. .. tt tt tt tt xx cc cc xx cc cc xx tt "
            "tt tt tt tt tt tt bb .. bb tt tt tt tt tt tt tt bb .. .. .. bb tt tt tt xx xx xx xx xx xx xx tt "
            "tt tt tt tt tt tt .. .. .. tt tt tt tt tt tt tt .. .. .. .. .. tt tt tt tt tt tt tt tt tt tt tt "
            "bb tt bb tt bb .. .. .. .. .. bb tt bb tt bb .. .. .. .. .. .. .. bb tt bb tt bb tt bb tt bb tt "
            ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
            ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
            ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
            "bb tt bb tt bb tt bb tt bb .. .. .. .. .. .. .. bb tt bb tt bb tt bb tt bb tt bb tt bb tt bb tt "
            "tt tt tt tt tt tt tt tt tt tt .. .. .. .. .. tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt "
            "tt tt tt tt tt tt tt tt tt tt bb .. .. .. bb tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt "
            "tt xx xx xx xx xx xx xx tt tt tt .. .. .. tt tt tt xx xx xx xx xx xx xx xx xx xx xx xx xx xx tt "
            "tt xx @@ .D .R .Y @@ xx tt tt bb .. .. .. bb tt tt xx x! @@ .L .U .S .T .Y x! xx cc cc cc xx tt "
            "tt xx .G .O .O .D .S xx tt tt tt .. .. .. .. tt tt ws cc cc 00 cc cc 00 cc cc xx cc cc cc xx tt "
            "tt cc cc cc cc cc cc ws tt tt bb .. .. .. .. .. bb xx cc cc 00 cc cc 00 cc cc x! xx cc xx xx tt "
            "tt xx @@ @@ @@ @@ @@ xx tt tt tt .. .. .. .. .. .. cc cc cc cc cc cc cc cc cc cc cc cc cc xx tt "
            "tt xx cc cc cc cc cc xx bb .. .. .. .. .. .. .. .. cc cc cc cc cc cc cc cc cc cc cc cc && xx tt "
            "tt xx cc cc cc cc cc cc .. .. .. .. .. .. .. .. bb xx cc cc 00 cc cc 00 cc cc x! cc cc && xx tt "
            "tt xx cc cc cc cc cc xx bb .. .. .. .. .. .. tt tt ws cc cc 00 cc cc 00 cc cc xx cc cc cc xx tt "
            "tt xx cc cc cc cc cc ws tt tt tt .. .. .. bb tt tt xx x! @@ .J .U .G .S @@ x! xx cc cc cc xx tt "
            "tt xx xx xx xx xx xx xx tt tt bb .. .. .. tt tt tt xx xx xx xx xx xx xx xx xx xx xx ws xx xx tt "
            "tt tt tt tt tt tt tt tt tt tt tt .. .. .. bb tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt tt "
          )
        )
        #f #f #f #f
        ;; subplaces
        nil
        ;; neighbors
        nil
        ;; contents
        (list
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          7 27)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #t
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          26 9)
          (list
            (bind
              (kern-mk-obj t_lever 1)
              (list
                #f
                'tiw-portcullis
                #f
                '()
              )
            ) ;; bind
          25 10)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #t
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          1 4)
          (list
            (kern-mk-container
              t_chest
              ;; trap
              nil
              ;; contents
              (list
                (list 1 t_scratched_shield)
                (list 1 t_armor_plate)
                (list 1 t_iron_helm)
              )
            )
          25 11)
          (list
            (kern-tag 'tiw-portcullis
              (bind
                (kern-mk-obj t_portcullis 1)
                (list
                  #f
                  '()
                  #f
                  '()
                )
              ) ;; bind
            ) ;; kern-tag
          28 9)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          4 4)
          (list
            (kern-mk-obj t_bed 1)
          2 6)
          (list
            (bind
              (kern-mk-char
                'ch_gwen
                "Gwen"
                sp_human
                nil
                s_gwen
                2
                0 70 65
                0 0
                0 0
                30 0
                9 9
                #f ;; dead?
                'gwen-conv
                sch_gwen
                nil
                nil ;; inventory
                nil
                ;; hooks
                (list
                )
              )
              '()
            ) ;; bind
          5 4)
          (list
            (bind
              (kern-mk-char
                'ch_chant
                "Chanticleer"
                sp_human
                nil
                s_chanticleer
                2
                0 70 65
                0 0
                0 0
                30 0
                9 9
                #f ;; dead?
                'chant-conv
                sch_chant
                nil
                nil ;; inventory
                nil
                ;; hooks
                (list
                )
              )
              (list
                0
              )
            ) ;; bind
          18 23)
          (list
            (kern-tag 'trigrave-inn-room-1-door
              (bind
                (kern-mk-obj t_door 1)
                (list
                  #f
                  0
                  '()
                  #f
                  #t
                  #f
                  (list
                    (list
                      's_closed_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_open_door_in_stone
                      #f
                      0
                    )
                    (list
                      's_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_magically_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                  )
                )
              ) ;; bind
            ) ;; kern-tag
          4 7)
          (list
            (kern-mk-obj t_bed 1)
          2 9)
          (list
            (kern-tag 'tlj-d-1
              (bind
                (kern-mk-obj t_door 1)
                (list
                  #f
                  0
                  'tlj-d-2
                  #f
                  #f
                  #f
                  (list
                    (list
                      's_closed_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_open_door_in_stone
                      #f
                      0
                    )
                    (list
                      's_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_magically_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                  )
                )
              ) ;; bind
            ) ;; kern-tag
          17 25)
          (list
            (kern-tag 'tlj-d-2
              (bind
                (kern-mk-obj t_door 1)
                (list
                  #f
                  0
                  'tlj-d-1
                  #f
                  #f
                  #f
                  (list
                    (list
                      's_closed_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_open_door_in_stone
                      #f
                      0
                    )
                    (list
                      's_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_magically_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                  )
                )
              ) ;; bind
            ) ;; kern-tag
          17 26)
          (list
            (kern-tag 'trigrave-inn-room-2-door
              (bind
                (kern-mk-obj t_door 1)
                (list
                  #f
                  0
                  '()
                  #f
                  #t
                  #f
                  (list
                    (list
                      's_closed_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_open_door_in_stone
                      #f
                      0
                    )
                    (list
                      's_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_magically_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                  )
                )
              ) ;; bind
            ) ;; kern-tag
          4 9)
          (list
            (kern-mk-obj t_bed 1)
          12 2)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          10 4)
          (list
            (kern-tag 'trigrave-inn-room-4-door
              (bind
                (kern-mk-obj t_door 1)
                (list
                  #f
                  0
                  '()
                  #f
                  #t
                  #f
                  (list
                    (list
                      's_closed_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_open_door_in_stone
                      #f
                      0
                    )
                    (list
                      's_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_magically_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                  )
                )
              ) ;; bind
            ) ;; kern-tag
          10 7)
          (list
            (kern-mk-obj t_bed 1)
          12 6)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          7 11)
          (list
            (kern-tag 'trigrave-inn-room-3-door
              (bind
                (kern-mk-obj t_door 1)
                (list
                  #f
                  0
                  '()
                  #f
                  #t
                  #f
                  (list
                    (list
                      's_closed_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_open_door_in_stone
                      #f
                      0
                    )
                    (list
                      's_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                    (list
                      's_magically_locked_solid_wood_door_in_stone
                      #t
                      5
                    )
                  )
                )
              ) ;; bind
            ) ;; kern-tag
          10 9)
          (list
            (kern-mk-obj t_bed 1)
          12 9)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          28 24)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #t
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          1 24)
          (list
            (bind
              (kern-mk-char
                'ch_earl
                "Earl"
                sp_human
                nil
                s_townsman
                2
                0 70 65
                0 0
                0 0
                30 0
                9 9
                #f ;; dead?
                'earl-conv
                sch_earl
                nil
                nil ;; inventory
                nil
                ;; hooks
                (list
                )
              )
              '()
            ) ;; bind
          2 24)
          (list
            (bind
              (kern-mk-char
                'ch_jim
                "Jim"
                sp_human
                nil
                s_townsman
                2
                0 70 65
                0 0
                0 0
                30 0
                9 9
                #f ;; dead?
                'jim-conv
                sch_jim
                nil
                nil ;; inventory
                nil
                ;; hooks
                (list
                )
              )
              '()
            ) ;; bind
          25 4)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          24 6)
        ) ;; end of objects
        (list
          'trigrave-entry
        )
        (list ;; edge entrances
          (list 0 31 31) ;; Northwest
          (list 1 12 31) ;; North
          (list 2 0 31) ;; Northeast
          (list 3 31 16) ;; West
          (list 4 16 16) ;; Here
          (list 5 0 16) ;; East
          (list 6 31 0) ;; Southwest
          (list 7 18 0) ;; South
          (list 8 0 0) ;; SoutheastUp
        )
      ) ;; end of place p_trigrave

    29 51) ;; coords of p_trigrave
    (list
      (kern-mk-place 'p_enchanters_tower "Enchanters Tower"
        s_keep ;; sprite
        (kern-mk-map
          nil           65 65 pal_expanded
          (list
            "__ __ -- ~~ %% %% %% %% %% %% %% %% ~~ ~~ ~~ %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. .. bb %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% "
            "__ __ -- ~~ %% %% %% %% %% %% %% ~~ ~~ -- ~~ ~~ %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. .. .. .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% "
            "-- -- xx xx ws xx xx %% %% %% %% ~~ -- __ -- ~~ %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. .. bb %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% xx xx ws xx xx %% %% "
            "~~ ~~ xx cc cc cc x! %% %% %% %% ~~ ~~ -- ~~ ~~ %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. .. .. .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% xx cc cc cc xx %% %% "
            "%% %% ws cc bb cc cc ee ee ee .. %% ~~ ~~ ~~ %% .. %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. .. bb %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% ws cc bb cc ws %% %% "
            "%% %% xx cc cc cc x! %% %% .. .. .. ee ee ee .. .. .. %% %% %% %% %% %% %% %% %% %% %% %% .. .. .. .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% xx cc cc cc xx %% %% "
            "%% %% xx xx ws xx xx %% %% %% .. %% %% %% %% %% .. %% %% bb .. bb .. bb .. bb .. bb .. bb .. .. .. .. .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb %% %% xx x! cc x! xx %% %% "
            "%% ~~ ~~ -- __ -- ~~ ~~ %% %% %% ~~ ~~ ~~ %% %% ee %% bb .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. %% %% %% %% ee %% %% %% %% "
            "%% ~~ -- __ __ __ -- ~~ %% %% ~~ ~~ -- ~~ ~~ %% ee .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. bb %% %% %% %% ee %% %% %% %% "
            "%% ~~ ~~ -- -- -- ~~ ~~ %% ~~ ~~ -- __ -- ~~ ~~ %% %% bb .. .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. .. .. .. .. bb .. bb .. bb .. %% %% "
            "%% %% ~~ ~~ ~~ ~~ ~~ %% %% ~~ -- __ __ __ -- ~~ %% %% .. .. .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. .. .. .. .. .. .. .. .. .. bb %% %% "
            "%% %% %% %% %% %% %% %% %% ~~ ~~ -- __ -- ~~ ~~ %% %% bb .. .. bb %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. .. .. .. .. .. .. .. .. %% %% "
            "%% %% %% %% %% %% %% %% %% %% ~~ ~~ -- ~~ ~~ %% %% %% .. .. .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. bb .. bb .. bb .. .. .. bb %% %% "
            "%% %% %% %% %% %% %% %% %% %% %% ~~ ~~ ~~ %% %% %% %% bb .. .. bb %% %% %% %% %% %% %% %% xx xx xx xx xx %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. .. .. .. %% %% "
            "%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. .. .. .. %% %% %% tt tt %% %% %% xx cc cc cc xx %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. bb %% %% "
            "%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. bb %% %% tt tt tt tt xx xx xx cc cc cc xx xx xx %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. .. .. .. %% %% "
            "%% bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. .. .. .. %% tt tt || || xx xx xx xx x! cc x! xx xx xx xx %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. bb %% %% "
            "%% .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. bb %% tt tt || ?? ?? x! 00 00 cc cc cc 00 xx xx xx xx xx %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. .. .. .. %% %% "
            "%% bb .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. %% %% tt xx xx ?? xx 00 cc cc cc cc cc xx xx xx xx xx xx %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. bb %% %% "
            "%% .. .. .. .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb %% bb %% %% tt xx cc cc x! 00 cc cc 00 cc cc && ?? cc cc xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx %% %% .. .. .. .. %% %% "
            "%% bb .. .. .. %% %% %% %% %% %% %% %% %% %% %% .. %% %% %% %% %% %% %% xx xx cc cc xx 00 cc cc 00 cc cc && xx cc cc xx xx || || || || tt ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, xx %% %% bb .. .. bb %% %% "
            "%% .. .. .. bb %% %% %% %% %% %% %% %% %% %% bb .. bb %% %% %% %% %% %% xx cc cc cc xx 00 cc cc cc cc cc xx xx cc cc cc xx || tt tt tt tt ,, tt tt ,, tt tt ,, tt tt ,, xx %% %% .. .. .. .. %% %% "
            "%% bb .. .. .. %% %% %% %% %% %% %% %% %% %% .. .. %% tt tt tt %% %% %% xx cc cc x! xx xx x! cc cc cc x! xx xx x! cc cc xx || tt .. .. .. ,, tt tt ,, tt tt ,, tt tt ,, xx %% %% bb .. .. bb %% %% "
            "%% .. .. .. bb %% %% %% %% %% %% %% %% %% bb .. bb tt tt || tt tt %% %% xx cc cc xx cc cc cc cc cc cc cc cc cc xx cc cc xx || tt .. .. .. ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, xx %% %% .. .. .. .. %% %% "
            "%% bb .. .. .. %% %% %% %% %% %% %% %% %% %% .. .. tt || || || tt %% %% xx xx xx xx cc cc cc cc cc cc cc cc cc xx xx xx xx || tt .. .. .. ,, tt tt ,, tt tt ,, tt tt ,, xx %% %% bb .. .. bb %% %% "
            "%% .. .. .. bb %% %% %% %% %% %% %% %% tt bb .. bb tt tt || tt tt tt tt tt xx xx xx cc cc 00 cc cc cc 00 cc cc xx xx xx || || tt .. .. .. ,, tt tt ,, tt tt ,, tt tt ,, xx %% %% .. .. .. .. %% %% "
            "%% bb .. .. .. %% %% %% %% %% tt tt tt tt tt .. .. tt tt tt tt tt tt bb tt xx xx && cc cc 00 cc cc cc 00 cc cc && xx xx || ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, xx %% %% bb .. .. bb %% %% "
            "%% .. .. .. bb %% %% %% %% tt tt || tt tt tt bb .. bb tt tt tt bb tt .. .. .. xx xx cc cc 00 cc cc cc 00 cc cc xx xx || || ,, || || || || ,, tt tt ,, tt tt ,, tt tt ,, xx %% %% .. .. .. .. %% %% "
            "%% bb .. .. .. %% %% %% %% tt || || || tt tt tt .. .. .. bb .. .. .. .. .. .. .. xx cc cc cc cc cc cc cc cc cc xx || || || ,, || || || || ,, tt tt ,, tt tt ,, tt tt ,, xx %% %% bb .. .. bb %% %% "
            "%% .. .. .. bb %% %% %% %% tt tt || tt tt tt bb .. .. .. .. .. .. .. .. .. .. .. xx x! cc cc cc cc cc cc cc x! xx bb ,, ,, ,, ,, ,, bb || ,, ,, ,, ,, ,, ,, ,, ,, ,, ,, xx %% %% .. .. .. .. bb %% "
            "bb .. .. .. .. %% %% %% %% %% tt tt tt || tt tt tt bb .. .. .. .. .. .. .. .. .. xx xx xx xx cc x! cc xx xx xx xx ,, ,, ,, ,, ,, ,, ,, || ,, .. .. .. .. .. .. .. .. .. xx %% %% bb .. .. .. .. bb "
            ".. .. .. .. .. bb %% %% %% %% %% tt || || || tt tt tt .. .. .. .. .. .. .. .. .. .. xx .X xx cc cc cc ws .. .. .. ,, ,, ~~ -- ~~ ,, ,, || ,, tt tt tt tt tt tt tt tt .. xx %% %% .. .. .. .. .. .. "
            ".. .. .. .. .. .. %% %% %% %% %% tt tt || tt tt tt .. .. .. .. .. .. && .. .. .. .. xx xx xx cc cc cc cc ,, ,, ,, ,, ,, -- __ -- ,, ,, ,, ,, || || || || || || || tt tt xx %% %% bb .. .. .. .. .. "
            ".. .. .. .. .. bb %% %% %% %% %% %% xx xx xx xx xx .. .. .. .. .. .. .. .. .. .. .. .. .. xx cc cc cc ws .. .. .. ,, ,, ~~ -- ~~ ,, ,, || || || xx xx xx xx xx || || || xx %% %% .. .. .. .. .. .. "
            "bb .. .. .. .. %% %% %% %% %% xx xx xx cc cc cc xx xx xx .. .. .. .. .. .. .. .. .. xx xx xx cc cc cc xx xx xx tt ,, ,, ,, ,, ,, ,, ,, || xx xx xx cc cc cc xx xx xx || xx %% %% bb .. .. .. .. bb "
            "%% .. .. .. bb %% %% %% %% xx xx cc cc cc cc cc cc cc xx xx .. .. .. .. .. .. .. xx xx cc cc cc cc cc cc cc xx xx bb ,, ,, ,, ,, ,, bb xx xx xx xx xx ?? xx xx xx xx xx xx %% %% %% .. .. .. .. %% "
            "%% bb .. .. .. %% %% %% xx xx cc cc xx xx x! xx xx x! xx xx .. .. .. .. .. .. xx x! cc cc cc cc cc cc cc cc cc x! xx tt .. ,, .. tt xx xx xx cc cc xx && cc cc xx cc xx xx %% %% %% bb .. .. bb %% "
            "%% .. .. .. bb %% %% xx xx cc cc xx x! 00 00 00 00 00 00 x! xx xx .. .. .. xx xx cc cc cc cc cc cc cc cc cc cc cc xx xx .. ,, .. xx xx .X xx cc cc xx xx cc cc xx cc .X xx xx %% %% .. .. .. .. %% "
            "%% bb .. .. .. %% %% xx cc cc cc xx 00 cc cc cc cc cc cc 00 xx xx .. .. .. ws cc cc cc cc cc cc cc cc cc cc cc cc cc xx .. ,, .. xx cc cc xx cc cc && xx cc cc xx cc cc cc xx xx %% bb .. .. bb %% "
            "%% .. .. .. bb %% xx xx xx x! cc x! 00 cc cc cc cc cc cc 00 xx xx xx ws xx x! cc cc cc cc bb cc cc cc bb cc cc cc cc x! ws cc ws x! xx xx x! cc x! xx x! cc x! xx xx xx xx xx xx %% .. .. .. .. %% "
            "%% bb .. .. .. %% xx cc cc cc cc xx cc cc cc 00 00 cc cc cc cc x! cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc xx %% bb .. .. bb %% "
            "%% .. .. .. bb %% xx cc cc cc cc cc cc cc cc 00 00 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc .X cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc bb cc xx %% .. .. .. .. %% "
            "%% bb .. .. .. %% xx cc cc cc cc xx cc cc cc 00 00 cc cc cc cc x! cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc xx %% bb .. .. bb %% "
            "%% .. .. .. bb %% xx xx xx x! cc x! 00 cc cc cc cc cc cc 00 xx xx xx ws xx x! cc cc cc cc bb cc cc cc bb cc cc cc cc x! xx ws xx x! xx xx xx x! cc x! xx x! cc x! xx xx xx xx xx %% .. .. .. .. %% "
            "%% bb .. .. .. %% %% xx cc cc cc xx 00 cc cc cc cc cc cc 00 xx xx %% %% %% ws cc cc cc cc cc cc cc cc cc cc cc cc cc ws %% %% %% xx cc cc xx cc cc xx && cc cc xx cc cc cc xx %% %% bb .. .. bb %% "
            "%% .. .. .. bb %% %% xx xx cc cc xx x! 00 00 00 00 00 00 x! xx xx %% %% %% xx xx cc cc cc cc cc cc cc cc cc cc cc xx xx %% %% %% xx xx .X xx cc cc xx xx cc cc xx cc .X xx xx %% %% .. .. .. .. %% "
            "%% bb .. .. .. %% %% %% xx xx cc cc xx xx x! xx x! xx xx xx %% %% %% %% %% %% xx x! cc cc cc cc cc cc cc cc cc x! xx %% %% %% %% %% xx xx xx cc cc && xx cc cc xx cc xx xx %% %% %% bb .. .. bb %% "
            "%% .. .. .. bb %% %% %% %% xx xx cc cc cc cc cc cc cc xx xx %% %% %% %% %% %% %% xx xx cc cc cc cc cc cc cc xx xx %% %% %% %% %% %% %% xx xx xx xx ?? xx xx xx xx xx xx %% %% %% %% .. .. .. .. %% "
            "%% bb .. .. .. %% %% %% %% %% xx xx xx cc cc cc xx xx xx %% %% %% %% %% %% %% %% %% xx ws xx cc cc cc xx ws xx %% %% %% tt tt tt %% %% %% xx xx xx cc cc cc xx xx xx %% %% %% %% %% bb .. .. bb %% "
            "%% .. .. .. bb %% %% %% %% %% %% %% xx xx xx xx xx %% %% %% %% %% %% %% %% %% %% %% %% %% x! cc xx cc x! .. %% %% %% tt tt ~~ tt tt %% %% %% %% xx xx xx xx xx %% %% %% %% %% %% %% .. .. .. .. %% "
            "%% bb .. .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. cc cc cc .. .. %% %% %% tt ~~ -- ~~ tt %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. bb %% "
            "%% .. .. .. bb %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. cc cc cc .. bb %% %% %% tt tt ~~ tt tt %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. .. .. .. %% "
            "%% bb .. .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. cc cc cc .. .. %% %% %% %% tt tt tt %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. bb %% "
            "%% .. .. .. bb .. bb .. bb .. bb .. bb %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. cc cc cc .. bb %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. .. .. .. %% "
            "%% bb .. .. .. .. .. .. .. .. .. .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. cc cc cc .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. .. bb %% "
            "%% .. .. .. .. .. .. .. .. .. .. .. .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. cc cc cc .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. .. .. .. %% "
            "%% bb .. .. .. .. .. bb .. bb .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. cc cc cc .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. bb %% "
            "%% %% %% bb .. bb %% %% %% %% .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. cc cc cc .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. %% "
            "%% %% xx x! .. x! xx %% %% %% bb .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. cc cc cc .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. bb %% "
            "%% %% xx cc cc cc xx %% %% %% %% bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. cc cc cc .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. bb .. %% %% "
            "%% %% ws cc bb cc ws %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. cc cc cc .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% "
            "%% %% xx cc cc cc xx %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. cc cc cc .. bb %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% "
            "%% %% xx xx ws xx xx %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. cc cc cc .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% "
            "%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% bb .. cc cc cc .. bb %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% "
            "%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% .. cc cc cc .. .. %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% "
          )
        )
        #f #f #f #f
        ;; subplaces
        nil
        ;; neighbors
        nil
        ;; contents
        (list
          (list
            (kern-mk-obj t_bed 1)
          47 36)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          10 39)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          41 39)
          (list
            (kern-mk-obj t_bed 1)
          52 46)
          (list
            (kern-mk-obj t_bed 1)
          52 36)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          34 32)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          47 39)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_windowed_wood_door_in_rock
                    #f
                    5
                  )
                  (list
                    's_open_door_in_rock
                    #f
                    0
                  )
                  (list
                    's_locked_windowed_wood_door_in_rock
                    #f
                    5
                  )
                  (list
                    's_magically_locked_windowed_wood_door_in_rock
                    #f
                    5
                  )
                )
              )
            ) ;; bind
          11 41)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          51 39)
          (list
            (bind
              (kern-mk-char
                'ch_zane
                "Zane"
                sp_human
                oc_ranger
                s_companion_ranger
                2
                1 61 61
                0 0
                0 0
                30 0
                17 3
                #f ;; dead?
                'zane-conv
                sch_zane
                nil
                (kern-mk-container
                  t_chest
                  ;; trap
                  'burn
                  ;; contents
                  (list
                    (list 10 t_food)
                    (list 100 t_arrow)
                    (list 1 t_bow)
                    (list 5 t_torch)
                    (list 5 t_cure_potion)
                    (list 5 t_heal_potion)
                    (list 5 t_leather_helm)
                    (list 5 t_sword)
                    (list 5 t_dagger)
                    (list 5 t_armor_leather)
                  )
                )
                (list
                  t_leather_helm
                  t_sword
                  t_dagger
                  t_armor_leather
                )
                ;; hooks
                (list
                )
              )
              '()
            ) ;; bind
          20 29)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          10 43)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          32 16)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #t
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          21 41)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          48 43)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          31 49)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          33 49)
          (list
            (bind
              (kern-mk-obj t_door 1)
              (list
                #f
                0
                '()
                #f
                #f
                #f
                (list
                  (list
                    's_closed_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_open_door_in_stone
                    #f
                    0
                  )
                  (list
                    's_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                  (list
                    's_magically_locked_solid_wood_door_in_stone
                    #t
                    5
                  )
                )
              )
            ) ;; bind
          52 43)
          (list
            (kern-mk-obj t_bed 1)
          47 46)
        ) ;; end of objects
        (list
        )
        (list ;; edge entrances
          (list 0 64 64) ;; Northwest
          (list 1 32 64) ;; North
          (list 2 0 64) ;; Northeast
          (list 3 64 32) ;; West
          (list 4 32 32) ;; Here
          (list 5 0 32) ;; East
          (list 6 64 0) ;; Southwest
          (list 7 32 0) ;; South
          (list 8 0 0) ;; SoutheastUp
        )
      ) ;; end of place p_enchanters_tower

    29 21) ;; coords of p_enchanters_tower
    (list
      p_green_tower
    80 59) ;; coords of p_green_tower
    (list
      (kern-mk-place 'p_mushroom_cave "Mushroom Cave"
        s_dungeon ;; sprite
        (kern-mk-map
          nil           16 16 pal_expanded
          (list
            "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
            "rr %% %% rr rr tt .. .. .. tt rr rr rr {{ rr rr "
            "rr %% rr rr || .. .. .. .. .. || rr rr tt {{ rr "
            "rr %% rr tt %% bb .. .. .. bb %% || rr .. tt rr "
            "rr %% rr %% %% %% %% .. .. %% %% tt rr .. tt rr "
            "rr rr rr tt %% bb %% .. .. bb %% %% rr .. {{ rr "
            "rr .. || || %% %% .. .. .. %% %% %% rr {{ {{ rr "
            "rr .. rr || %% bb .. %% %% bb %% %% rr {{ {{ rr "
            "rr tt rr tt %% .. .. .. %% %% tt tt rr .. {{ rr "
            "rr tt rr %% %% bb .. .. .. bb || || rr .. {{ rr "
            "rr tt rr rr tt %% .. .. .. tt || rr rr .. tt rr "
            "rr .. tt rr rr rr .. .. .. rr rr rr .. .. tt rr "
            "rr .. .. .. && rr rr .. rr rr .. .. .. tt || rr "
            "rr .. .. .. .. .. rr .. rr {{ .. .. tt || rr rr "
            "rr rr tt .. .. .. .. .. rr rr tt tt || rr rr rr "
            "rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr rr "
          )
        )
        #f #t #f #f
        ;; subplaces
        nil
        ;; neighbors
        nil
        ;; contents
        (list
          (list
            (bind
              (kern-mk-obj t_ladder_up 1)
              (list
                'p_shard
                78
                74
              )
            ) ;; bind
          7 12)
          (list
            (kern-mk-char
              nil
              " a yellow slime"
              sp_yellow_slime
              nil
              s_yellow_slime
              5
              0 12 12
              0 0
              0 0
              16 0
              37 1
              #f ;; dead?
              nil
              nil
              'yellow-slime-ai
              nil ;; inventory
              nil
              ;; hooks
              (list
                (list
                  ef_poison_immunity
                  '()
                  2
                  0
                )
              )
            )
          6 7)
          (list
            (kern-mk-obj t_yellow_slime_generator 1)
          7 7)
        ) ;; end of objects
        (list
        )
        (list ;; edge entrances
          (list 0 15 15) ;; Northwest
          (list 1 7 12) ;; North
          (list 2 0 15) ;; Northeast
          (list 3 7 12) ;; West
          (list 4 8 8) ;; Here
          (list 5 7 12) ;; East
          (list 6 15 0) ;; Southwest
          (list 7 7 12) ;; South
          (list 8 0 0) ;; SoutheastUp
        )
      ) ;; end of place p_mushroom_cave

    78 74) ;; coords of p_mushroom_cave
  ) ; end of subplaces
  ;; neighbors
  nil
  ;; contents
  (list
    (list
      (kern-mk-obj t_skeleton_generator 1)
    0 0)
    (list
      (kern-mk-party t_skeleton_brigade 5
        nil
      )
    0 0)
    (list
      (kern-mk-party t_skeleton_brigade 5
        nil
      )
    0 0)
    (list
      (bind
        (kern-mk-obj t_dungeon 1)
        (list
          'p_lost_halls
          1
          4
        )
      ) ;; bind
    46 12)
    (list
      (bind
        (kern-mk-obj t_queen_spider_generator 1)
        (list
          43
          34
          5
          6
          "A nest of spiders!"
        )
      ) ;; bind
    46 37)
    (list
      (bind
        (kern-mk-obj tf_ew_bridge 1)
        '()
      ) ;; bind
    23 51)
    (list
      (kern-mk-party t_bandit_gang 5
        nil
      )
    29 28)
    (list
      (bind
        (kern-mk-obj tf_ew_bridge 1)
        '()
      ) ;; bind
    33 52)
    (list
      (kern-mk-obj t_orc_generator 1)
    1 22)
    (list
      (kern-mk-party t_goblin_horde 5
        nil
      )
    1 22)
    (list
      (kern-mk-obj t_bandit_generator 1)
    30 38)
  ) ;; end of objects
  (list
  )
  (list ;; edge entrances
    (list 0 127 95) ;; Northwest
    (list 1 64 95) ;; North
    (list 2 0 95) ;; Northeast
    (list 3 127 48) ;; West
    (list 4 64 48) ;; Here
    (list 5 0 48) ;; East
    (list 6 127 0) ;; Southwest
    (list 7 64 0) ;; South
    (list 8 0 0) ;; SoutheastUp
  )
) ;; end of place p_shard

(kern-mk-player
  'player
  s_companion_fighter
  "Walk"
  sound-walking
  9 0
  23821 ;; turns to next meal
  nil
  m_campsite
  nil
  nil ; player's vehicle
  (kern-mk-container
    nil
    ;; trap
    nil
    ;; contents
    nil
  )
  (list
    ch_wanderer
  )
)
;;--------------
;; Miscellaneous
;;--------------
(kern-set-frame s_frame_ulc s_frame_urc s_frame_llc s_frame_lrc s_frame_td s_frame_tu s_frame_tl s_frame_tr s_null s_frame_horz s_frame_vert s_frame_endl s_frame_endr)
(kern-set-cursor ls_whirlpool)
(kern-set-crosshair t_crosshair)
(kern-set-ascii ss_u4_charset 32)
(kern-set-clock 0 0 0 0 14 20)
(kern-set-time-accel 1)
(kern-mk-dtable
  (list    0    0   -1   -1   -1   -2   -2   -2    0 )
  (list    0    2    1    0   -1   -2   -2   -2   -2 )
  (list   -1    1    2   -1   -1   -2   -2   -2   -2 )
  (list   -1    0   -1    2   -1   -2    0   -2   -2 )
  (list   -1   -1   -1   -1    2   -2   -1   -1   -2 )
  (list   -2   -2   -2   -2   -2    0   -1    0   -2 )
  (list   -2   -2   -2    0   -1   -1    2   -2   -2 )
  (list   -2   -2   -2   -2   -1    0   -2    2   -2 )
  (list    0   -2   -2   -2   -2   -2   -2   -2    0 )
)
;; ---------
;; Astronomy
;; ---------
(kern-mk-astral-body
  'sun	; tag
  "Fyer (the sun)"	; name
  1	; distance
  1	; minutes_per_phase
  4	; minutes_per_degress
  0	; initial_arc
  0	; initial_phase
  nil	; gifc
  (list
    (list s_sun 255 "full")
  )
)
(kern-add-reveal 0)
(kern-add-quicken 0)
(kern-add-time-stop 0)
(kern-add-magic-negated 0)
(kern-add-xray-vision 0)