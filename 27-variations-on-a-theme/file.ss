;; 27.2.1
(list)                                  ;empty

(list                                   ;(list 'NL)
 (list)
 )

(list                                   ;(list 'NL 'NL)
 (list)
 (list))


;; file->list-of-lines : file  ->  (listof (listof symbols))
;; to convert a file into a list of lines 
(define (file->list-of-lines afile)
  (cond
   [(null? afile) (list)]
   [else
    (cons
     (first-line afile)
     (file->list-of-lines (remove-first-line afile)))]))

(define (first-line afile)
  (cond
     [(null? afile) '()]
     [(eq? (car afile) 'NL) '()]
     [else
      (cons (car afile) (first-line (cdr afile)))]))

(define (remove-first-line afile)
  (cond
     [(null? afile) '()]
     [(eq? (car afile) 'NL) (cdr afile)]
     [else
      (remove-first-line (cdr afile))]))

(define afile
  (list 'a 'b 'c 'NL
        'd 'e 'NL
        'f 'g 'h 'NL))

;;; 27.2.3
(define-struct rr (table costs))

(define (file->list-of-checks afile)
  (cond
   [(null? afile) (list)]
   [else
    (cons
     (make-a-check (first-line afile))
     (file->list-of-checks (remove-first-line afile)))]))

(define (make-a-check aline)
  (make-rr
   (car aline)
   (cdr aline)))

(file->list-of-checks
	  (list 1 2.30 4.00 12.50 13.50 'NL
       	        2 4.00 18.00 'NL
                4 2.30 12.50))

;;; 27.2.4
(define (create-matrix n lons)
  (cond
   [(null? lons) (list)]
   [else
    (cons
     (first-n lons n)
     (create-matrix n (remove-first-n lons n)))]))
(define (first-n lons n)
  (cond
   [(= n 0) (list)]
   [else
    (cons (car lons)
          (first-n (cdr lons) (- n 1)))]))
(define (remove-first-n lons n)
  (cond
   [(= n 0) lons]
   [else
    (remove-first-n (cdr lons) (- n 1))]))

