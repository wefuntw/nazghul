;; Enchanter's Tower
(define (mk-zone x y w h) (list 'p_enchanters_tower x y w h))
(define enchtwr-campsite         (mk-zone  4  4  5   5))
(define enchtwr-dining-room-1    (mk-zone  9 11  1   1))
(define enchtwr-dining-room-2    (mk-zone 11 11  1   1))
(define enchtwr-dining-room      (mk-zone  8  8  5   5))
(define enchtwr-bedroom-1        (mk-zone 18 11  5   2))
(define enchtwr-hall             (mk-zone 11 18  9   6))
(define enchtwr-ench-bed         (mk-zone 21 11  1   1))
(define enchtwr-zane-bed         (mk-zone  7  6  1   1))

;; Bole
(define (mk-zone x y w h) (list 'p_bole x y w h))
(define bole-bed-kathryn  (mk-zone 31 18  1  1))
(define bole-bedroom-thud (mk-zone 31 17  2  2))
(define bole-bed-2        (mk-zone 38 18  1  1))
(define bole-bed-3        (mk-zone 31 21  1  1))
(define bole-bed-4        (mk-zone 38 21  1  1))
(define bole-bed-may      (mk-zone 44 17  1  1))
(define bole-bed-melvin   (mk-zone 40 17  1  1))
(define bole-bed-bill     (mk-zone 23 19  1  1))
(define bole-bed-hackle   (mk-zone 5  8   1  1))
(define bole-bedroom-may  (mk-zone 40 18  5  4))
(define bole-bills-hut    (mk-zone 20 15  4  5))
(define bole-courtyard    (mk-zone 24 25  5  5))
(define bole-dining-hall  (mk-zone 31 23  5  7))
(define bole-hackles-hut  (mk-zone 5   8  5  5))
(define bole-hackles-yard (mk-zone 2   3  5 13))
(define bole-kitchen      (mk-zone 39 23  3  7))
(define bole-n-woods      (mk-zone 22  0  8 11))
(define bole-table-1      (mk-zone 32 26  1  1))
(define bole-table-2      (mk-zone 34 26  1  1))
(define bole-table-3      (mk-zone 34 27  1  1))
(define bole-table-4      (mk-zone 32 27  1  1))

;; Trigrave
(define (mk-zone x y w h) (list 'p_trigrave x y w h))
(define trigrave-chants-bed      (mk-zone 12  6   1  1))
(define trigrave-forge           (mk-zone 25  4   5  5))
(define trigrave-jims-bed        (mk-zone 25 11   1  1))
(define trigrave-tavern-hall     (mk-zone 18 23   8  6))
(define trigrave-tavern-kitchen  (mk-zone 27 25   3  5))
(define trigrave-miggs-bed       (mk-zone 27 22   1  1))
(define trigrave-tavern-table-1a (mk-zone 19 23   1  1)) 
(define trigrave-tavern-table-1d (mk-zone 21 23   1  1)) 
(define trigrave-tavern-table-3a (mk-zone 19 27   1  1)) 
(define trigrave-inn-counter     (mk-zone  5  4   9  3))
(define trigrave-gwens-bed       (mk-zone 12  2   1  1))
(define trigrave-gwens-room      (mk-zone 11  2   2  3))
(define trigrave-inn-room-1      (mk-zone  2  6   2  2))
(define trigrave-inn-room-2      (mk-zone  2  9   2  2))
(define trigrave-inn-room-3      (mk-zone 11  6   2  2))
(define trigrave-inn-room-4      (mk-zone 11  9   2  2))
(define trigrave-east-west-road  (mk-zone  0 15  32  3))
(define trigrave-earls-bed       (mk-zone  2  9   1  1))
(define trigrave-earls-counter   (mk-zone  2 24   5  1))
(define trigrave-earls-room      (mk-zone  2  9   2  2))

;; Oparine
(define (mk-zone x y w h) (list 'p_oparine x y w h))
(define alkemist-ship    (mk-zone  4 52  4  3))
(define alkemist-bed     (mk-zone  4 47  1  1))
(define alkemist-bedroom (mk-zone  2 47  3  2))
(define bilge-water-counter    (mk-zone  9 39  5  1))
(define bilge-water-storage    (mk-zone  6 37  2  3))
(define bilge-water-bedroom    (mk-zone 15 37  2  5))
(define bilge-water-hall       (mk-zone  9 41  5  6))
(define bilge-water-seat-1     (mk-zone  6 42  1  1))
(define bilge-water-seat-2     (mk-zone  7 42  1  1))
(define bilge-water-seat-3     (mk-zone  8 42  1  1))
(define bilge-water-seat-4     (mk-zone  6 44  1  1))
(define bilge-water-seat-5     (mk-zone  7 44  1  1))
(define bilge-water-seat-6     (mk-zone  8 44  1  1))
(define bilge-water-seat-7     (mk-zone  6 45  1  1))
(define bilge-water-seat-8     (mk-zone  7 45  1  1))
(define bilge-water-seat-9     (mk-zone  8 45  1  1))
(define bilge-water-seat-10    (mk-zone  6 47  1  1))
(define bilge-water-seat-11    (mk-zone  7 47  1  1))
(define bilge-water-seat-12    (mk-zone  8 47  1  1))
(define bilge-water-seat-13    (mk-zone 14 42  1  1))
(define bilge-water-seat-14    (mk-zone 15 42  1  1))
(define bilge-water-seat-15    (mk-zone 16 42  1  1))
(define bilge-water-seat-16    (mk-zone 14 44  1  1))
(define bilge-water-seat-17    (mk-zone 15 44  1  1))
(define bilge-water-seat-18    (mk-zone 16 44  1  1))
(define bilge-water-seat-19    (mk-zone 14 45  1  1))
(define bilge-water-seat-20    (mk-zone 15 45  1  1))
(define bilge-water-seat-21    (mk-zone 16 45  1  1))
(define bilge-water-seat-22    (mk-zone 14 47  1  1))
(define bilge-water-seat-23    (mk-zone 15 47  1  1))
(define bilge-water-seat-24    (mk-zone 16 47  1  1))
(define sea-witch-counter (mk-zone 51 53  5  1))
(define sea-witch-broom   (mk-zone 51 55  5  2))
(define sea-witch-beach   (mk-zone 52 59  3  2))
(define sea-witch-bay     (mk-zone 38 60  6  4))
(define cheerful-counter  (mk-zone 10  8  8  1))
(define cheerful-room-1   (mk-zone 10 13  2  2))
(define cheerful-room-2   (mk-zone 10 16  2  2))
(define cheerful-room-3   (mk-zone 13 19  2  2))
(define cheerful-room-4   (mk-zone 16 16  2  2))
(define cheerful-room-5   (mk-zone 16 13  2  2))
(define cheerful-bed-1   (mk-zone 10 13  1  1))
(define cheerful-bed-2   (mk-zone 10 16  1  1))
(define cheerful-bed-3   (mk-zone 13 19  1  1))
(define cheerful-bed-4   (mk-zone 17 16  1  1))
(define cheerful-bed-5   (mk-zone 17 13  1  1))
(define innkeepers-hut   (mk-zone  4  3  2  3))
(define innkeepers-bed   (mk-zone  4  3  1  1))
(define black-barts-ship  (mk-zone 36 24  3  5))
(define black-barts-broom (mk-zone 46 17  3  5))
(define black-barts-bed   (mk-zone 46 19  1  1))
