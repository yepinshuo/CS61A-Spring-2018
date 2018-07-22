(define (find s predicate)
  (if (null? s) #f
  	(if (predicate (car s))
  		(car s)
  		(find (cdr-stream s) predicate)))
)

(define (scale-stream s k)
  (cons-stream (* k (car s)) (scale-stream (cdr-stream s) k))
)

(define (has-cycle s)
  (define (cycle-tracker so-far cur)
  	(cond ((null? cur) #f) 
  		  ((contains so-far cur) #t)
  		  (else (cycle-tracker (cons cur so-far) (cdr-stream cur)))))
  (define (contains lst s)
  	(cond ((null? lst) #f)
  		  ((eq? s (car lst)) #t)
  		  (else (contains (cdr lst) s))))
  (cycle-tracker nil s)
)

(define (has-cycle-constant s)
  'YOUR-CODE-HERE
)
