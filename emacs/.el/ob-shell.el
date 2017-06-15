(defgroup ob-shell nil
  "org-mode blocks for shell script"
  :group 'org)

(defcustom ob-shell:default-shell "bash"
  "default shell"
  :group 'ob-shell
  :type 'string)

(defconst org-babel-header-args:shell
  '((ssh . :any))
  "shell header arguments")

(defun ob-shell-parse-result (output)
  (mapcar (lambda (x) (s-split "[\t,]" x)) (s-lines (s-chomp output))))

(defun org-babel-execute:shell (body params)
  (let* ((ssh (unless (assoc :local params) (cdr (assoc :ssh params))))
         (shell (or (cdr (assoc :shell params))
                 ob-shell:default-shell))
         (tmp (org-babel-temp-file "shell-"))
         (result-params (cdr (assoc :result-params params)))
         (cmd (if ssh (format "ssh %s '%s -s' < %s" ssh shell tmp)
                (format "%s %s" shell tmp)))
         (body (ob-shell-prep-files body)))
    (with-temp-file tmp (insert body))
    (if (assoc :async params)
        (ob-shell-execute-async cmd)
        (if (member "table" result-params)
            (ob-shell-parse-result (shell-command-to-string cmd))
          (shell-command-to-string cmd)))))

(defun ob-shell-execute-async (cmd)
  (let ((name "name"))
    (start-process name name cmd)
    (set-process-filter (get-process name) 'ob-shell-process-filter)))

(defun ob-shell-block-to-file (name)
  (let ((block (org-babel-ref-resolve name))
        (tmp (org-babel-temp-file "shell-" (concat "-" name))))
    (with-temp-file tmp
      (insert block) tmp)))

(defun ob-shell-prep-files (body)
  (let* ((files (s-match-strings-all "\{\{\\([^}]*\\)\}\}" body))
         (tmp-files (-map 'ob-shell-block-to-file (-map 'cadr files))))
    (if files
        (s-replace-all
         (-zip (-map 'car files) tmp-files) body)
      body)))

(provide 'ob-shell)
