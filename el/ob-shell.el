
(defgroup ob-shell nil
  "org-mode blocks for shell script"
  :group 'org)

(defcustom ob-shell:default-shell "bash"
  "default shell"
  :group 'ob-shell
  :type 'string)

(defun ob-shell/parse-result (output)
  (mapcar (lambda (x) (s-split "[\t,]" x)) (s-lines (s-chomp output))))

(defun org-babel-execute:shell (body params)
  (let* ((ssh (cdr (assoc :ssh params)))
         (shell (or (cdr (assoc :shell params))
                 ob-shell:default-shell))
         (tmp (org-babel-temp-file "shell-"))
         (result-params (cdr (assoc :result-params params)))
         (cmd (if ssh (format "ssh %s '%s -s' < %s" ssh shell tmp)
                (format "%s %s" shell tmp))))
    (with-temp-file tmp (insert body))
    (if (member "table" result-params)
        (ob-shell/parse-result (shell-command-to-string cmd))
      (shell-command-to-string cmd))))

(provide 'ob-shell)
