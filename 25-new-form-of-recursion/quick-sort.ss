;; quick-sort : (listof number)  ->  (listof number)
;; to create a list of numbers with the same numbers as
;; alon sorted in ascending order
;; assume that the numbers are all distinct 
(define (quick-sort alon)
  (cond
    [(null? alon) '()]
    [else (append (quick-sort (smaller-items alon (car alon))) 
	    	  (list (car alon)) 
		  (quick-sort (larger-items alon (car alon))))]))

;; larger-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are larger than threshold
(define (larger-items alon threshold)
  (cond
    [(null? alon) '()]
    [else (if (> (car alon) threshold) 
	      (cons (car alon) (larger-items (cdr alon) threshold))
	      (larger-items (cdr alon) threshold))]))

;; smaller-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are smaller than threshold
(define (smaller-items alon threshold)
  (cond
    [(null? alon) '()]
    [else (if (< (car alon) threshold) 
	      (cons (car alon) (smaller-items (cdr alon) threshold))
	      (smaller-items (cdr alon) threshold))]))

(quick-sort '(11 8 14 7))
(quick-sort '(11 11 11 11))

;;; 25.2.2
(define (quick-sort alon)
  (cond
   [(null? alon) '()]
   [(= 1 (length alon)) alon]
   [else (append (quick-sort (smaller-items alon (car alon))) 
	    	 (list (car alon)) 
                 (quick-sort (larger-items alon (car alon))))]))

(quick-sort '(11 8 14 7))


;;; 25.2.4
(define (quick-sort alon)
  (cond
   [(null? alon) '()]
   [(= 1 (length alon)) alon]
   [else (append (quick-sort (smaller-items (cdr alon)  (car alon)))
	    	 (list (car alon)) 
                 (quick-sort (larger-items (cdr alon)  (car alon))))]))

;; smaller-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are smaller than or equal to threshold
(define (smaller-items alon threshold)
  (cond
   [(null? alon) '()]
   [else (if (<= (car alon) threshold) 
	     (cons (car alon) (smaller-items (cdr alon) threshold))
	     (smaller-items (cdr alon) threshold))]))

;;; 25.2.5
(define smaller-items (lambda (alon threashold) (filter (lambda (x) (<= x threashold)) alon)) )
(define larger-items (lambda (alon threashold) (filter (lambda (x) (> x threashold)) alon)) )

;;; 25.2.6

(define (quick-sort alon)
  (cond
   [(null? alon) '()]
   [(= 1 (length alon)) alon]
   [else (let [(smaller-items '())
               (larger-items '())]

           )]))

;; general-quick-sort : (X X  ->  bool) (list X)  ->  (list X)
(define (general-quick-sort a-predicate a-list)

  )
