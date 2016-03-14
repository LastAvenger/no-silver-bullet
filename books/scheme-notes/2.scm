;; <<The Little Schemer>>

(define myatom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(define (lat xs)
  (cond
    ((null? xs) #t)
    ((atom? (car xs)) (lat (cdr xs)))
    (else #f)))

(define (rember a lat)
  (cond
    ((null? lat) '())
    ((eq? a (car lat)) (cdr lat))
    (else (cons (car lat) (rember (cdr lat))))))
