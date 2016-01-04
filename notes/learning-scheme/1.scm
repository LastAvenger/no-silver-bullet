(define (myabs x) (if (< x 0) (- x)  x))

(define (reciprocal x) 
  (if (= x 0) #f (/ 1 x)))

(define (int->chr x)
  (if (or (< x 33) (> x 126)) 
    #f
    (integer->char x)))

; Quadratic equation
(define (quadratic-equation a b c)
  (if (zero? a) 'error
    ; Discriminant
    (let ((e (/ (- b) (* 2 a))) 
          (d (- (* b b) (* 4 a c))))
      (cond ((< d 0) 'error)
            ((= d 0) e)
            (else (let ((f (/ (sqrt d) a 2)))
                    (cons (- e f) (+ e f))))))))

(define (fibo x)
  (cond ((= x 0) 0)
        ((= x 1) 1)
        ((= x 2) 2)
        (else (+ (fibo (- x 1)) (fibo (- x 2))))))

(define (sum xs) 
  (if (null? xs) 0
  (+ (car xs) (sum (cdr xs)))))

(define (sum-letrec xs)
  (letrec ((sum1 (lambda (xs1)
                  (if (null? xs1) 0
                    (+ (car xs1) (sum (cdr xs1)))))))
    (sum1 xs)))
