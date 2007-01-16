;utility for searching {sum-of-probability, object} lists
(define (get-numbered-elem alist value)
	(if (>= (car (car alist)) value)
		(cdar alist)
		(get-numbered-elem (cdr alist) value)
		)
	)
	
;list utilities
(define (list-swap alist entry index)
	(if (null? alist)
		nil
		(if (zero? index)
			(cons entry (cdr alist))
			(cons (car alist)
				(list-swap (cdr alist) entry (- index 1)))
			)))
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; blit stats

; areamargin: from edge of room to area
; edgemargin: from corner of room to each side of edge tile
; edgewidth: from edge of room to inner side of edge tile

(define (prmap-mk-blitstats roomwidth roomheight areamargin edgemargin edgewidth)
	(list
		(list edgemargin 0 (- roomwidth edgemargin edgemargin) edgewidth)
		(list 0 edgemargin edgewidth (- roomheight edgemargin edgemargin))
		(list (- roomwidth edgewidth) edgemargin edgewidth (- roomheight edgemargin edgemargin))
		(list edgemargin (- roomheight edgewidth) (- roomwidth edgemargin edgemargin) edgewidth)
		(list areamargin areamargin (- roomwidth areamargin areamargin) (- roomheight areamargin areamargin))
	))
	
(define (prmap-blitstats-north data)
	(list-ref data 0))
(define (prmap-blitstats-west data)
	(list-ref data 1))
(define (prmap-blitstats-east data)
	(list-ref data 2))
(define (prmap-blitstats-south data)
	(list-ref data 3))
(define (prmap-blitstats-area data)
	(list-ref data 4))
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Directions	

; order is N W E S
(define (cardinal-dir-num dir)
	(/ (- dir 1) 2))

(define (get-cardinal-ref list dir)
	(list-ref list
		(cardinal-dir-num dir))
		)

(define prmap-room-offsets
	(list 
		(list 0 1)
		(list -1 0)
		(list 1 0)
		(list 0 -1)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Generic room data

(mk-obj-type 't_roomdata nil nil layer-none nil)

; returns roomdata object or nil if none
(define (get-roomdata kplace)
	(let ((dataslist (kplace-get-objects-of-type kplace t_roomdata)))
		(if (equal? (length dataslist) 0)
			nil
			(gob (car dataslist)))))
			

; replaces any roomdatas in place with given data
(define (set-roomdata kplace data)
	(begin
		; remove any/all previous data
		(map (lambda (rdataobj)
				(kern-obj-remove rdataobj))
			(kplace-get-objects-of-type kplace t_roomdata))
		;add new t_roomdata
		(kern-obj-put-at
			(bind (kern-obj-set-visible (kern-mk-obj t_roomdata 1) #f) data)
			(list kplace 0 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Random map roomdata

(define (prmap-roomdata-x data)
	(list-ref data 0))
(define (prmap-roomdata-y data)
	(list-ref data 1))
(define (prmap-roomdata-z data)
	(list-ref data 2))
(define (prmap-roomdata-current data)
	(list-ref data 3))
(define (prmap-roomdata-prev data)
	(list-ref data 4))
(define (prmap-roomdata-rooms data)
	(list-ref data 5))

(define (prmap-roomdata-setxyz data x y z)
	(set-car! data x)
	(set-car! (cdr data) y)
	(set-car! (cddr data) z))
	
;prev becomes current, current is cleared
(define (prmap-roomdata-pushcurrent data)
	(let ((curdat (list-tail data 3)))
		(set-car! (cdr curdat) (car curdat))
		(set-car! curdat #f)))

(define (prmap-roomdata-setcurrent data cur)
	(let ((curdat (list-tail data 3)))
		(set-car! curdat cur)))

(define (prmap-mk-roomdata room x y z current prev rooms)
	(set-roomdata room (list x y z current prev rooms))
	)
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Room linking

; 2 dimensional map - 5 rooms

;  2   5   4   1   3                   
; 513 324 132 245 451                          
;  4   1   5   3   2 

(define (prmap-linkrooms-2d room1-tag room2-tag room3-tag room4-tag room5-tag)
	(prmap-mk-roomdata (eval room1-tag) 0 0 0 #f #f (list room2-tag room5-tag room3-tag room4-tag))
	(prmap-mk-roomdata (eval room2-tag) 0 0 0 #f #f (list room5-tag room3-tag room4-tag room1-tag))
	(prmap-mk-roomdata (eval room3-tag) 0 0 0 #f #f (list room4-tag room1-tag room2-tag room5-tag))
	(prmap-mk-roomdata (eval room4-tag) 0 0 0 #f #f (list room1-tag room2-tag room5-tag room3-tag))
	(prmap-mk-roomdata (eval room5-tag) 0 0 0 #f #f (list room3-tag room4-tag room1-tag room2-tag))
	)

; 3 dimensional map - 7 rooms

;   2 6     3 7     5 4     1 5     6 2     7 3     4 1
; 5 1 3   6 2 4   1 3 7   2 4 6   7 5 1   4 6 2   3 7 5
; 7 4     5 1     6 2     3 7     4 3     1 5     2 6

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Map paramater storage

(mk-obj-type 't_mapdata nil nil layer-none nil)

; returns roomdata object or nil if none
(define (prmap-get-mapdata kplace)
	(let ((dataslist (kplace-get-objects-of-type kplace t_mapdata)))
		(if (equal? (length dataslist) 0)
			nil
			(gob (car dataslist)))))
			

; replaces any roomdatas in place with given data
(define (prmap-set-mapdata kplace data)
	(begin
		; remove any/all previous data
		(map (lambda (rdataobj)
				(kern-obj-remove rdataobj))
			(kplace-get-objects-of-type kplace t_mapdata))
		;add new t_mapdata
		(kern-obj-put-at
			(bind (kern-obj-set-visible (kern-mk-obj t_mapdata 1) #f) data)
			(list kplace 0 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Map random seed values

(define (prmap-mk-prng-params xscale yscale zscale offset modulus)
	(list xscale yscale zscale offset modulus))

(define (prmap-prng-param-xscale data)
	(list-ref data 0))
(define (prmap-prng-param-yscale data)
	(list-ref data 1))
(define (prmap-prng-param-zscale data)
	(list-ref data 2))
(define (prmap-prng-param-offset data)
	(list-ref data 3))
(define (prmap-prng-param-modulus data)
	(list-ref data 4))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Random map parameter data

(define (prmap-mk-mapdata nsparams ewparams areaparams edgemaps areamaps blitstats hardlinkfunction hardlinks) 
	(list nsparams ewparams areaparams edgemaps areamaps blitstats hardlinkfunction hardlinks))

(define (prmap-params-nsparams params)
	(list-ref params 0))
(define (prmap-params-ewparams params)
	(list-ref params 1))
(define (prmap-params-areaparams params)
	(list-ref params 2))
(define (prmap-params-edgemaps params)
	(list-ref params 3))
(define (prmap-params-areamaps params)
	(list-ref params 4))
(define (prmap-params-blitstats params)
	(eval (list-ref params 5)))
(define (prmap-params-hardlinkfunction params)
	(let ((candidatefn (list-ref params 6)))
		(eval
			(if (null? candidatefn)
				'prmap-room-gethardlink
				candidatefn
		))))
(define (prmap-params-hardlinks params)
	(list-ref params 7)
	)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Random template handling

(define (prmap-get-template rxloc ryloc rzloc maptype maplistref)
	(let* (
			(xmult (prmap-prng-param-xscale maptype)) 
			(ymult (prmap-prng-param-yscale maptype)) 
			(zmult (prmap-prng-param-zscale maptype)) 
			(addfactor (prmap-prng-param-offset maptype)) 
			(modfactor (prmap-prng-param-modulus maptype)) 
			(maplist (eval maplistref))
			(mapnumber (modulo (+ (* rxloc xmult) (* ryloc ymult) (* rzloc zmult) addfactor) modfactor))
		)
		;get the map from the first entry with value greater than mapnumber		
		(cdr 
			(car (filter (lambda (listentry)
				(> (car listentry) mapnumber))
					maplist))
			)
	))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; deeps fixed map enabling

(define (prmap-room-mklinkset northnode westnode eastnode southnode)
	(list northnode westnode eastnode southnode))

(define (prmap-room-mklink dir target maptemplate . hooklist)
	(let* ((node (cons target (cons maptemplate hooklist))))
		(get-cardinal-ref
			(list
				(prmap-room-mklinkset node nil nil nil)
				(prmap-room-mklinkset nil node nil nil)
				(prmap-room-mklinkset nil nil node nil)
				(prmap-room-mklinkset nil nil nil node)
			)
			dir
		)
	))	
	
(define (prmap-room-gethardlink xloc yloc zloc linksdata)
	(let (
		(matchinglink
			(filter (lambda (listentry)
				(and
					(equal? (car listentry) xloc)
					(equal? (cadr listentry) yloc)
					(equal? (caddr listentry) zloc)
				))
				linksdata)
			)
		)
		(if (equal? (length matchinglink) 0)
			(list nil nil nil nil)
			(cadddr (car matchinglink)))))

(define (prmap-room-getmaphardlink xloc yloc zloc mapdata)
	(apply (prmap-params-hardlinkfunction mapdata) (list xloc yloc zloc (prmap-params-hardlinks mapdata)))
	)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; x y location tracking

;sets x and y location of new rooms based on current location and direction to new room
;also updates current -> prev -> normal status
(define (prmap-room-setxyz roomslist dir rxloc ryloc rzloc)
	(let* (
			(kplace (eval (get-cardinal-ref roomslist dir)))
			(roomdata (get-roomdata kplace))
			(offsets (get-cardinal-ref prmap-room-offsets dir))
			(rxoff (+ rxloc (car offsets)))
			(ryoff (+ ryloc (cadr offsets)))
		)
		(if (not (prmap-roomdata-current roomdata))
			(prmap-roomdata-setxyz roomdata rxoff ryoff rzloc))
		(prmap-roomdata-pushcurrent roomdata)
		))

;set xy stuff for all neighboring rooms, also sets current as current
(define (prmap-room-init-neighbors kplace roomdata)
	(let* (
			(rooms (prmap-roomdata-rooms roomdata))
			(rxloc (prmap-roomdata-x roomdata))
			(ryloc (prmap-roomdata-y roomdata))
			(rzloc (prmap-roomdata-z roomdata))
		)
		(map (lambda (dir)
			(prmap-room-setxyz rooms dir rxloc ryloc rzloc))
			(list north west east south))
		(prmap-roomdata-setcurrent roomdata #t)
		;debugging map
		(if #f
			(begin
				(kern-log-msg rxloc)
				(kern-log-msg ryloc)
				(kern-log-msg rzloc))
		)
	))
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Room linking

; links in neighbors, or rooms from hardlink list, as appropriate
(define (prmap-room-init-links kplace roomdata mapdata)
	(let* (
			(rooms (prmap-roomdata-rooms roomdata))
			(rxloc (prmap-roomdata-x roomdata))
			(ryloc (prmap-roomdata-y roomdata))
			(rzloc (prmap-roomdata-z roomdata))
			(linkinfo (prmap-room-getmaphardlink rxloc ryloc rzloc mapdata))
		)
		(map (lambda (dir)
			;roomlinktarget is hardlink target if it exists, else regular neighbor
			(let* (
				(thishardlink (get-cardinal-ref linkinfo dir))
				(hardlinktarget (if (null? thishardlink)
									nil
									(car thishardlink)))
				(roomlinktarget (if (null? hardlinktarget)
									(get-cardinal-ref rooms dir)
									hardlinktarget))
				)
				(kern-place-set-neighbor dir kplace (eval roomlinktarget))
			))
			(list north west east south))
	))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; map construction	
	
; do a single map blit
(define (prmap-do-map-blit destmap srcmap blitstats)
	(let (
			(xloc (list-ref blitstats 0))
			(yloc (list-ref blitstats 1))
			(wid (list-ref blitstats 2))  
			(hgt (list-ref blitstats 3))
		)	
		(kern-blit-map destmap xloc yloc
				(eval srcmap)
				xloc yloc wid hgt)
	))
	
; blit map for area and all sides. uses hard linked sides if given
(define (prmap-room-blit-map kplace roomdata mapdata)
	(let* (
			(rxloc (prmap-roomdata-x roomdata))
			(ryloc (prmap-roomdata-y roomdata))
			(rzloc (prmap-roomdata-z roomdata))
			(linkinfo (prmap-room-getmaphardlink rxloc ryloc rzloc mapdata))
			(blitstats (prmap-params-blitstats mapdata))
			(destmap (kern-place-map kplace))
			(rmapdata (list
				(list 0 1 (prmap-params-nsparams mapdata))
				(list 0 0 (prmap-params-ewparams mapdata))
				(list 1 0 (prmap-params-ewparams mapdata))
				(list 0 0 (prmap-params-nsparams mapdata))
				))
			(areamap-choice (prmap-get-template rxloc ryloc rzloc (prmap-params-areaparams mapdata) (prmap-params-areamaps mapdata)))
		)
		(prmap-do-map-blit destmap
			(car areamap-choice)
			(prmap-blitstats-area blitstats))
		(if (> (length areamap-choice) 1)
			(apply (eval (cadr areamap-choice)) (list kplace))
			)
		(map (lambda (dir)
			;roomlinktarget is hardlink target if it exists, else regular neighbor
			(let* (
					(thishardlink (get-cardinal-ref linkinfo dir))
					(thisrmapdata (get-cardinal-ref rmapdata dir))
					(thisx (+ rxloc (car thisrmapdata)))
					(thisy (+ ryloc (cadr thisrmapdata)))
					(thisrtype (caddr thisrmapdata))
					(linkmap (if (null? thishardlink)
								(prmap-get-template thisx thisy rzloc thisrtype (prmap-params-edgemaps mapdata))
								(cdr thishardlink)))
				)
				(prmap-do-map-blit destmap (car linkmap)
					(get-cardinal-ref blitstats dir))
				(if (> (length linkmap) 1)
					(map (eval (get-cardinal-ref (cdr linkmap) dir)) (list kplace))
					)
			))
			(list north west east south))
	))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Monster handling

(define (prmap-reduce-level level remaining)
	(max 1
		(- level (/ (* level (kern-dice-roll "1d100")) 50 (max remaining 2)))
		)
	)
	
(define (prmap-get-monster-group quantity grouptype level typelev)
	(cons (mk-npc (car (get-numbered-elem grouptype typelev)) (ceiling (/ level 100)))
		(if (> quantity 0)
			(prmap-get-monster-group (- quantity 1) grouptype
				(prmap-reduce-level level quantity)
				(prmap-reduce-level typelev quantity))
			nil)
	))
	
(define (prmap-mk-monster-group group-types monster-types dice level)
	(let* (
			(grouptype (get-numbered-elem group-types (kern-dice-roll dice)))
			(grouplist (list-ref monster-types (car grouptype)))
		)
		(prmap-get-monster-group (kern-dice-roll (caddr grouptype))
			grouplist level (cadr grouptype))
	))
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Object handling


(define (prmap-room-cleanout kplace)
	(map (lambda (obj)
		(if (or (equal? (kern-obj-get-type obj) t_roomdata) (equal? (kern-obj-get-type obj) t_mapdata))
			nil
			(begin 
				(kern-obj-remove obj))
		))
		(kern-place-get-objects kplace))
	)
	
(define (prmap-room-addmonster kplace kchar)
	(kern-obj-put-at kchar 
		(random-loc-place-iter kplace 
			(lambda (loc)
				(and (passable? loc kchar)
					(not (is-bad-terrain-at? loc))
					(not (any-object-types-at? loc all-field-types))
					(not (occupied? loc))
				))
		15))
	)

; clears out old objects, and creates new ones
;    this one is rather specific to the endless deeps. need generic version
(define (prmap-room-init-contents kplace roomdata)
	(let* (
			(rxloc (prmap-roomdata-x roomdata))
			(ryloc (prmap-roomdata-y roomdata))
			(distance (sqrt (+ (* rxloc rxloc) (* ryloc ryloc))))
		)
		(if (< (kern-dice-roll "1d100") 
				(min 75 (+ 25 (* 15 (sqrt distance)))))
			(begin 
			(map (lambda (monster)
				(begin 

					(prmap-room-addmonster kplace monster)))
				(prmap-mk-monster-group deep-group-types deep-monster-types 
					(string-append "1d" (number->string (min 300 (ceiling (* 120 (sqrt distance))))))
					(+ 400 (* 100 (sqrt distance)))))
					)
		)
	))
	
