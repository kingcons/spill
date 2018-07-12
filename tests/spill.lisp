(defpackage spill-test
  (:use :cl
        :spill
        :prove))

(in-package :spill-test)

;; NOTE: To run this test file, execute `(asdf:test-system :spill)' in your Lisp.

(plan 4)

(defun interpret-l0 (form)
  (spill-ch1:interpret form))

(defun compile-l0 (form)
  (spill-ch1:interpret (spill-ch1:pe-compile form)))

(defun header (form)
  (list :program form))

(is (interpret-l0 (read-program "tests/test2.lang0")) 42)


(let ((form1 '(+ (read) (- (+ 5 3))))
      (form2 '(+ 1 (+ (read) 1)))
      (form3 '(- (+ (read) (- 5)))))
  (loop for form in (list form1 form2 form3)
        do (let ((program (header form)))
             (is (interpret-l0 program) (compile-l0 program)))))

(finalize)
