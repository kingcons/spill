(defpackage :spill-ch1
  (:use :cl :trivia :spill)
  (:import-from :named-readtables #:in-readtable)
  (:export #:interpret))

(in-package :spill-ch1)

(in-readtable :fare-quasiquote)

(defun read-integer ()
  (let ((result (read)))
    (if (integerp result)
        result
        (error 'type-error :expected-type 'integer :datum result))))

(defun interpret (program)
  (labels ((evaluate (exp)
             (match exp
               ((guard exp (integerp exp)) exp)
               (`(read) (read-integer))
               (`(- ,e1) (- 0 (evaluate e1)))
               (`(+ ,e1 ,e2) (+ (evaluate e1) (evaluate e2))))))
    (match program
      (`(:program ,exp) (evaluate exp)))))
