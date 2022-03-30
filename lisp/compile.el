;;; compile.el --- Byte compile all Emacs Lisp files in the package  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Byte compile all Emacs Lisp files in the package
;;
;;   $ eask compile [names..]
;;
;;
;;  Initialization options:
;;
;;    [names..]     specify files to byte-compile
;;

;;; Code:

(load (expand-file-name
       "_prepare.el"
       (file-name-directory (nth 1 (member "-scriptload" command-line-args))))
      nil t)

;; Handle options
(when (eask-strict-p) (setq byte-compile-error-on-warn t))
(when (= eask-verbosity 4) (setq byte-compile-verbose t))

(defun eask--byte-compile-file (filename)
  "Byte compile FILENAME with display messages."
  (let* ((filename (expand-file-name filename))
         (result (byte-compile-file filename)) (compiled (eq result t)))
    (unless byte-compile-verbose
      (if compiled (message "Compiling %s..." filename)
        (message "Skipping %s..." filename)))
    compiled))

(eask-start
  (eask-pkg-init)
  (let ((files (or (eask-args) (eask-package-el-files))) compiled)
    (eask-with-verbosity 'log
      (dolist (filename files)
        (when (eask--byte-compile-file filename) (push filename compiled))))
    (eask-info "(Total of %s files compiled)" (length compiled))))

;;; compile.el ends here
