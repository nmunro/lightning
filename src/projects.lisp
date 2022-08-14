(defpackage lightning/projects
  (:use :cl)
  (:export #:make
           #:get-project))

(in-package lightning/projects)

(defclass project ()
  ((name :initarg :name :initform (error "Must provide a name") :reader name)
   (path :initarg :path :initform (error "Must provide a path") :reader path)))

(defun make (action &key name path to)
  (cond
    ((and (eq action :create) name path)
     (add-project name path))

    ((and (eq action :delete) name)
     (remove-project name))

    ((eq action :list)
     (list-projects))

    ((eq action :get)
     (get-project name))

    ((and (eq action :rename) name to)
     (rename-project name to))

    ((and (eq action :change-path) name to)
     (change-path-project name to))

    (t
     (error "Invalid arguments"))))

(defun make-project (name path &key templates pages)
  `(:name ,name :path ,path))

(defun find-project (name project)
  (string= (string-downcase name) (string-downcase (getf project :name))))

(defun get-project (name &key config)
  (let ((config (or config (lightning/config:load-config))))
    (find name (getf config :projects) :test #'find-project)))

(defun add-project (name path)
  (let ((config (lightning/config:load-config)))
    (if (find name (getf config :projects) :test #'find-project)
        (error (format nil "Project \"~A\" already exists" name))
        (let ((project (make-project name (uiop:native-namestring path))))
            (push project (getf config :projects))
            (lightning/config:save-config config)

            ; Create directories
            (ensure-directories-exist path)
            (ensure-directories-exist (merge-pathnames "templates/" path))
            (ensure-directories-exist (merge-pathnames "pages/" path))

            ; Create an index.html file
            (with-open-file (index (merge-pathnames "index.html" path) :direction :output :if-exists :supersede :if-does-not-exist :create)
                (format index "<html>~%")
                (format index "    <head><title>Index</title></head>~%")
                (format index "    <body>~%")
                (format index "        <h1>Index</h1>~%")
                (format index "    </body>~%")
                (format index "</html>~%"))))))

(defun list-projects ()
  (let ((config (lightning/config:load-config)))
    (loop for project in (getf config :projects) collect (getf project :name))))

(defun remove-project (name)
  (let ((config (lightning/config:load-config)))
    (if (find name (getf config :projects) :test #'find-project)
        (let* ((project (get-project name :config config))
               (path (lightning/utils:read-path (getf project :path))))
            (uiop:delete-directory-tree path :validate t)
            (setf (getf config :projects) (remove name (getf config :projects) :test #'find-project))
            (lightning/config:save-config config))
        (error (format nil "Project \"~A\" does not exist" name)))))

(defun rename-project (name to)
  (let* ((config (lightning/config:load-config))
         (project (get-project name :config config)))
    (setf (getf project :name) to)
    (lightning/config:save-config config)))

(defun change-path-project (name to)
  (let* ((config (lightning/config:load-config))
         (project (get-project name :config config)))
    (setf (getf project :path) to)
    (lightning/config:save-config config)))
