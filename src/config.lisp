(defpackage lightning/config
  (:use :cl)
  (:export #:config
           #:make-config
           #:load-config
           #:save-config
           #:path
           #:projects))

(in-package lightning/config)

(defclass config ()
  ((path     :initarg :path     :initform #p"~/.config/lightning/config.lisp" :reader   path)
   (projects :initarg :projects :initform '()                                 :accessor projects)))

(defun make-config (&key (projects nil projectsp))
  (make-instance 'config :projects projects))

(defun load-config ()
  (let ((config (make-config)))
    (unless (probe-file (path config))
      (save-config config))

    (with-open-file (file (path config) :direction :input :if-does-not-exist :create)
      (let ((data (read file)))
        (make-config :projects
                     (loop for project in (getf data :projects)
                           collect (lightning/projects:make-project
                                    (getf project :name)
                                    (getf project :path)
                                    '()
                                    '())))))))

(defun save-config (config)
  (with-open-file (file (path config) :direction :output :if-does-not-exist :create)
    (format file "~A" `(:projects ,(projects config)))))
