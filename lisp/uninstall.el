;;; uninstall.el --- Uninstall packages  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Command use to uninstall Emacs packages,
;;
;;   $ eask uninstall <name>
;;
;;
;;  Initialization options:
;;
;;    <name>     name of the package to uninstall
;;

;;; Code:

(load-file (expand-file-name
            "_prepare.el"
            (file-name-directory (nth 1 (member "-scriptload" command-line-args)))))

(defun eask-package-desc (name &optional current)
  "Build package description by PKG-NAME."
  (cadr (assq name (if current package-alist package-archive-contents))))

(eask-start
  (eask-pkg-init)
  (if-let* ((name (elt argv 0)) (name (intern name))
            ((package-installed-p name)))
      (package-delete (eask-package-desc name t) (eask-force-p))
    (eask-info "Package `%s` does not exists" name)))

;;; uninstall.el ends here
