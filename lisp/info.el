;;; info.el --- Display information about the current package  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Display information about the current package
;;
;;   $ eask info
;;

;;; Code:

(load (expand-file-name
       "_prepare.el"
       (file-name-directory (nth 1 (member "-scriptload" command-line-args))))
      nil t)

(defun eask--print-info (key)
  "Print package information."
  (when-let ((info (eask-package-get key)))
    (message "  %s" info)))

(eask-start
  (eask--print-info :name)
  (eask--print-info :version)
  (eask--print-info :description))

;;; info.el ends here
