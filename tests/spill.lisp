(defpackage spill-test
  (:use :cl
        :spill
        :prove))

(in-package :spill-test)

;; NOTE: To run this test file, execute `(asdf:test-system :spill)' in your Lisp.

(plan 1)

(is (spill-ch1:interpret (read-program "tests/test2.lang0")) 42)

(finalize)
