(defun cmp (x y)
	(cond
		((= x y) "is-equal")
		((< x y) "is-smaller")
		((> x y) "is-grater")
	)
)

(format T "~A~%" (cmp 7 4))
