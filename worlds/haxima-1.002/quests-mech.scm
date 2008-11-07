(define (quest-assign-always target)
	#t)
	
(define (quest-status-from-payload quest)
	"In progress"
	)

(define (quest-status-inprogress quest)
	"In progress"
	)

(define (quest-data-get tag)
	(let* ((questdata (tbl-get (gob (kern-get-player)) 'questdata))
			)
			(tbl-get questdata tag)
		)
	)

(define (quest-data-assign-once tag)
	(let ((questentry (quest-data-get tag)))
		(if (not (quest-assigned? questentry))
			(quest-assign questentry)
		)
	))	
	
;; assuming quest uses a tbl for payload, updates a key/value	
(define (quest-data-update tag key value)
	(let* ((qpayload (car (qst-payload (quest-data-get tag))))
			(updatehook (tbl-get qpayload 'on-update))
			)
		(if (not (equal? (tbl-get qpayload key) value))
			(begin
				(tbl-set! qpayload key value)
				(if (not (null? updatehook))
					((eval updatehook))
				)
				(qst-bump! (quest-data-get tag))
			))
	))
	
;; updates as per quest-data-update, but additionally triggers a passed in function
(define (quest-data-update-with tag key value callback)
	(let* (	(quest (quest-data-get tag))
			(qpayload (car (qst-payload quest)))
			(updatehook (tbl-get qpayload 'on-update))
			)
		(if (not (equal? (tbl-get qpayload key) value))
			(begin
				(tbl-set! qpayload key value)
				(callback)
				(if (not (null? updatehook))
					((eval updatehook))
				)		
				(qst-bump! (quest-data-get tag))
			))
	))

(define (quest-data-descr! tag descr)
	(qst-set-descr! (quest-data-get tag) descr)
	)

(define (quest-data-icon! tag icon)
	(qst-set-icon! (quest-data-get tag) icon)
	)
	
(define (quest-notify quest subfunction)
	(lambda (quest) 
		(if (quest-assigned? quest)
			(kern-log-msg "Quest updated: " (qst-title qst))
			)
		(subfunction quest)
	))
	
	
(define (grant-xp-fn amount)
	(lambda (quest) 
		(let* ((qpayload (car (qst-payload quest)))
				(totalxp (+ (tbl-get qpayload 'bonus-xp) amount))
				)
			(if (quest-assigned? quest)
				(kern-char-add-experience (car (kern-party-get-members (kern-get-player))) amount)
				(tbl-set! qpayload 'bonus-xp totalxp)
			)
		)
	))
	
(define (grant-party-xp-fn amount)
	(lambda (quest) 
		(let* ((qpayload (car (qst-payload quest)))
				(totalxp (+ (tbl-get qpayload 'bonus-xp) amount))
				(party (kern-party-get-members (kern-get-player)))
				(xp-each (ceiling (/ totalxp (length party))))
				)
			(if (quest-assigned? quest)
				(map (lambda (kchar) (kern-char-add-experience kchar xp-each)) party)
				(tbl-set! qpayload 'bonus-xp totalxp)
			)
		)
	))
	
;;-------------------------------------------------------
;; Reconcile active and pregenned quests at game load to simplify
;; ingame tracking
	
(kern-add-hook 'new_game_start_hook 'reconcile-quests)
(kern-add-hook 'new_game_start_hook 'refresh-quests)

(define (reconcile-quests kplayer)
	(let ((questlist
					(tbl-get (gob
						(kern-get-player)) 'quests))
				(questdata
					(tbl-get (gob 
						(kern-get-player)) 'questdata))
			)
		(map 
			(lambda (quest)
				(let ((tag (qst-tag quest)))
					(if (and (not (null? tag))
							(not (null? (tbl-get questdata tag))))
						(tbl-set! questdata tag quest))
				))
		questlist)
	))

(define (refresh-quests)
	(kern-load "quests-data.scm")
	)
	