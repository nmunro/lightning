(defpackage lightning
  (:use :cl)
  (:export #:main))

(in-package lightning)

(defun strike/project (action &key name path to)
  (cond
    ((and (eq action :create) name path)
     (lightning/projects:add-project name path))

    ((and (eq action :delete) name)
     (lightning/projects:remove-project name))

    ((eq action :list)
     (lightning/projects:list-projects))

    ((eq action :get)
     (lightning/projects:get-project name))

    ((and (eq action :rename) name to)
     (lightning/projects:rename-project name to))

    ((and (eq action :change-path) name to)
     (lightning/projects:change-path-project name to))

    (t
     (error "Invalid arguments"))))

(defun strike/template (action &key project name from)
  (cond
    ((and (eq action :create) name project from)
     (lightning/templates:add-template project name :from from))

    ((and (eq action :create) name project)
     (lightning/templates:add-template project name))

    ((and (eq action :list) project)
     (lightning/templates:list-templates project))

    ((and (eq action :delete) project name)
     (lightning/templates:remove-template project name))

    ((and (eq action :get) project name)
     (lightning/templates:get-template project name))

    (t
     (error "Invalid arguments"))))

(defun strike/page (action &key project name from)
  (cond
    ((and (eq action :create) name project from)
     (lightning/pages:add-page project name :from from))

    ((and (eq action :create) name project)
     (lightning/pages:add-page project name))

    ((and (eq action :list) project)
     (lightning/pages:list-pages project))

    ((and (eq action :delete) project name)
     (lightning/pages:remove-page project name))

    ((and (eq action :get) project name)
     (lightning/pages:get-page project name))

    (t
     (error "Invalid arguments"))))

(strike/project :create :name "nmunro" :path #p"~/dev/nmunro/")
(strike/project :create :name "nmunro2" :path #p"~/dev/nmunro/")
(strike/project :get :name "nmunro")
(strike/project :list)
(strike/project :rename :name "nmunro" :to "nmunro-dev")
(strike/project :rename :name "nmunro-dev" :to "nmunro")
(strike/project :change-path :name "nmunro" :to "~/dev/nmunro-dev2/")
(strike/project :change-path :name "nmunro" :to "~/dev/nmunro-dev/")
(strike/project :delete :name "nmunro")

(strike/template :create :project "nmunro" :name "base2.html")
(strike/template :create :project "nmunro" :name "base3.html" :from #p"~/dev/nmunro/index.html")
(strike/template :list :project "nmunro2")
(strike/template :get :project "nmunro2" :name "base.html")
(strike/template :delete :project "nmunro" :name "base2.html")

(strike/page :create :project "nmunro" :name "blog.html")
(strike/page :create :project "nmunro" :name "blog.html" :from "base.html")
(strike/page :create :project "nmunro" :name "blog.html" :from #p"~/dev/nmunro/tmp.html")
(strike/page :get :project "nmunro2" :name "blog.html")
(strike/page :list :project "nmunro")
(strike/page :delete :project "nmunro" :name "blog.html")
