(defpackage lightning/projects
  (:use :cl)
  (:export #:create
           #:project
           #:make-project
           #:make-template
           #:make-page
           #:name
           #:path
           #:pages
           #:templates))

(in-package lightning/projects)

(defclass component ()
  ((name      :initarg :name      :initform (error "Must provide a name") :reader name)))

(defclass project (component)
  ((path      :initarg :path      :initform (error "Must provide a path") :reader path)
   (pages     :initarg :pages     :initform '()                           :reader pages)
   (templates :initarg :templates :initform '()                           :reader templates)))

(defclass template (component)
  ())

(defclass page (component)
  ())

(defgeneric rm (object)
  (:documentation "Removes an item"))

(defmethod rm ((project project))
  (format nil "Removing project: ~A" (name project)))

(defmethod rm ((template template))
  (format nil "Removing template: ~A" (name template)))

(defmethod rm ((page page))
  (format nil "Removing page: ~A" (name page)))

(defgeneric create (object &rest args)
  (:documentation "Creates an item"))

(defmethod create ((project project) &rest args)
  (format t "Creating project: ~A~%" (name project)))

(defmethod create ((template template) &rest args)
  (format t "Creating template: ~A~%" (name template)))

(defmethod create ((page page) &rest args)
  (format t "Creating page: ~A~%" (name page)))

(defun make-project (name path templates pages)
  (make-instance 'project :name name :path path :templates templates :pages pages))

(defun make-template (name)
  (make-instance 'template :name name))

(defun make-page (name)
  (make-instance 'page :name name))
