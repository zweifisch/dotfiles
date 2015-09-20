
(use-package quack :ensure t
  :config (setq quack-fontify-style 'emacs))

(use-package geiser :ensure t
  :config
  (progn
    (define-key scheme-mode-map (kbd "C-c C-p") 'geiser-eval-print-last-sexp)
    (evil-define-key 'normal scheme-mode-map
      (kbd "RET") 'geiser-eval-last-sexp)))

(eval-after-load "geiser-repl"
  '(progn (define-key geiser-repl-mode-map (kbd "C-a") nil)))

(setq geiser-active-implementations '(chicken))

(provide 'scheme-conf)
