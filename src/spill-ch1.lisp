(defpackage :spill-ch1
  (:use :cl :trivia :spill)
  (:import-from :named-readtables #:in-readtable)
  (:export #:interpret
           #:peval))

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

;;; The Partial Evaluator

(defun pe-neg (arg)
  (if (integerp arg)
      (- 0 arg)
      `(- ,arg)))

(defun pe-add (arg1 arg2)
  (cond ((and (integerp arg1)
              (integerp arg2))
         (+ arg1 arg2))
        ((integerp arg2)
         `(+ ,arg2 ,arg1))
        ((and (listp arg2)
              (eql '+ (first arg2)))
         `(+ ,(+ arg1 (second arg2)) ,(alexandria:last-elt arg2)))
        (t
         `(+ ,arg1 ,arg2))))

(defun pe-math (exp)
  (match exp
    ((guard exp (integerp exp)) exp)
    (`(read) '(read))
    (`(- ,e1) (pe-neg (pe-math e1)))
    (`(+ ,e1 ,e2) (pe-add (pe-math e1) (pe-math e2)))))

(defun peval (program)
  (match program
    (`(:program ,exp) (list :program (pe-math exp)))))
