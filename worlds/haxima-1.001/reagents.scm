;; Extend the basic object interface to support mixing. Currently mix does
;; nothing in the script, but it's important to let the kernel know that this
;; type of object can be used with the M)ix command.
(define reagent-ifc
  (ifc obj-ifc
       (method 'mix (lambda () '()))))

(define (mk-reagent-type tag name sprite)
  (mk-obj-type tag name sprite layer-item reagent-ifc))

(define reagent-types
  (list
   (list 'sulphorous_ash "sulphorous ash" s_grayish_red_hunks)
   (list 'garlic         "garlic"         s_gold_powder)
   (list 'mandrake       "mandrake"       s_brown_mushroom)
   (list 'nightshade     "nightshade"     s_black_mushroom)
   (list 'bloodmoss      "bloodmoss"      s_red_hunks)
   (list 'black_pearl    "black pearl"    s_ring2)
   (list 'ginseng        "ginseng"        s_brown_powder)
   (list 'blood_moss     "blood moss"     s_red_hunks)
   (list 'spider_silk    "spider silk"    s_spider_web)
   ))

(map (lambda (type) (apply mk-reagent-type type)) reagent-types)
