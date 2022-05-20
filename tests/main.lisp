(defpackage lightning/tests/main
  (:use :cl
        :lightning
        :rove))
(in-package :lightning/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :lightning)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
  (format t "Testing~%")
    (ok (= 1 1))))