
(define (mk-monster-generator-ifc threshold party faction vehicle)
  (ifc '() 
       (method 'exec (lambda (gen)
                       (if (> (modulo (random-next) 100) threshold)
                           (kern-obj-put-at (kern-mk-party party faction vehicle)
                                            (kern-obj-get-location gen)))))))

;; Note: if you try to create this interface on-the-fly, as in the commented
;; out part below, then you will eventually get a runtime crash. The reason is
;; that the procedure created by the lambda in mk-gen-ifc will not be referred
;; to by any environment variable, so the gc will deallocate it.
(define goblin-gen-ifc 
  (ifc '()
       (method 'exec (lambda (kobj)
                       (if (> (modulo (random-next) 100) 99)
                           (kern-obj-put-at (kern-mk-party t_goblin_horde
                                                           faction-monster
                                                           '())
                                            (kern-obj-get-location kobj)))))))


;; A monster generator
(mk-obj-type 't_goblin_generator "goblin generator" nil layer-none 
             goblin-gen-ifc)

;; ----------------------------------------------------------------------------
;; A monster type is a convenient collection of all the attributes needed to
;; create an instance of a stock monster.
;; ----------------------------------------------------------------------------
(define (mk-monster-type species occupation sprite name faction ai)
  (list species occupation sprite name faction ai))

;; ----------------------------------------------------------------------------
;; Given one of our monster types, create an instance. Note the trick here with
;; apply: a monster-type is a list of exactly the args needed for the
;; kern-mk-stock-char api call.
;; ----------------------------------------------------------------------------
(define (mk-monster type)
  (apply kern-mk-stock-char type))
