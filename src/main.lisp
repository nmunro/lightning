(defpackage lightning
  (:use :cl)
  (:export #:main))

(in-package lightning)

(defun strike (action project &key (path nil pathp) (template nil templatep) (page nil pagep))
  (let ((config (lightning/config:load-config)))
    (cond
      ;; Create page from template
      ((and pagep templatep)
       (lightning/projects:page action project page :template template))

      ;; Create page from file
      ((and pagep pathp)
       (lightning/projects:page action project page :path path))

      ;; Create template from existing file
      ((and templatep pathp)
       (lightning/projects:template action project template :path path))

      ;; Create template
      ((and templatep)
       (lightning/projects:template action project template :path path))

      ;; Create page
      ((and pagep)
       (lightning/projects:page action project page))

      ;; Create project
      ((and pathp)
       (lightning/projects:project action project :path path))

      (project
       (lightning/projects:project action project))

      ;; error
      (t
       (error "Invalid arguments")))))

(strike :create "nmunro" :path #p"~/dev/nmunro-tmp/") ; Remember to use a trailing '/'!
(strike :create "nmunro" :template "base.html")
(strike :create "nmunro" :template "base.html" :path #p"~/dev/nmunro/base.html")
(strike :create "nmunro" :page "blog.html")
(strike :create "nmunro" :page "blog.html" :template "base.html")
(strike :create "nmunro" :page "blog.html" :path #p"~/dev/nmunro/tmp.html")

(strike :delete "nmunro")
(strike :delete "nmunro" :template "base.html")
(strike :delete "nmunro" :page "blog.html")
