(defpackage lightning
  (:use :cl)
  (:export #:main))

(in-package lightning)

(defun create (&key (project nil projectp) (path nil pathp) (template nil templatep) (page nil pagep))
  (let ((config (lightning/config:load-config)))
    (cond
      ;; Create template from existing file
      ((and projectp templatep pathp)
       (let ((template (lightning/projects:make-template template)))
         (lightning/projects:create template "")))

      ;; Create page from file
      ((and projectp pagep pathp)
       (let ((page (lightning/projects:make-page page)))
         (lightning/projects:create page "")))

      ;; Create page from template
      ((and projectp pagep templatep)
       (let ((page (lightning/projects:make-page page)))
         (lightning/projects:create page "")))

      ;; Create page
      ((and projectp pagep)
       (let ((page (lightning/projects:make-page page)))
         (lightning/projects:create page "")))

      ;; Create template
      ((and projectp templatep)
       (let ((template (lightning/projects:make-template template)))
         (lightning/projects:create template "")))

      ;; Create project
      ((and projectp pathp)
       (let ((project (lightning/projects:make-project project path template page)))
         (lightning/projects:create project "")))

      ;; error
      (t
       (error "Invalid arguments")))))

(create :project "nmunro" :path #p"~/dev/nmunro")

(create :project "nmunro" :template "base.html")

(create :project "nmunro" :template "base.html" :path #p"~/dev/nmunro/base.html")

(create :project "nmunro" :page "blog.html")

(create :project "nmunro" :page "blog.html" :template "base.html")

(create :project "nmunro" :page "blog.html" :path #p"~/dev/nmunro")
