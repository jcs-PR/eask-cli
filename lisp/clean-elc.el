;;; clean-elc.el --- Remove byte compiled files generated by cask build  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Remove byte compiled files generated by cask build
;;
;;   $ eask clean-elc
;;

;;; Code:

(load (expand-file-name
       "_prepare.el"
       (file-name-directory (nth 1 (member "-scriptload" command-line-args))))
      nil t)

(defun eask--delete-file (filename)
  "Delete FILENAME from disk."
  (ignore-errors (delete-file filename))
  (message "Deleting %s..." filename))

(eask-start
  (if-let ((elcs (eask-package-elc-files)))
      (progn
        (eask-with-verbosity 'log (mapc #'eask--delete-file elcs))
        (eask-info "(Total of %s .elc files deleted)" (length elcs)))
    (eask-info "(No .elc file found in workspace)")))

;;; clean-elc.el ends here
