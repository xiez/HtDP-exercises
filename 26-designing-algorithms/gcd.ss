;; gcd-structural : N[>= 1] N[>= 1]  ->  N
;; to find the greatest common divisior of n and m
;; structural recursion using data definition of N[>= 1] 
(define (gcd-structural n m)
  (local ((define (first-divisior-<= i)
	    (cond
	      [(= i 1) 1]
	      [else (cond
		      [(and (= (remainder n i) 0) 
			    (= (remainder m i) 0))
		       i]
		      [else (first-divisior-<= (- i 1))])])))
    (first-divisior-<= (min m n))))

(define (gcd-gernerative n m)
  (define (clever-gcd larger smaller)
    (cond
     [(= smaller 0) larger]
     [else (clever-gcd smaller (remainder larger smaller))]))
  (clever-gcd (max m n) (min m n)))

;; 26.3.2
;; 1. What is a trivially solvable problem?
;; A:

;; 2. What is a corresponding solution?
;;; A: stop and return true

;; 3. How do we generate new problems that are more easily solvable than the original problem? Is there one new problem that we generate or are there several?
;;; A: If the ball is still inside the boundaries, two things must happen. First, the ball must be drawn and cleared from the canvas. Second, the ball must be moved, and then we must do things all over again.

;; 4.Is the solution of the given problem the same as the solution of (one of) the new problems? Or, do we need to combine the solutions to create a solution for the original problem? And, if so, do we need anything from the original problem data?
;; A: YES
