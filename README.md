# lightning 0.0.1

A static site generator written in common lisp

## Why?

1) I needed one
2) Everything that existed seems to use Ros (which I couldn't get working)
3) Boredom, figured it would be a nice little project to keep me occupied

## Docs

Projects are made up of templates and pages, you can create a page from a template, in this case a page will inherit details from a template. They don't have to, if you want a completely unique page, but templates allow you to rapidly create pages that share common properties.

### Projects

#### Create a project

    (strike/project :create :name "nmunro" :path #p"~/dev/nmunro/") 

Remember to use a trailing '/'!

#### To get a single project

    (strike/project :get :name "nmunro")

#### List all projects

    (strike/project :list)

#### Rename a project

    (strike/project :rename :name "nmunro" :to "nmunro-dev")
    
#### Change the path a project is located at

    (strike/project :change-path :name "nmunro" :to "~/dev/nmunro-dev/")
    
#### Deleting a project

    (strike/project :delete :name "nmunro")

### Templates

#### Create a template

    (strike/template :create :project "nmunro" :name "base2.html")

#### Create a template from a file

    (strike/template :create :project "nmunro" :name "base3.html" :from #p"~/dev/nmunro/index.html")
    
#### List all templates

    (strike/templates :list :project "nmunro")
    
#### Delete a template

    (strike/template :delete :project "nmunro" :name "base2.html")

### Pages

## Author

NMunro

## Licence

BSD3-Clause
