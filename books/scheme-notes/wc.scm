;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   wc.scm
;;;   a scheme word-count program
;;;
;;;    by T.Shido
;;;    on August 19, 2005
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (list->symbol ls0)
  (string->symbol (list->string (reverse! ls0))))

(define (char-in c . ls)
  (let loop((ls0 ls))
    (if (null? ls0)
        #f
      (or (char=? c (car ls0))
          (loop (cdr ls0))))))

(define (read-words fname)
  (with-input-from-file fname
    (lambda ()
      (let loop((w '()) (wls '()))
        (let ((c (read-char)))
      (cond
       ((eof-object? c)
            (reverse! (if (pair? w)
                          (cons (list->symbol w) wls)
                        wls)))
       ((char-in c #\Space #\Linefeed #\Tab #\, #\.  #\ #\( #\) #\= #\? #\! #\; #\:)
            (loop '() (if (pair? w)
                          (cons (list->symbol w) wls)
                        wls)))
       (else
        (loop (cons (char-downcase c) w) wls))))))))

(define (sort-by-frequency al)
  (sort al (lambda (x y) (> (cdr x) (cdr y)))))

(define (wc fname)
  (let ((wh (make-eq-hash-table)))
    (let loop((ls (read-words fname)))
      (if (null? ls)
          (sort-by-frequency (hash-table->alist wh))
        (begin
         (hash-table/put! wh (car ls) (1+ (hash-table/get wh (car ls) 0)))
         (loop (cdr ls)))))))
