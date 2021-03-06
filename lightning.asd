(defsystem "lightning"
  :version "0.0.1"
  :author "nmunro"
  :license "BSD3-Clause"
  :depends-on ("rove"
               "jonathan")
  :components ((:module "src"
                :components
                ((:file "config")
                 (:file "utils")
                 (:file "projects")
                 (:file "templates")
                 (:file "pages")
                 (:file "main"))))
  :description "Generate a skeleton for modern project"
  :in-order-to ((test-op (test-op "lightning/tests"))))

(defsystem "lightning/tests"
  :author "nmunro"
  :license "BSD3-Clause"
  :depends-on ("lightning"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for lightning"
  :perform (test-op (op c) (symbol-call :rove :run c)))
