;;----------------------------------------------------------------------------
;; Containers - objects that contain stuff
;;----------------------------------------------------------------------------
;;----------------------------------------------------------------------------
;; Local Procedures
;;----------------------------------------------------------------------------
(define (add-content quantity type)
  (list quantity type))

(define (mk-contents . contents)
  (filter notnull? contents))

(define (roll-100 prob)
  (>= prob (modulo (random-next) 100)))

(define (roll-q dice type)
  (add-content (kern-dice-roll dice) type))

(define (roll-to-add prob dice type)
  (if (roll-100 prob)
      (roll-q dice type)
      nil))

;;----------------------------------------------------------------------------
;; Container Types
;;----------------------------------------------------------------------------
(mk-obj-type 't_chest 
             "chest"  s_chest
             layer-container nil)

;;----------------------------------------------------------------------------
;; Container Constructors
;;----------------------------------------------------------------------------
(define (mk-chest trap contents)
  ;;(println "mk-chest: " trap contents)
  (kern-mk-container t_chest trap contents))

;; mk-treasure-chest -- returns a chest with 1-10 random object types
(define (mk-treasure-chest)
  (kern-mk-container t_chest 
                     nil 
                     (mk-treasure-list (+ 1
                                          (modulo (random-next) 
                                                  9)))))


;;----------------------------------------------------------------------------
;; Corpse -- not really a container, if you search it then it sort of acts like
;; opening a container
;;----------------------------------------------------------------------------
(define (corpse-mk loot)
  (list loot))
(define (corpse-loot corpse) (car corpse))
(define (corpse-set-loot! corpse val) (set-car! corpse val))
(define (corpse-loot-entry-q loot) (car loot))
(define (corpse-loot-entry-type loot) (eval (cadr loot)))

(define (corpse-search kobj)
  (let* ((corpse (kobj-gob-data kobj))
         (loot (corpse-loot corpse)))
    (if (not (null? loot))
        (let ((loc (kern-obj-get-location kobj)))
          (map (lambda (entry) 
                 (kern-obj-put-at (kern-mk-obj (corpse-loot-entry-type entry)
                                               (corpse-loot-entry-q entry))
                                  loc))
               loot)
          (corpse-set-loot! corpse nil)))))

(define corpse-ifc
  (ifc nil
       (method 'search corpse-search)))

(mk-obj-type 't_corpse "corpse" s_corpse layer-item corpse-ifc)

(define (mk-corpse) 
  (bind (kern-mk-obj t_corpse 1)
        (corpse-mk nil)))

;; mk-corpse2 -- loot: a list of (quantity type) lists
(define (mk-corpse2 loot)
  (bind (kern-mk-obj t_corpse 1)
        (corpse-mk loot)))

(define (mk-corpse-with-loot)
  (mk-corpse2 (mk-quoted-treasure-list (+ 1(modulo (random-next)
                                                   3)))))

;;----------------------------------------------------------------------------
;; This next section is an experimental new container type. It attempts to
;; bypass the kernel's built-in Container class and implement everything in the
;; script as a normal kernel Object that responds to the 'open signal the same
;; way a kernel Container would respond to the open command.
;;
;; This currently works. The next step is to implement the ability to add (and
;; remove or disable) traps on a container. The means of doing so will be
;; implemented here in the script, so the kernel won't need to know about
;; trapped containers when this all works, and the kernel's Container class can
;; be stripped back to a basic Inventory class.

;; Define the gob structure and procedures. The contents should be a single
;; quoted list, for example:
;;
;;   '((t_sword 1)
;;     (t_arrow 5)
;;     (t_torch 2)))
;;
;; Using the quotes is not only cleaner in the declarations, it automatically
;; ensures that the contents are safe to save and reload as part of the gob
;; because they are stored in the gob merely as symbols.
(define (mk-container contents) (cons 'container contents))
(define (is-container? gob) (eq? (car gob) 'container))
(define (container-contents gob) (car (cdr gob)))
(define (content-type content) (car content))
(define (content-quantity content) (cadr content))

;; This is the heart of the implementation. This procedure runs when the
;; container object gets the 'open signal, which is sent by the kernel in
;; response to the player's o)pen command followed by selection of this
;; object. It expects kobj to be a kernel object which is bound to a container
;; gob following the above format (the constructors further down illustrate how
;; to create such an object).
;;
;; Opening the container creates objects based on the types and quantities
;; listed in the container's content list and deposits these objects on the
;; ground where the container is. Then it removes the container, which likely
;; results in its destruction.
(define (container-open kobj kchar)
  (let ((container (kobj-gob-data kobj))
        (loc (kern-obj-get-location kobj)))
    (println container)
    (map (lambda (content)
           (println content)
           (let ((newobj (kern-mk-obj (eval (content-type content))
                                      (content-quantity content))))
             (kern-obj-put-at newobj loc)))
         (container-contents container))
    (kern-obj-remove kobj)))

;; This interface binds the 'open signal to our open procedure above.
(define container-ifc
  (ifc '()
       (method 'open container-open)))

;; This constructor makes new types of objects that conform to the container
;; interface above. An example of usage is below, where I make a new chest type.
(define (mk-container-type tag name sprite)
  (mk-obj-type tag name sprite layer-mechanism container-ifc))


;; Test it out. First, make a new chest type.
(mk-container-type 't_chest2 "chest" s_chest)

;; Define a constructor for an object of the new chest type. Example usage:
;;
;; (put (mk-chest2 '((t_sword 1)
;;                   (t_arrow 5)
;;                   (t_torch 2)))
;;      5 8)
;;
;; * Note the use of a quoted list.
;;
(define (mk-chest2 . ktype-q-pairs)
  (bind (kern-mk-obj t_chest2 1)
        (mk-container ktype-q-pairs)))
