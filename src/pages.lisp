(defpackage lightning/pages
  (:use :cl)
  (:export #:add-page
           #:get-page
           #:list-pages
           #:remove-page))

(in-package lightning/pages)

(defun add-page (project name &key from)
  (let ((project (lightning/projects:get-project project)))
    (if from
        (uiop:copy-file from (merge-pathnames name (merge-pathnames "pages/" (getf project :path))))
        (open (merge-pathnames (merge-pathnames name "pages/") (lightning/utils:read-path (getf project :path))) :direction :probe :if-does-not-exist :create))))

(defun get-page (project name)
  (let ((project (lightning/projects:get-project project)))
    (merge-pathnames name (merge-pathnames "pages/" (getf project :path)))))

(defun list-pages (project)
  (let ((project (lightning/projects:get-project project)))
    (loop for template in (uiop:directory-files (merge-pathnames "pages/" (getf project :path))) collect (file-namestring template))))

(defun remove-page (project name)
  (let ((project (lightning/projects:get-project project)))
    (delete-file (merge-pathnames name (merge-pathnames "pages/" (getf project :path))))))
