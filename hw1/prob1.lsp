(defun prime (n)
    (cond
        ((<= n 3) T)
        ((equal 0 (mod n 2)) nil)
        (t
            (progn
            (loop for i from 2
                while (<= (* i i) n)
                do(progn
                    (if (equal 0 (mod n i))
                        (return-from prime nil)
                    )
                )
            )
            T)
        )
    )
)

(defun palindrome (list)
    (if (equal list (reverse list))
        T
        nil)
)

(defun fib1 (n)
    (if (< n 2)
        n
        (+ (fib1 (- n 1)) (fib1 (- n 2))))
)

(defun fib2 (n &optional (ans 0) (next_ans 1))
    (if (equal n 0)
        ans
        (fib2 (- n 1) next_ans (+ ans next_ans)))
)

(defun read-input ()
    (loop for input = (read-line)
        while (not (equal input ""))
        do(progn
            (format T "~A~%" input)
        )
    )
)
