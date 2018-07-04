#|
  This file is a part of spill project.
  Copyright (c) 2018 Brit Butler (brit@kingcons.io)
|#

#|
  Author: Brit Butler (brit@kingcons.io)
|#

(defsystem "spill"
  :version "0.1.0"
  :author "Brit Butler"
  :license "LLGPL"
  :depends-on ("alexandria"
               "trivia")
  :components ((:module "src"
                :components
                ((:file "spill"))))
  :description "Simple Pedagogical Implementation of a Little Lisp"
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "spill-test"))))
