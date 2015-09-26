
(defface powerline-custom1 '((t (:background "#EEAD0E" :foreground "black" :weight bold)))
  "Custom face for bright sections"
  :group 'powerline)

(defface powerline-custom2 '((t (:foreground "#EEAD0E" :weight bold)))
  "Custom face for text"
  :group 'powerline)

(use-package evil-anzu :ensure t)

(defun powerline-spacemacs-imitation-theme ()
  "An attempt to imitate the spacemacs powerline theme."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (face3 (if active 'powerline-custom1 mode-line))
                          (face4 (if active 'powerline-custom2 mode-line))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-raw "%*" face3 'l)
                                     (powerline-raw " " face3)
                                     (funcall separator-left face3 mode-line)
                                     
                                     (when powerline-display-buffer-size
                                       (powerline-buffer-size nil 'l))
                                     (when powerline-display-mule-info
                                       (powerline-raw mode-line-mule-info face4 'l))
                                     (powerline-buffer-id face4 'l)
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format nil 'l))
                                     (powerline-raw " ")
                                     (funcall separator-left mode-line face1)
                                     
                                     (when (boundp 'erc-modified-channels-object)
                                       (powerline-raw erc-modified-channels-object face1 'l))
                                     (powerline-major-mode face1 'l)
                                     (powerline-process face1)
                                     (powerline-raw " " face1)
                                     (funcall separator-right face1 mode-line)
                                     
                                     (powerline-minor-modes mode-line 'l)
                                     (powerline-narrow mode-line 'l)
                                     (powerline-raw " " mode-line)
                                     (funcall separator-left mode-line face1)
                                     
                                     (powerline-vc face1 'r)
                                     (powerline-raw " " face1)
                                     (funcall separator-right face1 face2)))
                          (rhs (list (powerline-raw global-mode-string face2 'r)
                                     (funcall separator-right face2 face1)
                                     (unless window-system
                                       (powerline-raw (char-to-string #xe0a1) face1 'l))
                                     (powerline-raw "%4l" face1 'l)
                                     (powerline-raw ":" face1 'l)
                                     (powerline-raw "%3c" face1 'r)
                                     (funcall separator-right face1 mode-line)
                                     (powerline-raw " ")
                                     (powerline-raw "%6p" nil 'r))))
                     (concat (powerline-render lhs)
                             (powerline-fill face2 (powerline-width rhs))
                             (powerline-render rhs)))))))

(setq display-time-day-and-date t)

(setq display-time-24hr-format t)

(setq display-time-mail-string "")

(setq mode-line-cleaner-alist
      '((paredit-mode . "")
        (page-break-lines-mode . "")
        (guide-key-mode . "")
        (volatile-highlights-mode . "")
        (undo-tree-mode . "")
        (org-indent-mode . "")))

(add-hook 'org-mode-hook '(lambda () (setq mode-name "ꙮ")))
(add-hook 'clojure-mode-hook '(lambda () (setq mode-name "λ")))
(add-hook 'emacs-lisp-mode-hook (lambda () (setq mode-name "ξ")))
(add-hook 'eshell-mode-hook (lambda () (setq mode-name "$")))

(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                  (mode-str (cdr cleaner))
                  (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
               (setcar old-mode-str mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

(setq persp-show-modestring nil)

(provide 'mode-line-conf)