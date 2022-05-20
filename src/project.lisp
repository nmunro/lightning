(defpackage lightning/project
  (:use :cl)
  (:export #:config))

(in-package lightning/project)

(defclass project ()
  ((name :initarg :name :initform (error "Must provide a name") :reader name)
   (path :initarg :path :initform (error "Must provide a path") :reader path)))

(defun make-project (name path)
  (make-instance 'project :name name :path path))
