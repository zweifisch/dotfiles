(require 'org)
(require 'ob)

(defvar org-babel-racket-eoe "org-babel-racket-eoe")

(defun org-babel-execute:racket (body params)
  (let* ((result-type (cdr (assoc :result-type params)))
         (full-body (org-babel-expand-body:generic
                     body params (org-babel-variable-assignments:racket
                                  (org-babel-get-header params :var))))
         (session (assoc :session params))
         (result (if session
                     (ob-racket/eval-in-repl (or (cdr session) "default") full-body)
                   (ob-racket/eval-as-script full-body))))
    (org-babel-result-cond (cdr (assoc :result-params params))
      result result)))


(defun ob-racket/eval-as-script (body)
  (let ((tmp (org-babel-temp-file "racket-script-")))
    (with-temp-file tmp
      (insert
       (if (string= result-type "value")
           (format org-babel-racket-function-wrapper body)
         body)))
    (org-babel-eval
     (format "racket %s" (org-babel-process-file-name tmp)) "")))


(defun ob-racket/eval-in-repl (session body)
  (org-babel-racket-initiate-session session)
  (let* ((session (format "*%s*" session))
         (result (org-babel-comint-with-output
                     (session (format "%S" org-babel-racket-eoe) t body)
                   (mapc
                    (lambda (line)
                      (insert (org-babel-chomp line))
                      (comint-send-input nil t))
                    (list body (format "%S" org-babel-racket-eoe))))))
    ;; (message result)
    (message (s-join "|" result))
    (ob-racket/find-last-result result)))

(defun ob-racket/find-last-result (result)
  (let ((last-result (nth (- (length result) 3) result)))
    (s-chop-prefix "> " last-result)))

(defun org-babel-variable-assignments:racket (vars)
  (mapcar
   (lambda (pair) (format "%s=%s"
                          (car pair) (org-babel-racket-var-to-racket (cdr pair))))
   (mapcar #'cdr vars)))


(defun org-babel-racket-var-to-racket (var)
  (if (listp var)
      (concat "[" (mapconcat #'org-babel-racket-var-to-racket var ", ") "]")
    (replace-regexp-in-string "\n" "\\\\n" (format "%S" var))))


(defun org-babel-racket-initiate-session (session)
  (unless (org-babel-comint-buffer-livep session)
    (save-window-excursion (make-comint session "racket"))))


(defun ob-racket/read (results)
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

(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("racket" . scheme)))

(provide 'ob-racket)
