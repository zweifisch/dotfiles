
(defun shell-buffer-names-in-project ()
  (->> (projectile-project-buffer-names)
       (-filter (lambda (buffer)
                  (eq 'term-mode
                      (with-current-buffer buffer major-mode))))))

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
               (multi-term))))))

(defun shell-buffer-names ()
  (->> (buffer-list)
       (-filter (lambda (buffer)
                  (eq 'term-mode
                      (buffer-local-value 'major-mode buffer))))
       (-map 'buffer-name)))

(defun switch-to-shell ()
  (interactive)
  (helm :sources '((name . "shell")
                   (candidates . shell-buffer-names)
                   (action . (lambda (candidate)
                               (switch-to-buffer candidate))))))

(provide 'shell-switch)
