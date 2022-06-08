(defpackage lightning/config
  (:use :cl)
  (:export #:load-config
           #:save-config))

(in-package lightning/config)

(defconstant +config-path+ #p"~/.config/lightning/config.json")

(defun load-config ()
  (with-open-file (file +config-path+ :direction :input :if-does-not-exist nil)
    (if file
      (let ((str (make-string (file-length file))))
          (read-sequence str file)
          (jonathan:parse str))
      '(:projects ()))))

(defun save-config (config)
  (ensure-directories-exist +config-path+)
  (with-open-file (file +config-path+ :direction :output :if-does-not-exist :create :if-exists :supersede)
    (format file "~A" (jonathan:to-json config))))
