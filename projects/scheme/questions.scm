(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (map (lambda (rest) (cons first rest)) rests)
)


(define (zip pairs)
  (list (map car pairs) (map cadr pairs)))

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
    ; BEGIN PROBLEM 17
    (define (helper s index)
        (if (pair? s)
            (cons (list index (car s)) (helper (cdr s) (+ index 1)))
            nil
        )
    )
    (helper s 0)
)
  ; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  (define (helper total cur_denoms cur_lst)
        (cond
            ((< total 0) nil)               ; if total goes below zero, it is not a valid partition
            ((= total 0) (list cur_lst))    ; if total goes to zero, it is a valid partition
            ((not (pair? cur_denoms)) nil)  ; if it reaches the end of denominator list, it is not a valid partition
            (else
                ; either subtract this denominator from the total or proceed to next denominator
                (append (helper (- total (car cur_denoms)) cur_denoms (append cur_lst (cons (car cur_denoms) nil)))
                    (helper total (cdr cur_denoms) cur_lst))
            )
        )
    )
    (helper total denoms nil)
)
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons form (cons params (let-to-lambda body)))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons (cons 'lambda (cons (car (zip (let-to-lambda values))) (let-to-lambda body)))
               (cadr (zip (let-to-lambda values))))
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (map let-to-lambda expr)
         ; END PROBLEM 19
         )))
