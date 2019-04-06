;;; file : fib.lsp

(defun fib (n)
	(if (< n 2)
		n
		(+ (fib(- n 1)) (fib(- n 2)))
	)
)

(format T "ans = ~D~%" (fib 20))
