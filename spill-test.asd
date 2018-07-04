#|
  This file is a part of spill project.
  Copyright (c) 2018 Brit Butler (brit@kingcons.io)
|#

(defsystem "spill-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Brit Butler"
  :license "LLGPL"
  :depends-on ("spill"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "spill"))))
  :description "Test system for spill"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
