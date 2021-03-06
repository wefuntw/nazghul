(define (generic-hail knpc kpc)
  (kern-conv-say knpc "Well met"))

(define (generic-unknown knpc kpc)
  (kern-conv-say knpc "I can't help thee with that"))

(define (generic-bye knpc kpc)
  (kern-conv-say knpc "Farewell")
  (kern-conv-end))

(define basic-conv
  (ifc '()
       (method 'hail generic-hail)
       (method 'default generic-unknown)
       (method 'bye generic-bye)
       ))

;; Helper
(define (say knpc . msg) (kern-conv-say knpc msg))

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
