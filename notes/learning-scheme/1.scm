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

(define (myfilter f xs) 
  (if (null? xs) '()
    (if (f (car xs)) 
      (cons (car xs) (myfilter f (cdr xs)))
      (myfilter f (cdr xs))
    )))

; test myfilter
(myfilter (lambda (x) (> x 1)) '(1 2 3 8 1))

(define (mymap f xs)
  (if (null? xs) 
    '()
    (cons (f (car xs)) (mymap f (cdr xs)))
    ))

; test mymap
(mymap sub1 '(343 34 45))

(define (kitten fname)
  (let ((fp (open-input-file fname)))
    (let loop ((chr (read-char fp)))
      (if (eof-object? chr) 
        (close-input-port fp)
        (begin
          (display chr)
        (loop (read-char fp)))))))

(define (read-lines fname)
  (with-input-from-file fname
    (lambda ()
      (let loop ((line '()) (lines '()) (c (read-char)))
        (if (eof-object? c)
          (reverse lines)
        (if (char=? c #\linefeed)
          (loop '() (cons (list->string (reverse line)) lines) (read-char))
          (loop (cons c line) lines (read-char)))
        )))))

(define (copy-file src dst)
  (let ((i (open-input-file src))
        (o (open-output-file dst)))
    (let loop ((c (read-char i)))
      (if (eof-object? c)
        (begin
          (close-input-port i)
          (close-output-port o))
        (begin
          (write-char c o)
          (loop (read-char i)))))))
