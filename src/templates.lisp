(defpackage lightning/templates
  (:use :cl)
  (:export #:add-template
           #:get-template
           #:list-templates
           #:remove-template))

(in-package lightning/templates)

(defun add-template (project name &key from)
  (let ((project (lightning/projects:get-project project)))
    (if from
        (uiop:copy-file from (merge-pathnames name (merge-pathnames "templates/" (getf project :path))))
        (open (merge-pathnames (merge-pathnames name "templates/") (lightning/utils:read-path (getf project :path))) :direction :probe :if-does-not-exist :create))))

(defun get-template (project name)
  (let ((project (lightning/projects:get-project project)))
    (merge-pathnames name (merge-pathnames "templates/" (getf project :path)))))

(defun list-templates (project)
  (let ((project (lightning/projects:get-project project)))
    (loop for template in (uiop:directory-files (merge-pathnames "templates/" (getf project :path))) collect (file-namestring template))))

(defun remove-template (project name)
  (let ((project (lightning/projects:get-project project)))
    (delete-file (merge-pathnames name (merge-pathnames "templates/" (getf project :path))))))
