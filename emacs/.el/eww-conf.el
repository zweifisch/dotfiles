
(defun oww-down (arg)
  (interactive "p")
  (if (bolp)
      (progn
        (forward-paragraph arg)
        (forward-line 1))
    (line-move arg)))

(defun oww-up (arg)
  (interactive "p")
  (if (bolp)
      (progn
        (forward-line -1)
        (backward-paragraph arg)
        (forward-line 1))
    (line-move (- arg))))

(defun zf-eww-hook ()
  (define-key eww-mode-map "j" 'oww-down)
  (define-key eww-mode-map "k" 'oww-up)
  (define-key eww-mode-map "l" 'forward-char)
  (define-key eww-mode-map "H" 'eww-back-url)
  (define-key eww-mode-map "h" 'backward-char)
  (define-key eww-mode-map "v" 'recenter-top-bottom)
  (define-key eww-mode-map "V" 'eww-view-source)
  (define-key eww-mode-map "m" 'eww-follow-link)
  (define-key eww-mode-map "^" 'move-beginning-of-line)
  (define-key eww-mode-map "$" 'move-end-of-line)
  (define-key eww-mode-map "f" 'ace-link-eww)
  (define-key eww-mode-map "o" 'eww))

(add-hook 'eww-mode-hook 'zf-eww-hook)

(defun eww-browse-url-at-point ()
  (interactive)
  (eww-browse-url (thing-at-point 'url)) t)

(defun ace-link-setup-default ()
  "Setup the defualt shortcuts."
  (eval-after-load "info"
    '(define-key Info-mode-map "f" 'ace-link-info))
  (eval-after-load "help-mode"
    '(define-key help-mode-map "f" 'ace-link-help))
  (eval-after-load "eww"
    '(progn
      (define-key eww-link-keymap "f" 'ace-link-eww)
      (define-key eww-mode-map "f" 'ace-link-eww))))

(use-package ace-link
    :init (ace-link-setup-default))

(defun toggle-url-proxy ()
  (interactive)
  (setq url-proxy-services
        (if url-proxy-services nil '(("http" . "127.0.0.1:8118")
                                     ("https" . "127.0.0.1:8118")))))

(setq eww-search-prefix "http://www.google.com/search?q=")

(setq shr-color-visible-luminance-min 70)

(defun zf-rename-eww-hook ()
  (rename-buffer "eww" t))

(add-hook 'eww-mode-hook #'zf-rename-eww-hook)

(provide 'eww-conf)
