; Q1
(define (compose-all funcs)
  (define (helper arg)
    (if (null? funcs)
        arg
        (let ((func (car funcs))
              (rest (cdr funcs)))
             (set! funcs rest)
             (helper (func arg))
        )
    )
  )
  helper
)



; Q2
(define (tail-replicate x n)
	(define (helper x n current)
		(if (= n 0) 
			current
			(helper x (- n 1) (cons x current))
			)
		)
	(helper x n nil)
)
