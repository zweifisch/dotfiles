
(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun toggle-windows-split()
  (interactive)
  (if (not (window-minibuffer-p))
      (if (< 1 (count-windows))
          (progn
            (window-configuration-to-register ?u)
            (delete-other-windows))
        (jump-to-register ?u))))

(define-key global-map (kbd "C-a o") 'toggle-windows-split)


(defun eshell-buffer-names-in-project ()
  (->> (projectile-project-buffer-names)
       (-filter (lambda (buffer)
                  (eq 'eshell-mode
                      (with-current-buffer buffer major-mode))))))

(defun switch-to-eshell-in-project ()
  (interactive)
  (let ((eshell-buffers (eshell-buffer-names-in-project)))
    (cond (eshell-buffers
           (if (= 1 (length eshell-buffers))
               (switch-to-buffer (car eshell-buffers))
             (helm :sources '((name . "eshell")
                              (candidates . eshell-buffer-names-in-project)
                              (action . (lambda (candidate)
                                          (switch-to-buffer candidate)))))))
          (t (projectile-with-default-dir
                 (projectile-project-root)
               (eshell))))))

(defun eshell-buffer-names ()
  (->> (buffer-list)
       (-filter (lambda (buffer)
                  (eq 'eshell-mode
                      (buffer-local-value 'major-mode buffer))))
       (-map 'buffer-name)))

(defun switch-to-eshell ()
  (interactive)
  (helm :sources '((name . "eshell")
                   (candidates . eshell-buffer-names)
                   (action . (lambda (candidate)
                               (switch-to-buffer candidate))))))

(defun kill-process-at-point ()
  (interactive)
  (let* ((process (get-text-property (point) 'tabulated-list-id))
         (buffer (process-buffer process)))
    (if (y-or-n-p (format "kill process %s? " (process-name process)))
        (progn 
          (kill-process process)
          (kill-buffer buffer)
          (revert-buffer)))))

(defun restart-process-at-point ()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
    (if (y-or-n-p (format "restart process %s? " (process-name process)))
        (progn 
          (restart-process process)
          (revert-buffer)))))

(defun info-process-at-point ()
  (interactive)
  (let* ((process (get-text-property (point) 'tabulated-list-id))
         (buffer (process-buffer process)))
    (with-current-buffer buffer
      (message
       (format "%s %s" default-directory
               (prin1-to-string (process-status process)))))))

(defun restart-process (process)
  (if (processp process)
      (let ((name (process-name process))
            (buffer (process-buffer process))
            (command (process-command process)))
        (kill-process process)
        (sleep-for 1)
        (message (prin1-to-string (process-status process)))
        (with-current-buffer buffer
          (apply 'start-process name buffer command)))
    (error "can't find process!")))

(define-key process-menu-mode-map (kbd "r") 'restart-process-at-point)
(define-key process-menu-mode-map (kbd "k") 'kill-process-at-point)
(define-key process-menu-mode-map (kbd "i") 'info-process-at-point)

(defun helm-do-grep-recursive (&optional non-recursive)
  "Like `helm-do-grep', but greps recursively by default."
  (interactive "P")
  (let* ((current-prefix-arg (not non-recursive))
         (helm-current-prefix-arg non-recursive))
    (call-interactively 'helm-do-grep)))

(defun helm-collections()
  (interactive)
  (helm :sources (helm-source-org-headings-for-files '("~/.org/collect.org"))
        :candidate-number-limit 99999
        :buffer "*helm org collections*"))

;; delete geiser-debug.elc
(defun geiser-eval-print-last-sexp ()
  (interactive)
  (cl-flet ((geiser-debug--wrap-region (str) (format "(pp %s)" str)))
    (let* ((ret (geiser-eval-region (save-excursion (backward-sexp) (point))
                                    (point)
                                    nil
                                    nil
                                    t)))
      (geiser-eval--retort-result-str ret nil))))

(defun use-local-http-proxy ()
  (interactive)
  (setq url-proxy-services '(("http" . "localhost:8118"))))

(defun no-local-http-proxy ()
  (interactive)
  (setq url-proxy-services '()))

(defun browse-web-at-point ()
  (interactive)
  (let ((url (thing-at-point-url-at-point)))
    (if url (browse-web url))))

(global-set-key (kbd "C-c C-b") 'browse-web-at-point)

(provide 'misc-conf)
