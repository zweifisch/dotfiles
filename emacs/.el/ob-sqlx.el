;;; ob-sqlx.el --- Org-babel SQL runner via command templates -*- lexical-binding: t; -*-

(require 'org)
(require 'ob)
(require 'ob-eval)

(defgroup org-sqlx nil
  "Run any SQL blocks via a command template."
  :group 'org-babel)

(defcustom org-sqlx-default-cmd nil
  "Default command template for sqlx blocks.

Use %S to insert SQL as a shell-quoted argument.
Use %s to insert SQL raw (dangerous unless already quoted/escaped)."
  :type '(choice (const :tag "None" nil) string))

(defun org-sqlx--expand-body (body params)
  (org-babel-expand-body:generic body params))

(defun org-sqlx--template (template sql)
  "Substitute SQL into TEMPLATE.
%S => (shell-quote-argument sql)
%s => sql raw"
  (let ((cmd template))
    (when (string-match-p "%S" cmd)
      (setq cmd (replace-regexp-in-string "%S" (shell-quote-argument sql) cmd t t)))
    (when (string-match-p "%s" cmd)
      (setq cmd (replace-regexp-in-string "%s" sql cmd t t)))
    cmd))

(defun org-sqlx--property-cmd ()
  "Return SQLX_CMD property from the current Org context, if any."
  (when (derived-mode-p 'org-mode)
    (org-entry-get (point) "cmd" 'inherit)))

(defun org-sqlx--cmd (params)
  "Resolve command template from params, properties, or defaults."
  (or (cdr (assq :cmd params))
      (org-sqlx--property-cmd)
      org-sqlx-default-cmd))

(defun org-babel-execute:sqlx (body params)
  "Execute a block of sqlx with org-babel."
  (let* ((template (org-sqlx--cmd params))
         (_ (unless (and template (stringp template)
                         (string-match-p "%[sS]" template))
              (error "sqlx requires :cmd TEMPLATE (or SQLX_CMD property) containing %%S or %%s")))
         (sql (org-sqlx--expand-body body params))
         ;; Trim trailing whitespace but keep newlines inside SQL
         (sql (replace-regexp-in-string "\\`[ \t\n\r]+" "" sql))
         (sql (replace-regexp-in-string "[ \t\n\r]+\\'" "" sql))
         (cmd (org-sqlx--template template sql))
         (result (org-babel-eval cmd "")))
      result
      ))

;;;###autoload
(defun org-babel-prep-session:sqlx (_session _params)
  "sqlx does not support sessions."
  (error "sqlx does not support sessions"))

;;;###autoload
(with-eval-after-load 'org
  (add-to-list 'org-babel-load-languages '(sqlx . t)))

(with-eval-after-load 'org-src
  (add-to-list 'org-src-lang-modes '("sqlx" . sql)))

(provide 'ob-sqlx)
;;; ob-sqlx.el ends here
