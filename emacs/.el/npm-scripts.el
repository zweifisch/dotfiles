
(defun npm-test ()
  "npm test"
  (interactive)
  (let ((compilation-save-buffers-predicate 'ignore)
        (compilation-ask-about-save nil))
    (compile "npm test" t)))

(defun npm-test-current-file ()
  "npm test"
  (interactive)
  (let ((compilation-save-buffers-predicate 'ignore)
        (compilation-ask-about-save nil))
    (compile
     (cond ((equal current-prefix-arg 1) (concat "npm test " (buffer-file-name) " -- " " -u"))
           (t (concat "npm test " (buffer-file-name))))
     t)))

(defun npm-jest-current-file ()
  "npm run jest"
  (interactive)
  (let ((compilation-save-buffers-predicate 'ignore)
        (compilation-ask-about-save nil))
    (compile (concat "npm run jest " (buffer-file-name)) t)))

(defun npm-compile ()
  "npm compile"
  (interactive)
  (let ((compilation-save-buffers-predicate 'ignore)
        (compilation-ask-about-save nil))
    (compile "npm run compile" t)))

(defun npm-lint ()
  "npm lint"
  (interactive)
  (let ((compilation-save-buffers-predicate 'ignore)
        (compilation-ask-about-save nil))
    (compile "npm run lint" t)))

(defun npm-find-package-file ()
  "find package.json"
  (let ((dir (locate-dominating-file default-directory "package.json")))
    (unless dir
      (error "package.json not found"))
    (concat dir "package.json")))

(defun npm-read-package-info ()
  "read package.json"
  (json-read-file (npm-find-package-file)))

(defun npm-scripts ()
  (-map 'car
   (cdr
    (-first (lambda (entry) (eq (car entry) 'scripts))
            (npm-read-package-info)))))

(defun npm-run--read-command ()
  (completing-read "Run script: " (npm-scripts)))

(defun npm-run (script)
  "npm run"
  (interactive
   (list (npm-run--read-command)))
  (compile (format "npm run %s" script) t))

(provide 'npm-scripts)
