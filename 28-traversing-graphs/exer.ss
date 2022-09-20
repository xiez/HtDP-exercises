;;; 28.1.1
(define graph
  (list (list 'A (list 'B 'E))
        (list 'B (list 'E 'F))
        (list 'C (list 'D))
        (list 'D (list))
        (list 'E (list 'C 'F))
        (list 'F (list 'D 'G))
        (list 'G (list))))

;;; 28.1.2
(define (neighbors n g)
  (define (node-match? n a-node)
    (eq? n (car a-node)))
  (cond ((null? g) '())
        ((node-match? n (car g)) (cadr (car g)))
        (else (neighbors n (cdr g)))))

(define (find-route/list lo-Os D G)
  ;; find-route/list : (listof node) node graph  ->  (listof node) or false
  ;; to create a path from some node on lo-originations to destination
  ;; if there is no path, the function produces false
  (cond
   ((null? lo-Os) false)
   (else (let ((possible-route (find-route (car lo-Os) D G)))
           (cond
            ((boolean? possible-route) (find-route/list (cdr lo-Os) D G))
            (else possible-route))))))


(define (find-route origination destination G)
  ;; find-route : node node graph  ->  (listof node) or false
  ;; to create a path from origination to destination in G
  ;; if there is no path, the function produces false
  (cond
   ((eq? origination destination) (list destination))
   (else
    (let ((possible-route
           (find-route/list (neighbors origination G) destination G)))
      (cond
       ((boolean? possible-route) false)
       (else (cons origination possible-route)))))))


;;; 28.1.3
(find-route
 'A 'G graph)

(find-route
 'C 'G graph)

;;; 28.1.4

(define (test-on-all-nodes G)
  (let ((all-nodes (map car G)))
    (map (lambda (a-node)
           (map (lambda (another-node)
                  (list a-node another-node
                        (find-route a-node another-node G)))
                all-nodes))
         all-nodes)))

(test-on-all-nodes graph)
