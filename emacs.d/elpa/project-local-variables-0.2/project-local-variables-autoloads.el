;;; project-local-variables-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "project-local-variables" "project-local-variables.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from project-local-variables.el

(autoload 'plv-find-project-file "project-local-variables" "\
Look up the project file in and above `dir'.

\(fn DIR MODE-NAME)" nil nil)

(defadvice hack-local-variables (before project-local-variables activate) "\
Load the appropriate .emacs-project files for a file." (let* ((full-name (symbol-name major-mode)) (mode-name (if (string-match "\\(.*\\)-mode$" full-name) (match-string 1 full-name) full-name)) (pfile (plv-find-project-file default-directory (concat "-" mode-name))) (gfile (plv-find-project-file default-directory ""))) (save-excursion (when gfile (load gfile)) (when pfile (load pfile)))))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "project-local-variables" '("setl" "plv-project-file")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; project-local-variables-autoloads.el ends here
