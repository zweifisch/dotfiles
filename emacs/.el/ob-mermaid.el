(defgroup ob-mermaid nil
  "org-mode blocks for mermaid"
  :group 'org)

(defcustom ob-mermaid:binary "mmdc"
  "mermaid.cli binary"
  :group 'ob-mermaid
  :type 'string)

(defconst org-babel-header-args:mermaid
  '((width . :string)
    (height . :string)
    (theme . :string))
  "mermaid header arguments")

(defun org-babel-execute:mermaid (body params)
  (let* ((width (or (cdr (assoc :width params)) "800"))
         (height (or (cdr (assoc :height params)) "600"))
         (theme (or (cdr (assoc :theme params)) "default"))
         (binary (or (cdr (assoc :binary params))
                 ob-mermaid:binary))
         (tmp (org-babel-temp-file "mermaid-" ".mmd"))
         (file (cdr (assoc :file params)))
         (cmd (format "'%s' --width %s --height %s --theme '%s' --input '%s' --output '%s' 2&> /dev/null && cat '%s'"
                      binary width height theme tmp file file)))
    (message cmd)
    (with-temp-file tmp (insert body))
    (shell-command-to-string cmd)))

(provide 'ob-mermaid)
