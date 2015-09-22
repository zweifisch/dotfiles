
(use-package helm-themes :ensure t)
;; (use-package zenburn-theme :ensure t)
;; (use-package color-theme-sanityinc-tomorrow :ensure t)
;; (use-package moe-theme :ensure t)
(use-package material-theme :ensure t)
;; (use-package leuven-theme :ensure t)
;; (use-package twilight-bright-theme :ensure t)
;; (use-package monokai-theme :ensure t)
(load-theme 'material t)

;; (use-package smart-mode-line :ensure t)
;; (sml/apply-theme 'respectful)

(setq projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))


(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono-10"))

;; (set-frame-font "Hack-10")
;; (set-frame-font "Input Mono Light 10")
;; (set-frame-font "Source Code Pro 10")


(use-package powerline :ensure t)
(setq powerline-default-separator 'wave)
;; (powerline-default-theme)

(require 'mode-line-conf)
;; (setq powerline-height 20)
(powerline-spacemacs-imitation-theme)

(provide 'theme-conf)
