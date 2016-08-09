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

;; Chapter 5: It's Full of Stars

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

(define member*
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
       (or (eq? a (car l))
           (member* a (cdr l))))
      (else (or (member* a (car l))
                (member* a (cdr l)))))))

(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2)) (= a1 a2))
      ((or  (number? a1) (number? a2)) #f)
      (else (eq? a1 a2)))))

(eqan? 2 3)
(eqan? 2 2)
(eqan? '(2 3) '(2 3))
(eqan? '() '())

(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2)) (eqan? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      (else
        (eqlist? s1 s2)))))

(define eqlist?
 (lambda (l1 l2)
  (cond
   ((and (null? l1) (null? l2)) #t)
   ((or (null? l1) (null? l2)) #f)
   (else
    (and (equal? (car l1) (car l2))
         (eqlist? (cdr l1) (cdr l2)))))))
