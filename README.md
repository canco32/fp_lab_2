<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><strong>Студент:</strong> <i>Сілін Ілля Денисович КВ-12</i><p>
<p align="right"><strong>Рік:</strong> <i>2024</i><p>

  ## Загальне завдання
  
Реалізуйте дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком(-ами), за
можливості/необхідності використовуючи різні види рекурсії. Функції, які необхідно
реалізувати, задаються варіантом (п. 2.1.1). Вимоги до функцій:
1. Зміна списку згідно із завданням має відбуватись за рахунок конструювання нового
списку, а не зміни наявного (вхідного).
2. Не допускається використання функцій вищого порядку чи стандартних функцій
для роботи зі списками, що не наведені в четвертому розділі навчального
посібника.
3. Реалізована функція не має бути функцією вищого порядку, тобто приймати функції
в якості аргументів.
4. Не допускається використання псевдофункцій (деструктивного підходу).
5. Не допускається використання циклів.
_Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
мають бути оформленні у вигляді модульних тестів_


## Варіант 5

1. Написати функцію ```remove-seconds```, яка видаляє зі списку кожен другий елемент:
   
   ```
   CL-USER> (remove-seconds '(1 2 a b 3 4 d))
   (1 A 3 D)
   ```
2. Написати функцію ```list-set-symmetric-difference```, яка визначає симетричну різницю двох множин, заданих списками атомів (тобто, множину елементів, що не входять до обох множин):
   
    ```
    CL-USER> (list-set-symmetric-difference '(1 2 3 4) '(3 4 5 6))
    (1 2 5 6) ; порядок може відрізнятись
    ```

## Лістинг функції ```remove-seconds```

```
(defun remove-seconds (lst &optional (keep t))
  (cond
    ((null lst) nil)
    (keep (cons (car lst)
                (remove-seconds (cdr lst) nil)))
    (t (remove-seconds (cdr lst) t))))
```

### Тестові набори
      
```
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

```
### Тестування
```
CL-USER> (test-remove-seconds)
passed... test 1
passed... test 2
passed... test 3
passed... test 4
passed... test 5
NIL
```
## Лістинг функції ```list-set-symmetric-difference```

```
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

```

### Тестові набори

```
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

```

### Тестування

```
CL-USER> (test-list-set-symmetric-difference)
passed... test 1
passed... test 2
passed... test 3
passed... test 4
passed... test 5
NIL
```
