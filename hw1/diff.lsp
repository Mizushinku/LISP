(defun find_lcs (list1 list2)
	;;recursively find LCS, not sure about memory & efficiency issue for large text
	(cond
		((null list1) nil)
		((null list2) nil)
		((equal (first list1) (first list2))
			(cons (first list1) (find_lcs (rest list1) (rest list2)))
		)
		(t
			(let ((lcs_x (find_lcs list1 (rest list2)))
				  (lcs_y (find_lcs (rest list1) list2)))
				(if (> (length lcs_x) (length lcs_y))
					lcs_x
					;;else
					lcs_y
				)
			)
		)
	)
)

(defun diff (path1 path2)
	(let (list1 list2)
		(with-open-file (file1 path1 :direction :input)
			(loop for line = (read-line file1 nil)
				while line
				do (progn 
					(push line list1))
			)
			;; there are some problems with 'nreverse'
			(setq list1 (reverse list1))
		)
		(with-open-file (file2 path2 :direction :input)
			(loop for line = (read-line file2 nil)
				while line
				do (progn 
					(push line list2))
			)
			(setq list2 (reverse list2))
		)

		(let ((lcs (find_lcs list1 list2)))
			(dolist (sl lcs)
				(let* ((index1 (position sl list1 :test #'equal))
					   (index2 (position sl list2 :test #'equal))
					   (red_lines (subseq list1 0 index1))
					   (green_lines (subseq list2 0 index2)))
					(setq list1 (subseq list1 (1+ index1)))
					(setq list2 (subseq list2 (1+ index2)))

					(when red_lines
						(dolist (str red_lines)
							(format T "~c[31m-~A~c[0m~%" #\ESC str #\ESC)))
					(when green_lines
						(dolist (str green_lines)
							(format T "~c[32m+~A~c[0m~%" #\ESC str #\ESC)))
					(format T "~A~%" sl)
				)
			)
			(when list1
				(dolist (str list1)
					(format T "~c[31m-~A~c[0m~%" #\ESC str #\ESC)))
			(when list2
				(dolist (str list2)
					(format T "~c[32m+~A~c[0m~%" #\ESC str #\ESC)))
		)
	)
)

(diff "./file1.txt" "./file2.txt")
