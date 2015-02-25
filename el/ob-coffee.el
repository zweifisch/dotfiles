(require 'org)
(require 'ob)
(require 'coffee-mode)


(defvar org-babel-coffee-eoe "org-babel-coffee-eoe")


(defun org-babel-execute:coffee (body params)
  (let* ((result-type (cdr (assoc :result-type params)))
         (full-body (org-babel-expand-body:generic
                     body params (org-babel-variable-assignments:coffee params)))
         (session (cdr (assoc :session params)))
         (result (if (string= session "none")
                     (ob-coffee/eval-as-script full-body) 
                   (ob-coffee/eval-in-repl session full-body))))
    (org-babel-result-cond (cdr (assoc :result-params params))
      result (ob-coffee/read result))))


(defun ob-coffee/eval-as-script (body)
  (let ((tmp (org-babel-temp-file "coffee-script-")))
    (with-temp-file tmp
      (insert
       (if (string= result-type "value")
           (format org-babel-coffee-function-wrapper body)
         body)))
    (org-babel-eval
     (format "coffee %s" (org-babel-process-file-name tmp)) "")))


(defun ob-coffee/eval-in-repl (session body)
  (let* ((session (org-babel-prep-session:coffee session params))
         (result (org-babel-comint-with-output
                     (session (format "%S" org-babel-coffee-eoe) t body)
                   (mapc
                    (lambda (line)
                      (insert (org-babel-chomp line))
                      (comint-send-input nil t))
                    (list body (format "%S" org-babel-coffee-eoe)))))
         (text (s-join "" result)))
    (message result)
    (org-babel-chomp text)))


(defun org-babel-prep-session:coffee (session params)
  (let* ((session (org-babel-coffee-initiate-session session))
         (var-lines (org-babel-variable-assignments:coffee params)))
    (when session
      (org-babel-comint-in-buffer session
        (sit-for .5)
        (goto-char (point-max))
        (mapc (lambda (var)
                (insert var) (comint-send-input nil t)
                (org-babel-comint-wait-for-output session)
                (sit-for .1)
                (goto-char (point-max)))
              var-lines)))
    session))


(defun org-babel-variable-assignments:coffee (params)
  (mapcar
   (lambda (pair) (format "%s=%s"
                          (car pair) (org-babel-coffee-var-to-coffee (cdr pair))))
   (mapcar #'cdr (org-babel-get-header params :var))))


(defun org-babel-coffee-var-to-coffee (var)
  (if (listp var)
      (concat "[" (mapconcat #'org-babel-coffee-var-to-coffee var ", ") "]")
    (replace-regexp-in-string "\n" "\\\\n" (format "%S" var))))


(defun org-babel-coffee-initiate-session (&optional session)
  (unless (string= session "none")
    (if (org-babel-comint-buffer-livep session) session
      (let ((session-buffer (save-window-excursion
                              (coffee-repl)
                              (rename-buffer session)
                              (current-buffer))))))))


(defun ob-coffee/read (results)
  (org-babel-read
   (if (and (stringp results) (string-match "^\\[.+\\]$" results))
       (org-babel-read
        (concat "'"
                (replace-regexp-in-string
                 "\\[" "(" (replace-regexp-in-string
                            "\\]" ")" (replace-regexp-in-string
                                       ", " " " (replace-regexp-in-string
                                                 "'" "\"" results))))))
     results)))

(provide 'ob-coffee)
