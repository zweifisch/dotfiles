
(defun shell-switch-eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))))

(defun shell-switch-vterm-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The shell is renamed to match that
directory to make multiple shell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (vterm)
    (rename-buffer (concat "*vterm: " name "*"))))

(defun shell-switch-is-shell (buffer)
  (or
   (eq 'vterm-mode
       (with-current-buffer buffer major-mode))
   (eq 'term-mode
       (with-current-buffer buffer major-mode))
   (eq 'eshell-mode
       (with-current-buffer buffer major-mode))))

(defun shell-buffer-names-in-project ()
  (->> (projectile-project-buffer-names)
       (-filter 'shell-switch-is-shell)))

(defun switch-to-shell-in-project ()
  (interactive)
  (let ((shell-buffers (shell-buffer-names-in-project)))
    (cond (shell-buffers
           (if (= 1 (length shell-buffers))
               (switch-to-buffer (car shell-buffers))
             (helm :sources '((name . "shell")
                              (candidates . shell-buffer-names-in-project)
                              (action . (lambda (candidate)
                                          (switch-to-buffer candidate)))))))
          (t (projectile-with-default-dir
                 (projectile-project-root)
               ;; (multi-term)
               ;; (shell-switch-eshell-here)
               (shell-switch-vterm-here))))))

(defun shell-buffer-names ()
  (->> (buffer-list)
       (-filter 'shell-switch-is-shell)
       (-map 'buffer-name)))

(defun switch-to-shell ()
  (interactive)
  (helm :sources '((name . "shell")
                   (candidates . shell-buffer-names)
                   (action . (lambda (candidate)
                               (switch-to-buffer candidate))))))

(provide 'shell-switch)
