;;----------------------------------------------------------------------------
;; Generic conversation
;;----------------------------------------------------------------------------

;; fundamentals
(define (generic-hail knpc kpc)
  (say knpc "Well met"))

(define (generic-unknown knpc kpc)
  (say knpc "I can't help you with that"))

(define (generic-bye knpc kpc)
  (say knpc "Farewell")
  (kern-conv-end))

(define (generic-join knpc kpc)
  (kern-conv-say knpc "I cannot join you."))

;; wise
(define (basic-ench knpc kpc)
  (say knpc "The Enchanter is the Wise Wizard. "
       "He lives in a tower by the Fens, do you need directions?")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "Take the ladder down. You'll come out in Eastpass. "
                    "Lord Froederick's men can help you from there."))
              ((equal? kplace p_eastpass)
               (say knpc "Take the road west to Trigrave and ask around there."))
              ((equal? kplace p_trigrave)
               (say knpc "Take the road north to The Fen."))
              (else 
               (say knpc "I'm not sure how to get there from here."))
        ))))

;; towns
(define (basic-trig knpc kpc)
  (say knpc "Trigrave is a small town in the west, "
       "settled where two rivers meet."))

(define (basic-gree knpc kpc)
  (say knpc "Green Tower, home of the Rangers, lies deep in the Great Forest. "
       "Do you need directions?")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "Take the road east into the forest. "
                    "Eventually it turns into a trail, follow it as best you can."))
              ((equal? kplace p_eastpass)
               (say knpc "Take the ladder down to Westpass and ask the Rangers there."))
              ((equal? kplace p_trigrave)
               (say knpc "Take the road east to the mountains and go through Eastpass. "
                    "After that, you'll have to ask around."))
              ((equal? kplace p_enchanters_tower)
               (say knpc "Go south to Trigrave and ask there."))
              (else 
               (say knpc "I'm not sure how to get there from here."))
              ))))

(define (basic-bole knpc kpc)
  (say knpc "The hamlet of Bole sits in a canyon in the mountains north of "
       "the Great Wood. Do you need directions?")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "It's northeast of here. Follow the mountains."))
              ((equal? kplace p_eastpass)
               (say knpc "Take the ladder down to Westpass and ask the Rangers there."))
              ((equal? kplace p_trigrave)
               (say knpc "Take the road east to the mountains and go through Eastpass. "
                    "After that, you'll have to ask around."))
              ((equal? kplace p_green_tower)
               (say knpc "Go north through the forest until you hit the mountains, "
                    "then follow them east a short while."))
              ((equal? kplace p_enchanters_tower)
               (say knpc "Go south to Trigrave and ask there."))
              (else 
               (say knpc "I'm not sure how to get there from here."))
              ))))
              
(define (basic-absa knpc kpc)
  (say knpc "Absalot, a great and wicked city, was destroyed for its sins."))

(define (basic-opar knpc kpc)
  (say knpc "The city of Oparine can be found in the southwest by a "
       "deep harbor. Do you need directions?")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "Take the ladder down to Eastpass and follow the road west."))
              ((equal? kplace p_eastpass)
               (say knpc "Follow the road west."))
              ((equal? kplace p_trigrave)
               (say knpc "Follow the road west and south all the way to the sea."))
              ((equal? kplace p_green_tower)
               (say knpc "Follow the trail south and west to Westpass and ask the rangers when you get there."))
              ((equal? kplace p_enchanters_tower)
               (say knpc "Go south to Trigrave and ask there."))
              ((equal? kplace p_glasdrin)
               (say knpc "Go west and south to Trigrave and ask there."))
              (else 
               (say knpc "I'm not sure how to get there from here."))
              ))))

(define (basic-glas knpc kpc)
  (say knpc "Glasdrin is the fortified city of the Paladins. Do you need directions?")
  (if (yes? kpc)
      (let ((kplace (get-place knpc)))
        (cond ((equal? kplace p_westpass)
               (say knpc "The best way is to take the ladder down to Eastpass and go to Trigrave first."))
              ((equal? kplace p_eastpass)
               (say knpc "Go west to Trigrave then up to Northpass."))
              ((equal? kplace p_trigrave)
               (say knpc "Go up to Northpass and ask there."))
              ((equal? kplace p_green_tower)
               (say knpc "Follow the trail south and west to Westpass and ask the rangers there."))
              ((equal? kplace p_enchanters_tower)
               (say knpc "Head east of the Fens, you'll find it by the sea."))
              ((equal? kplace p_oparine)
               (say knpc "Follow the road north to Trigave and ask there."))
              (else 
               (say knpc "I'm not sure how to get there from here."))
              ))))

(define (basic-fens knpc kpc)
  (say knpc "The Fens are a swampy area in the northwest."))

(define (basic-kurp knpc kpc)
  (say knpc "Kurpolis is an ancient underground ruin. "
       "You'll find the entrance somewhere near Glasdrin."))

(define (basic-lost knpc kpc)
  (say knpc "The Lost Halls? I've only heard them mentioned in bard's songs. "
       "I didn't know they really existed."))

;; establishments
(define (basic-whit knpc kpc)
  (say knpc "The White Stag is in Green Tower."))

;; quests
(define (basic-thie knpc kpc)
  (say knpc "No, I don't know anything about a thief."))

(define (basic-rune knpc kpc)
  (say knpc "I don't know much about runes. Try asking one of the Wise."))

(define (basic-wise knpc kpc)
  (say knpc "The Wise have great influence over affairs in the Shard. Do you want to know their names?")
  (if (yes? kpc)
      (say knpc "There's the Enchanter, the Necromancer, the Alchemist, the MAN, the Engineer and the Warritrix.")))

(define (basic-shar knpc kpc)
  (say knpc "The Shard is what we call our world."))

(define (basic-warr knpc kpc)
  (say knpc "The Warritrix is the Wise Warrior. If you're looking for her try Glasdrin."))

(define (basic-engi knpc kpc)
  (say knpc "I've hard the Engineer is the greatest Wright in the land, "
       "but I don't know much about him."))

(define (basic-man knpc kpc)
  (say knpc "The MAN is a master wrogue. Nobody knows where his hideout is. "
       "It's rumoured that he travels in disguise."))

(define (basic-alch knpc kpc)
  (say knpc "The Alchemist is a Wise Wright who specializes in potions. "
       "You'll find his shop in Oparine."))

(define (basic-necr knpc kpc)
  (say knpc "The Necromancer is a Wise Wizard who specializes in death magic. "
       "I've heard he lives in a hidden cave."))

(define (basic-drag knpc kpc)
  (say knpc "Stories say a mighty dragon guards a fantastic hoard "
       "in the Fire Sea."))

(define basic-conv
  (ifc '()
       ;; fundamentals
       (method 'hail generic-hail)
       (method 'default generic-unknown)
       (method 'bye generic-bye)
       (method 'join generic-join)
       
       ;; wise
       (method 'ench basic-ench)
       (method 'wise basic-wise)
       (method 'warr basic-warr)
       (method 'man basic-man)
       (method 'engi basic-engi)
       (method 'alch basic-alch)
       (method 'necr basic-necr)

       ;; towns & regions
       (method 'absa basic-absa)
       (method 'bole basic-bole)
       (method 'gree basic-gree)
       (method 'trig basic-trig)
       (method 'lost basic-lost)
       (method 'opar basic-opar)
       (method 'fens basic-fens)
       (method 'shar basic-shar)
       (method 'kurp basic-kurp)
       (method 'glas basic-glas)

       ;; establishments
       (method 'whit basic-whit)

       ;; quests
       (method 'thie basic-thie)
       (method 'rune basic-rune)

       ;; monsters
       (method 'drag basic-drag)
       

       ))

;; Helper(s)
(define (say knpc . msg) (kern-conv-say knpc msg))
(define (yes? kpc) (kern-conv-get-yes-no? kpc))
(define (no? kpc) (not (kern-conv-get-yes-no? kpc)))
(define (prompt-for-key)
  (kern-log-msg "<Hit any key to continue>")
  (kern-ui-waitkey))
(define (meet msg)
  (kern-log-msg msg))
(define (get-gold-donation knpc kpc)
  (let ((give (kern-conv-get-amount kpc))
        (have (kern-player-get-gold)))
    (cond ((> give have)
           (say knpc "You don't have that much!")
           0)
          (else
           (kern-player-set-gold (- have give))
           give))))
(define (get-food-donation knpc kpc)
  (let ((give (kern-conv-get-amount kpc))
        (have (kern-player-get-food)))
    (cond ((> give have)
           (say knpc "You don't have that much!")
           0)
          (else
           (kern-player-set-food (- have give))
           give))))
(define (working? knpc)
  (string=? "working" (kern-obj-get-activity knpc)))

;;----------------------------------------------------------------------------
;; Quests
;;----------------------------------------------------------------------------
(define (mk-quest) (list #f #f #f))
(define (quest-offered? qst) (car qst))
(define (quest-accepted? qst) (cadr qst))
(define (quest-done? qst) (caddr qst))
(define (quest-offered! qst val) (set-car! qst val))
(define (quest-accepted! qst val) (set-car! (cdr qst) val))
(define (quest-done! qst val) (set-car! (cddr qst) val))


;;----------------------------------------------------------------------------
;; Ranger Conversation
;;----------------------------------------------------------------------------
(define (ranger-ranger knpc kpc)
  (say knpc "Rangers guard the borders between wilderness and "
       "civilization. We patrol the frontier and give aid where we can to the "
       "Wise."))

(define (ranger-wise knpc kpc)
  (say knpc "Rangers have an informal alliance with the Wise. They give us "
       "aid and hospitality. In return we give them news. Sometimes we serve "
       "them as messengers and scouts."))


(define ranger-conv
  (ifc basic-conv
       (method 'rang ranger-ranger)
       (method 'wise ranger-wise)
       ))


;; Knight conversation -- used by Lord Froederick's troops
(define knight-conv basic-conv)

;; Glasdrin
(define (glasdrin-warr knpc kpc)
  (say knpc "The Warritrix is the most cunning warrior of the age. I'm not sure where she is right now, ask the Steward or Commander Jeffries."))
(define (glasdrin-stew knpc kpc)
  (say knpc "The Steward is the keeper of the city and realms of Glasdrin. You can usually find her in the Citadel."))
(define (glasdrin-jeff knpc kpc)
  (say knpc "Jeffries is the commander of the Glasdrin militia. He's usually at work in the Citadel."))
(define (glasdrin-kurp knpc kpc)
         (say knpc "Take the bridge north across the river then follow the "
              "mountains east and north into a canyon."))
(define (glasdrin-cita knpc kpc)
  (say knpc "The Citadel is the civil and military headquarters of Glasdrin. It's the big keep in the southeast corner of town."))
(define (glasdrin-ghol knpc kpc)
  (say knpc "I seem to recall a man named Gholet was arrested for theft. You might check the Citadel's dungeon."))

(define glasdrin-conv
  (ifc basic-conv
       (method 'warr glasdrin-warr)
       (method 'stew glasdrin-stew)
       (method 'jeff glasdrin-jeff)
       (method 'kurp glasdrin-kurp)
       (method 'cita glasdrin-cita)
       (method 'ghol glasdrin-ghol)
       ))

;; Kurpolis
(define (kurp-drag knpc kpc)
  (say knpc "If you're hunting for dragons try the Fire Sea region."))
(define (kurp-fire knpc kpc)
  (say knpc "The Fire Sea is down near the Third Garrison."))
(define (kurp-lich knpc kpc)
  (say knpc "The commander of the Second Garrison believes a Lich is causing problems on the second level."))
(define (kurp-hydr knpc kpc)
  (say knpc "I've heard there is a vast underground lake below us, and a Hydra lurks in a nearby cave."))
(define (kurp-lost knpc kpc)
  (say knpc "I've heard rumours that a patrol found the entrance to the legendary Lost Halls. "
       "Ask Commander Jeffrey's, he's being tight-lipped about it."))
(define kurpolis-conv
  (ifc basic-conv
       (method 'drag kurp-drag)
       (method 'fire kurp-fire)
       (method 'lich kurp-lich)
       (method 'hydr kurp-hydr)
       (method 'lost kurp-lost)       
       ))

;; Green Tower
(define (gt-gobl knpc kpc)
  (say knpc "Since the goblin wars there's been an uneasy truce. Sometimes they trade here in town, but if you meet them in the forest be careful."))
(define (gt-towe knpc kpc)
  (say knpc "The tower that gives this town its name is now the Ranger headquarters."))

(define green-tower-conv
  (ifc basic-conv
       (method 'gobl gt-gobl)
       (method 'towe gt-towe)
       ))

;; Trigrave
(define trigrave-conv
  (ifc basic-conv
       (method 'thie 
               (lambda (knpc kpc) 
                 (say knpc "I don't know anything about a thief. Ask Gwen, maybe a traveler told her something.")))                       
       ))


