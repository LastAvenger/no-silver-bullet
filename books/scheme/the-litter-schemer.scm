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

;; Chapter 5

;; l -> lat -> a list of atom

(define rember*
  (lambda (a l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? (car l) a) (rember* a (cdr l)))
         (else (cons (car l) (rember* a (cdr l))))))
      (else (cons (rember* a (car l))
                  (rember* a (cdr l)))))))

(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? (car l) old)
          (cons old (cons new (insertR* new old (cdr l)))))
         (else
           (cons (car l) (insertR* new old (cdr l))))))
      (else (cons (insertR* new old (car l))
                  (insertR* new old (cdr l)))))))
