(defpackage lightning
  (:use :cl)
  (:export #:strike))

(in-package lightning)

;; @TODO: Put jonathan and markdown.cl into the asd file

(defun strike (action &rest args)
  (cond
    ((eq action :project)
     (apply #'lightning/project:make args))

    ((eq action :template)
     (apply #'lightning/templates:make args))

    ((eq action :page)
     (apply #'lightning/pages:make args))

    (t
     (error (format nil "Invalid Option: ~A" action)))))

(strike :project :create :name "nmunro" :path #p"~/dev/nmunro/")
(strike :project :create :name "nmunro2" :path #p"~/dev/nmunro/")
(strike :project :get :name "nmunro")
(strike :project :list)
(strike :project :rename :name #p"nmunro" :to #p"nmunro-dev")
(strike :project :rename :name #p"nmunro-dev" :to #p"nmunro")
(strike :project :change-path :name "nmunro" :to #p"~/dev/nmunro-dev2/")
(strike :project :change-path :name "nmunro" :to #p"~/dev/nmunro-dev/")
(strike :project :delete :name "nmunro")

(strike :template :create :project "nmunro" :name #p"base2.html")
(strike :template :create :project "nmunro" :name #p"base3.html" :from #p"~/dev/nmunro/index.html")
(strike :template :list :project "nmunro2")
(strike :template :get :project "nmunro2" :name #p"base.html")
(strike :template :delete :project "nmunro" :name #p"base2.html")

(strike :page :create :project "nmunro" :name #p"blog.html")
(strike :page :create :project "nmunro" :name #p"blog.html" :from #p"base.html")
(strike :page :create :project "nmunro" :name #p"blog.html" :from #p"~/dev/nmunro/tmp.html")
(strike :page :get :project "nmunro2" :name #p"blog.html")
(strike :page :list :project "nmunro")
(strike :page :delete :project "nmunro" :name #p"blog.html")
