(defpackage :spill-ch1
  (:use :cl :trivia :spill)
  (:import-from :named-readtables #:in-readtable)
  (:export #:interpret
           #:pe-compile))

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
  (if (and (integerp arg1)
           (integerp arg2))
      (+ arg1 arg2)
      `(+ ,arg1 ,arg2)))

(defun peval (exp)
  (match exp
    ((guard exp (integerp exp)) exp)
    (`(read) '(read))
    (`(- ,e1) (pe-neg (peval e1)))
    (`(+ ,e1 ,e2) (pe-add (peval e1) (peval e2)))))

(defun pe-compile (program)
  (match program
    (`(:program ,exp) (list :program (peval exp)))))
