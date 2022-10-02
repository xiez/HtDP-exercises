#lang scheme

;; ;; 28.2.1
;; (define board
;;   (list (list #t #t #t #t #t #t #t #t)
;;         (list #t #t #t #t #t #t #t #t)
;;         (list #t #t #t #t #t #t #t #t)
;;         (list #t #t #t #t #t #t #t #t)
;;         (list #t #t #t #t #t #t #t #t)
;;         (list #t #t #t #t #t #t #t #t)
;;         (list #t #t #t #t #t #t #t #t)
;;         (list #t #t #t #t #t #t #t #t)))

;; 28.2.2
(define (build-board n f)
  (build-list n
              (lambda (i) (build-list n (lambda (j) (f i j))))))

(define (board-dim board)
  (length (car board)))

;; board-ref : Board Nat Nat  ->  Boolean
;; to access a position with indices i, j on a-board
(define (board-ref a-board i j)
  ;; row-col-ref: (listof (i j)) N -> (i j)
  (define (row-col-ref a-row j)
    (cond
     [(= j 0) (car a-row)]
     [else
      (row-col-ref (cdr a-row ) (- j 1))]))  
  (cond
   [(= i 0) (row-col-ref (car a-board) j)]
   [else
    (board-ref (cdr a-board) (- i 1) j)]))

;; (define a-board
;;   (build-board 8 (lambda (i j) false)))

;; (define a-row '((5 0) (5 1) (5 2) (5 3) (5 4) (5 5) (5 6) (5 7)))
;; (row-col-ref a-row 1)
;; (board-ref a-board 0 0)
;; (check-expect (board-ref a-board 3 7) true)
;; (equal? (board-ref a-board 2 7) false)

;;; 28.2.4
(define-struct posn (x y) #:transparent)

;;; threatened?: (i j) (i j) -> boolean
(define (threatened? pos1 pos2)
  (or (= (posn-x pos1) (posn-x pos2))
      (= (posn-y pos1) (posn-y pos2))
      (= (- (posn-x pos1) (posn-y pos1))
         (- (posn-x pos2) (posn-y pos2)))
      (= (+ (posn-x pos1) (posn-y pos1))
         (+ (posn-x pos2) (posn-y pos2)))))

;; add-queen : Board Posn -> Board
;; add a queen to the board at p and also flip all threatened positions to true
(define (add-queen board p)
  (build-board (board-dim board)
               (lambda (x y)
                 (or (threatened? (make-posn x y) p)
                     (board-ref board x y)))))    

;; find-open-spots : Board -> (Listof Posn)
;; to find the unoccupied positions in the board
(define (find-open-spots board)
  (define (traverse-board n)
    (define (traverse-row j)
      ;; (printf "(traverse-row n:~s j:~s)~n" n j)
      (cond
       [(zero? j) '()]
       [else (cond
              [(not (board-ref board (sub1 n) (sub1 j))) ;not occupied
               (cons (make-posn (sub1 n) (sub1 j))
                     (traverse-row (sub1 j)))]
              [else (traverse-row (sub1 j))])]))
    ;; (printf "(traverse-board ~s)~n" n)
    (cond
     [(zero? n) '()]
     [else
      (append (traverse-row (board-dim board))
              (traverse-board (sub1 n)))]))
  (traverse-board (board-dim board)))

;;; driver code to find one n-queens solution
(define (n-queens n)
  (let [(result '())
        (num-of-queens n)]

    ;; placement : Board Nat -> board or false
    ;; places n queens on a-board. if possible, returns
    ;; the board. otherwise, returns false
    (define (placement a-board n)
      (cond
       [(zero? n) a-board]
       [else
        (let [(possible-places (find-open-spots a-board))]
          ;; (printf "possible-places: ~s, n: ~s ~n" possible-places n)
          (placement/list possible-places a-board n)]))

    ;; placement/list : (Listof Posn) Board Nat -> board or false
    ;; tries to place n queens in all of the boards. As soon as
    ;; one of them works out, it returns that one. If none
    ;; work out, returns false.
    (define (placement/list possible a-board n)
      (cond
       [(null? possible) false]
       [else (let [(possible-posn (car possible))]
               ;; (printf "possible position: ~s ~n" possible-posn)
               (let* [(new-board (add-queen a-board possible-posn))
                      (c (placement new-board (sub1 n)))]
                 (cond
                  [(boolean? c)
                   ;; (printf " put queen at position ~s yield deadend, backtracking.. ~n" possible-posn)
                   (placement/list (cdr possible) a-board n)]
                  [else
                   ;; (printf " it's ok to put queen at position ~s ~n" possible-posn)
                   (set! result (cons possible-posn result))
                   c])
                 ))]))

    (define board-n (build-board n (λ (i j) false)))
    (placement board-n n)

    ;; show the result
    (printf "==> result: ~s ~n" result)
    result
    ))

;;; driver code to find all n-queens solutions
;; (define (all-n-queens n)
;;   (let [(results '())
;;         (num-of-queens n)]
;;     ;; placement : Board Nat -> board or false
;;     ;; places n queens on a-board. if possible, returns
;;     ;; the board. otherwise, returns false
;;     (define (placement a-board n)
;;       (cond
;;        [(zero? n) a-board]
;;        [else
;;         (let [(possible-places (find-open-spots a-board))]
;;           ;; (printf "possible-places: ~s, n: ~s ~n" possible-places n)
;;           (placement/list possible-places a-board n))]))
;;     ;; placement/list : (Listof Posn) Board Nat -> board or false
;;     ;; tries to place n queens in all of the boards. As soon as
;;     ;; one of them works out, it returns that one. If none
;;     ;; work out, returns false.
;;     (define (placement/list possible a-board n)
;;       (cond
;;        [(null? possible) false]
;;        [else (let [(possible-posn (car possible))]
;;                (printf "possible position: ~s ~n" possible-posn)
;;                (set! results (cons possible-posn results))
;;                (let* [(new-board (add-queen a-board possible-posn))
;;                       (c (placement new-board (sub1 n)))]
;;                  (cond
;;                   [(boolean? c)
;;                    (printf " put queen at position ~s yield deadend, backtracking.. ~n" possible-posn)
;;                    (set! results (cdr results))
;;                    (placement/list (cdr possible) a-board n)]
;;                   [else
;;                    (printf " it's ok to put queen at position ~s ~n" possible-posn)
;;                    (if (= (length results) num-of-queens)
;;                        (begin
;;                          (printf "==> results: ~s ~n" results)
;;                          (set! results (cdr results))
;;                          (printf "possible after results: ~s ~n" (cdr possible) )
;;                          ;; (placement/list (cdr possible) a-board n)
;;                          )
;;                        false)
;;                    c])
;;                  ))]))
;;     (define board-n (build-board n (λ (i j) false)))
;;     (placement board-n n)))

