
;; init.scm -- contains lots of common scheme utilities
(load "init.scm")

;; Override the default error hook to warn the loader when the interpreter
;; encounters any errors during evaluation.
(define (my-error-hook . x)
  (kern-interp-error x)
  (apply throw x))
(define *error-hook* my-error-hook)

;; kern-load -- loads a file but also tells the kernel to make a note of it so
;; that saved sessions will know to use the file, too.
(define (kern-load fname)
  (kern-include fname)
  (load fname))

(define nil '())

;; safe-eval -- evaluates an expression; bad expressions evaluate to '()
;; instead of causing an interpreter error
(define (safe-eval expr)
  (cond ((null? expr) '())
        ((symbol? expr)
         (if (defined? expr)
             (eval expr)
             '()))
        (eval expr)))

;; filter -- filter-in elements from a list
(define (filter pred seq)
  (cond ((null? seq) nil)
        ((pred (car seq))
         (cons (car seq)
               (filter pred (cdr seq))))
        (else (filter pred (cdr seq)))))

;; simple, non-prioritized, generic search (not very efficient, so don't try
;; it on large search spaces)
(define (search here? next start maxdepth)
  (define (do-search queue visited depth)
    (if (or (= depth 0) (null? queue)) nil
        (let ((loc (car queue)))
          (if (here? loc) loc
              (do-search (append (cdr queue)
                                 (filter (lambda (v) (not (member v visited)))
                                         (next loc)))
                         (append (list loc) visited)
                         (- depth 1))))))
  (do-search (list start) nil maxdepth))

;; similar to search, but a) it's exhaustive and b) it runs a procedure on
;; every entry (warning: not sure if or how well this works)
(define (bfs-apply start next proc)
  (define (do-search queue visited)
    (if (null? queue) nil
        (let ((loc (car queue)))
          (proc loc)
          (do-search (append (cdr queue)
                             (filter (lambda (v) (not (member v visited)))
                                     (next loc)))
                     (append (list loc) visited)))))
  (do-search (list start) nil))
  
;; Set element k of list x to val (zero-indexed)
(define (list-set-ref! x k val)
  (if (zero? k)
      (set-car! x val)
      (list-set-ref! (cdr x) (- k 1) val)))

;; Check if a location is passable to a character
(define (passable? loc char)
  (kern-place-is-passable loc char))

;; Check if a location is occupied by a character or party
(define (occupied? loc)
  (foldr (lambda (val kobj) (or val (kern-obj-is-char? kobj)))
         #f 
         (kern-get-objects-at loc)))

;; Given a starting location, search outward for a passable, unoccupied place
;; to put a character.
(define (pick-loc origin char)
  (search (lambda (loc) (and (passable? loc char)
                             (not (occupied? loc))))
          neighbors 
          origin
          100))

;; Generic proc to summon other beings. Used by spells and some special
;; effects.
(define (summon origin mk-critter count)
  (define (run-loop n)
    (if (= n 0) nil
        (let* ((critter (kern-obj-set-temporary (mk-critter) #t))
               (loc (pick-loc origin critter)))
          (cond ((null? loc) nil)
                (else
                 (kern-obj-put-at critter loc)
                 (run-loop (- n 1)))))))
  (run-loop count))

;; Check if an object is hostile toward a character
(define (is-hostile? kchar kobj)
  (and (kern-obj-is-char? kobj)
       (kern-char-is-hostile? kchar kobj)))

;; Find all characters hostile to the given character
(define (all-hostiles kchar)
  (filter (lambda (kobj) (is-hostile? kchar kobj))
          (kern-place-get-objects (loc-place (kern-obj-get-location kchar)))))

(define (is-visible-hostile? kchar kobj)  
  (and (kern-obj-is-char? kobj)
       (kern-char-is-hostile? kchar kobj)
       (<= (kern-get-distance (kern-obj-get-location kchar) 
                              (kern-obj-get-location kobj))
           (kern-obj-get-vision-radius kchar))
       (kern-in-los? (kern-obj-get-location kchar)
                     (kern-obj-get-location kobj))
       (kern-obj-is-visible? kobj)))

(define (all-visible-hostiles kchar)
  (filter (lambda (kobj) (is-visible-hostile? kchar kobj))
          (kern-place-get-objects (loc-place (kern-obj-get-location kchar)))))