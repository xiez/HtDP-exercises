(define (generative-recursive-fun problem)
  (cond
    [(trivially-solvable? problem)
     (determine-solution problem)]
    [else
     (combine-solutions
       ... problem ...
       (generative-recursive-fun (generate-problem-1 problem))
       [curriculum-Z-G-D-5.gif]
       (generative-recursive-fun (generate-problem-n problem)))]))

;;; 26.0.7

;; move-until-out : a-ball  ->  true
;; to model the movement of a ball until it goes out of bounds
(define (move-until-out a-ball)
  (cond
    [(out-of-bounds? a-ball) true]
    [else (and (draw-and-clear a-ball)
               (move-until-out (move-ball a-ball)))]))

;; 1. What is a trivially solvable problem?
;; A: the ball is out of bounds

;; 2. What is a corresponding solution?
;;; A: stop and return true

;; 3. How do we generate new problems that are more easily solvable than the original problem? Is there one new problem that we generate or are there several?
;;; A: If the ball is still inside the boundaries, two things must happen. First, the ball must be drawn and cleared from the canvas. Second, the ball must be moved, and then we must do things all over again.

;; 4.Is the solution of the given problem the same as the solution of (one of) the new problems? Or, do we need to combine the solutions to create a solution for the original problem? And, if so, do we need anything from the original problem data?
;; A: YES


;;; 26.0.8

(define (quick-sort alon)
  (cond
    [(empty? alon) empty]
    [else (append (quick-sort (smaller-items alon (first alon))) 
	    	  (list (first alon)) 
                  (quick-sort (larger-items alon (first alon))))]))

;; 1. What is a trivially solvable problem?
;; A: the input list is empty

;; 2. What is a corresponding solution?
;;; A: return empty

;; 3. How do we generate new problems that are more easily solvable than the original problem? Is there one new problem that we generate or are there several?
;;; A: uses the first item to partition the rest of the list into two sublists: a list with all items smaller than the pivot item and another one with those larger than the pivot item.

;; 4.Is the solution of the given problem the same as the solution of (one of) the new problems? Or, do we need to combine the solutions to create a solution for the original problem? And, if so, do we need anything from the original problem data?
;; A: YES
;; A: YES, we need to combine the solutions for the original problem. Nothing is needed from the original data.


;;; --------------------------------------------------------------------------------

;;; 26.1.1
;;; tabulate-div: n -> (listof number)
;;; e.g. 10 -> (list 1 2 4 5 10)
(define (tabulate-div n)
  (define (interval-div alon)
    (cond [(null? alon) '()]
          [else (if (divided? n (car alon))
                    (append
                     (list (car alon))
                     (interval-div (cdr alon)))
                    (interval-div (cdr alon)))]))
  (let [(intervals (gen-interv n))]
    (interval-div intervals)))
(define (gen-interv n)
  (cond
   [(= n 0) '()]
   [else
    (append (gen-interv (- n 1)) (list n))]))
(define (divided? n d)
  (= (remainder n d) 0))

;;; 26.1.2
;;; mrege-sort: (listof number) -> (listof number)
(define (merge-sort alon)
  (define (merge-all-neighbors-until-one lo-lons)
    (cond [(= (length lo-lons) 1) (car lo-lons)]
          [else
           (merge-all-neighbors-until-one
            (merge-all-neighbors lo-lons))]))
  (let [(lo-lons (make-singles alon))]
    (merge-all-neighbors-until-one
     lo-lons)))

;;; make-singles: (listof number) -> (listof (listof number))
;;; e.g. (equal? (make-singles (list 2 5 9 3))
;;;       (list (list 2) (list 5) (list 9) (list 3)))
(define (make-singles alon)
  (cond [(null? (cdr alon)) (list (list (car alon)))]
        [else
         (append
          (list (list (car alon)))
          (make-singles (cdr alon)))]))

;;; merge-all-neighbors: (listof (listof number)) -> (listof (listof number))
;;; e.g.
;; (equal? (merge-all-neighbors (list (list 2) (list 5) (list 9) (list 3)))
;;         (list (list 2 5) (list 3 9)))
;; (equal? (merge-all-neighbors (list (list 2 5) (list 3 9)))
;;         (list (list 2 3 5 9)))
(define (merge-all-neighbors lols)
  (cond [(null? lols) '()]              ;'() -> '()
        [(null? (cdr lols)) lols]       ;'(list (list 2)) -> (list (list 2))
        [else
         (append
          (list (merge (car lols) (cadr lols)))
          (merge-all-neighbors (cddr lols)))]))

;;; merge: (listof number) (listof number) -> (listof number)
;;; e.g.  (list 4 5) (list 1 2) -> (list 1 2 4 5)
(define (merge alon another-lon)
  (cond
   [(null? alon) another-lon]
   [(null? another-lon) alon]
   [else
    (if (> (car alon) (car another-lon))
        (append
         (list (car another-lon))
         (merge alon (cdr another-lon)))
        (append
         (list (car alon))
         (merge (cdr alon) another-lon)))]))
;; (merge (list 4 5) (list 1 2))
;; (merge (list 4 5) (list 1 2 7))
;; (equal? (merge-all-neighbors (list (list 2) (list 5) (list 9) (list 3) (list 4)))
;;         (list (list 2 5) (list 3 9) (list 4)))

;;; 26.2.1
(define (generative-recursive-fun problem)
  (cond
    [(empty? problem) (determine-solution problem)]
    [else
      (combine-solutions
	problem
	(generative-recursive-fun (rest problem)))]))

(define (determine-solution problem)
  0)

(define (combine-solutions problem rest-problem-solutions)
  (+ 1 rest-problem-solutions))


(define (compute-length-input alon)
  (cond
   [(null? alon) 0]
   [else
    (+ 1
       (compute-length-input (cdr alon)))]))
