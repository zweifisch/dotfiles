;; Prevent the cursor from blinking
; (blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)

(ido-mode t)
(setq ido-enable-flex-matching t)

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace)
(setq-default save-place t)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups")))) 

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

(defvar
  my-packages '(subatomic-theme
                 evil
                 evil-indent-textobject
                 evil-matchit
                 evil-nerd-commenter
                 evil-leader
                 python
                 flycheck))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq my:el-get-packages
      '(org-mode
         jedi
         coffee-mode
         fiplr
         projectile
         helm
         ; undo-tree
         ; clojure-mode
         ; slime-repl
         ; swank-clojure
         ; yasnippet
         ; anything
         ; emms
         ; dired-sort
         ; auto-dictionnary
         ; autopair
         ; dired+
         ; google-maps
         ; org2blog
         ; rainbow-mode
         ; switch-window
         ; sr-speedbar
         ; typopunct
         ))

(el-get 'sync my:el-get-packages)

;; theme and modes

(load-theme 'subatomic t)

(evil-mode)

(global-evil-leader-mode)

; fiplr (replaced with projectile)
(setq fiplr-root-markers '(".git" ".svn"))
(global-set-key (kbd "C-x p") 'fiplr-find-file)
(setq fiplr-ignored-globs '((directories (".git" ".svn"))
                            (files ("*.jpg" "*.png" "*.zip" "*~"))))

; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

; projectile
(projectile-global-mode)
(setq projectile-completion-system 'grizzl)

; helm (not necessary..)
(global-set-key (kbd "C-c h") 'helm-projectile)

; evil-leader

(evil-leader/set-key
  "f" 'projectile-find-file
  "b" 'projectile-switch-to-buffer
  "s" 'projectile-switch-project)

; nerd-commenter
(evilnc-default-hotkeys)
