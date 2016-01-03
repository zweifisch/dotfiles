
(use-package helm-themes :ensure t)
;; (use-package zenburn-theme :ensure t)
;; (use-package color-theme-sanityinc-tomorrow :ensure t)
;; (use-package moe-theme :ensure t)
(use-package material-theme :ensure t)
;; (use-package leuven-theme :ensure t)
;; (use-package twilight-bright-theme :ensure t)
;; (use-package monokai-theme :ensure t)
(load-theme 'material t)

(setq projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))


;; (when (member "DejaVu Sans Mono" (font-family-list))
;;   (set-face-attribute 'default nil :font "DejaVu Sans Mono-10"))

;; (set-face-attribute 'default nil :font "")

;; (set-default-font "DejaVu Sans Mono-10")
;; (set-fontset-font nil 'chinese-gbk '"WenQuanYi Micro Hei Mono-12")

(set-face-attribute 'default nil :font "Fira Code-10.5" :weight 'Light)
(set-fontset-font nil 'chinese-gbk '"WenQuanYi Micro Hei Mono-12")

;; (set-frame-font "Hack-10")

;; (set-face-attribute 'default nil :font "Input Mono Light 11" :weight 'Thin)

;; (set-face-attribute 'default nil :font "Source Code Pro 10")

;; (use-package powerline :ensure t)
;; (setq powerline-default-separator 'wave)
;; (powerline-default-theme)

(require 'mode-line-conf)

(provide 'theme-conf)
