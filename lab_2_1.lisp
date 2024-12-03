(defun remove-seconds (lst &optional (keep t))
  (cond
    ((null lst) nil)
    (keep (cons (car lst)
                (remove-seconds (cdr lst) nil)))
    (t (remove-seconds (cdr lst) t))))

(defun check-remove-seconds (name input expected)
  "Execute `remove-seconds` on `input`, compare result with `expected`, and print
comparison status"
  (format t "~:[FAILED~;passed~]... ~a~%"
          (equal (remove-seconds input) expected)
          name))

(defun test-remove-seconds ()
  "Run a set of tests for `remove-seconds`."
  (check-remove-seconds "test 1" '(1 2 a b 3 4 d) '(1 A 3 D))
  (check-remove-seconds "test 2" '(1 2 3 4 5 6) '(1 3 5))
  (check-remove-seconds "test 3" '() '())
  (check-remove-seconds "test 4" '(1) '(1))
  (check-remove-seconds "test 5" '(a b c) '(A C)))