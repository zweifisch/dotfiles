(defgroup ob-html nil
  "org-mode blocks for html script"
  :group 'org)

(defcustom ob-html:binary "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  "chrome binary"
  :group 'ob-html
  :type 'string)

(defconst org-babel-header-args:html
  '((size . :string))
  "html header arguments")

(defun ob-html-parse-result (output)
  (mapcar (lambda (x) (s-split "[\t,]" x)) (s-lines (s-chomp output))))

(defun org-babel-execute:html (body params)
  (let* ((size (or (cdr (assoc :size params)) "750,200"))
         (binary (or (cdr (assoc :binary params))
                 ob-html:binary))
         (tmp (org-babel-temp-file "html-" ".html"))
         (cmd (format "'%s' --headless --disable-gpu --screenshot --window-size=%s '%s' 2&> /dev/null && cat screenshot.png"
                      binary size tmp)))
    (message cmd)
    (with-temp-file tmp (insert body))
    (shell-command-to-string cmd)))

(provide 'ob-html)
