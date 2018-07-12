(defpackage spill
  (:use :cl)
  (:export #:read-program))

(in-package :spill)

(defun asset-path (namestring)
  (asdf:system-relative-pathname :spill namestring))

(defun read-program (filename)
  (let ((file (asset-path filename)))
    (assert (probe-file file))
    (with-open-file (in file)
      (list :program (read in)))))
