
(defgroup ob-cfdg nil
  "org-mode blocks for context free drawing"
  :group 'org)

(defcustom ob-cfdg:default-size 500
  "default size"
  :group 'ob-cfdg
  :type 'number)

(defun org-babel-execute:cfdg (body params)
  (let* ((size (or (cdr (assoc :size params))
                 ob-cfdg:default-size))
         (tmp (org-babel-temp-file "cfdg-"))
         (output (cdr (assoc :file params)))
         (cmd (format "cfdg -s %s %s %s" size tmp output)))
    (with-temp-file tmp (insert body))
    (message (shell-command-to-string cmd))
    nil))

(provide 'ob-cfdg)
