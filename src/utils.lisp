(defpackage lightning/utils
  (:use :cl)
  (:export #:read-path))

(in-package lightning/utils)

(defun read-path (path)
  (make-pathname :directory (subseq path 1 (- (length path) 1))))
