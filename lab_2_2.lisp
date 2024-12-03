(defun contains (item lst)
  (cond
    ((null lst) nil)                
    ((eql item (car lst)) t)        
    (t (contains item (cdr lst))))) 

(defun list-set-symmetric-difference (lst1 lst2)
  (cond
    ((null lst1) lst2)             
    ((null lst2) lst1)              
    ((contains (car lst1) lst2)    
     (list-set-symmetric-difference (cdr lst1) (remove (car lst1) lst2))) 
    (t (cons (car lst1) (list-set-symmetric-difference (cdr lst1) lst2))))) 

(defun check-symmetric-difference (name input1 input2 expected)
  "Execute `list-set-symmetric-difference` on input lists, compare result with expected, and print status."
  (format t "~:[FAILED~;passed~]... ~a~%"
          (equal (list-set-symmetric-difference input1 input2) expected)
          name))

(defun test-list-set-symmetric-difference ()
  "Run tests for `list-set-symmetric-difference`."
  (check-symmetric-difference "test 1" '(1 2 3 4) '(3 4 5 6) '(1 2 5 6))
  (check-symmetric-difference "test 2" '(a b c) '(c d e) '(a b d e))
  (check-symmetric-difference "test 3" '(1 2 3) nil '(1 2 3))
  (check-symmetric-difference "test 4" nil '(1 2 3) '(1 2 3))
  (check-symmetric-difference "test 5" nil nil nil))
