(require htdp/show-queen)
(define (show-n-queen n)
  (show-queen
   (let [(result (n-queens n))]
     (build-board n
                  (λ (x y)
                    (if (member (make-posn x y) result)
                        true
                        false)))
     )))
(show-n-queen 4)
(show-n-queen 5)

;;; ----------------------------------------

(define board4 (build-board 4 (lambda (i j) false)))
board4
(placement board4 4)

(define board8 (build-board 8 (lambda (i j) false)))
board8
(placement board8 8)


(placement/list (list (make-posn 0 0))
                board2
                8)
(find-open-spots board4)
