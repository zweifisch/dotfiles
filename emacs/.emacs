(blink-cursor-mode -1)

(setq initial-scratch-message ""
      inhibit-startup-message t
      visible-bell t)

;; dangerous
(setq enable-local-variables :all)

(ido-mode t)
(setq ido-enable-flex-matching t)
(add-to-list 'ido-ignore-buffers "*Messages*")

(defalias 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode t)

;; (global-hl-line-mode)

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(set-face-attribute 'default nil :height 110)

(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,temporary-file-directory t)))


(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace)
(setq-default save-place t)

(show-paren-mode 1)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      save-place-file (concat user-emacs-directory "places"))


(require 'package)
;(add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(evil
                      evil-indent-textobject
                      evil-matchit
                      evil-leader
                      ;; elscreen
                      elm-mode
                      org-present
                      use-package
                      go-mode
                      go-eldoc
                      company-go
                      linum-relative
                      volatile-highlights
                      know-your-http-well
                      company
                      alchemist
                      evil-god-state
                      ;; diff-hl
                      bison-mode
                      ghc
                      company-ghc
                      guide-key
                      flycheck))
(dolist (p my-packages)
  (when (not (package-installed-p p)) (package-install p)))

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

(setq my:el-get-packages
      '(python
        slime
        smart-tab
        mmm-mode
        rainbow-delimiters
        calfw))
(el-get 'sync my:el-get-packages)

;; emms dired-sort auto-dictionnary
;; autopair google-maps
;; sr-speedbar typopunct


; evil
(evil-mode)

(setq-default evil-symbol-word-search t)

(define-key evil-normal-state-map " " 'evil-toggle-fold)
(define-key evil-normal-state-map ";" 'evil-ex)
(define-key evil-visual-state-map
  (kbd "RET") 'append-to-buffer)

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

; evil-leader
(evil-leader/set-key
  ;; "F" 'projectile-find-file
  "F" 'helm-projectile-find-file
  "f" 'helm-find-files
  ;; "B" 'ido-switch-buffer
  "B" 'helm-buffers-list
  ;; "b" 'projectile-switch-to-buffer
  "b" 'helm-projectile-switch-to-buffer
  "R" 'helm-recentf
  "r" 'helm-projectile-recentf

  "A" 'org-agenda

  "g" 'helm-do-grep-recursive
  "G" 'helm-projectile-grep
  "o" 'browse-url
  "e" 'switch-to-eshell-in-project
  "E" 'switch-to-eshell
  ;; "i" 'ein:notebooklist-open
  "c" 'org-capture
  "s" 'magit-status
  "a" 'avy-goto-word-or-subword-1
  ;; "v" 'wg-switch-to-workgroup
  "V" 'projectile-persp-switch-project
  "v" 'persp-switch
  ;; "v" 'helm-projectile-switch-project
  "m" 'mu4e
  "d" 'deft
  "D" 'vc-diff)

(global-evil-leader-mode)
(evil-leader/set-leader "|")
(evil-define-key 'normal global-map
  "gj" 'avy-goto-word-or-subword-1
  "," 'evil-execute-in-god-state)

(global-set-key (kbd "C-a") nil)
(global-set-key (kbd "C-a |") 'evil-window-vsplit)
(global-set-key (kbd "C-a -") 'evil-window-split)
(global-set-key (kbd "C-a p") 'persp-prev)
(global-set-key (kbd "C-a n") 'persp-next)
(global-set-key (kbd "C-a c") 'projectile-persp-switch-project)
(global-set-key (kbd "C-a ,") 'persp-rename)
(global-set-key (kbd "C-a x") 'persp-kill)
(global-set-key (kbd "C-a l") 'evil-window-right)
(global-set-key (kbd "C-a h") 'evil-window-left)
(global-set-key (kbd "C-a j") 'evil-window-down)
(global-set-key (kbd "C-a k") 'evil-window-up)
(global-set-key (kbd "C-a H") 'winner-undo)
(global-set-key (kbd "C-a L") 'winner-redo)

; recentf
(recentf-mode 1)
(setq recentf-max-saved-items 512)

(require 'use-package)

; evil-nerd-commenter
(eval-after-load 'evil-nerd-commenter-operator
  '(progn
     (define-key evil-normal-state-map "gc" 'evilnc-comment-operator)
     (define-key evil-visual-state-map "gc" 'evilnc-comment-operator)))

(use-package evil-nerd-commenter :ensure t)

(use-package evil-surround :ensure t
  :config (global-evil-surround-mode 1))

(use-package markdown-mode :ensure t)
(use-package help-fns+ :ensure t)

; projectile
(use-package projectile
  :ensure t
  :config
  (progn
    (projectile-global-mode)
    (setq projectile-completion-system 'helm
          projectile-switch-project-action 'projectile-dired
          projectile-remember-window-configs t)))

(use-package helm :ensure t
  :config
  (progn
    (use-package helm-config)
    (add-hook 'helm-before-initialize-hook
              (lambda () 
                (add-to-list 'helm-boring-buffer-regexp-list  "\\*magit")
                (add-to-list 'helm-boring-buffer-regexp-list  "\\*scratch")
                (add-to-list 'helm-boring-buffer-regexp-list  "\\*eshell")
                (add-to-list 'helm-boring-buffer-regexp-list  "\\*cider")
                (add-to-list 'helm-boring-buffer-regexp-list  "\\*foreman")))
    (define-key helm-map (kbd "ESC") 'helm-keyboard-quit)))

(use-package helm-projectile
  :ensure t
  :config (helm-projectile-on))

; python
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args ""
      python-shell-prompt-regexp "In \\[[0-9]+\\]: "
      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
      python-shell-completion-setup-code
      "from IPython.core.completerlib import module_completion"
      python-shell-completion-module-string-code
      "';'.join(module_completion('''%s'''))\n"
      python-shell-completion-string-code
      "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(setq org-src-fontify-natively t)  ; code block

(add-hook 'python-mode-hook 'flycheck-mode)


(setq org-directory "~/.org/")
(setq org-agenda-files (list org-directory))

(setq org-capture-templates
      '(("t" "Tasks" entry (file+headline "todo.org" "Tasks")
         "* TODO %?")
        ("c" "Collection" entry (file+headline "collect.org" "Collections")
         "* %x")
        ("j" "Journal" entry (file+datetree "journal.org" "* %?\nEntered on %U\n  %i\n  %a"))))

(setq calendar-week-start-day 1)

(setq org-todo-keywords
      '((sequence "TODO" "NEXT" "|" "DONE" "ABORTED")))

(evil-define-key 'normal org-mode-map
  "gh" 'outline-up-heading
  "gj" 'org-forward-heading-same-level
  "gk" 'org-backward-heading-same-level
  "gl" 'outline-next-visible-heading
  "t" 'org-todo
  "gt" 'org-show-todo-tree
  "ge" 'org-edit-special
  "$" 'org-end-of-line
  "^" 'org-beginning-of-line
  "<" 'org-metaleft
  ">" 'org-metaright
  "ga" 'org-agenda
  " " 'org-toggle-inline-images
  ;; "-" 'org-cycle-list-bullet
  (kbd "TAB") 'org-cycle)

(evil-define-key 'normal org-src-mode-map
  "ge" 'org-edit-src-exit)

(evil-define-key 'emacs org-agenda-mode-map
  "j" 'org-agenda-next-line
  "k" 'org-agenda-previous-line
  (kbd "C-j") 'org-agenda-goto-date  ; "j"
  "n" 'org-agenda-capture)           ; "k"

; shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq-default truncate-lines t)

(exec-path-from-shell-initialize)


(defun eval-print-last-sexp-comment ()
  (interactive)
  (move-beginning-of-line nil)
  (unless (eobp)
    (kill-line))
  (eval-print-last-sexp)
  (sit-for .01)
  (forward-line -2)
  (kill-line)
  (comment-region (line-beginning-position) (line-end-position)))

(defun cider-eval-print-last-sexp-comment ()
  (interactive)
  (move-beginning-of-line nil)
  (unless (eobp)
    (kill-line))
  (cider-eval-print-last-sexp)
  (sit-for .01)
  (comment-region (line-beginning-position) (line-end-position)))

(use-package cider
  :ensure t
  :config (progn
            (evil-define-key 'normal cider-mode-map
              (kbd "RET") 'cider-eval-last-sexp)
            (evil-define-key 'normal cider-mode-map
              (kbd "<C-return>") 'cider-eval-print-last-sexp-comment)
            (evil-define-key 'visual cider-mode-map
              (kbd "RET") 'cider-eval-region)
            (setq nrepl-hide-special-buffers t
                  cider-repl-pop-to-buffer-on-connect nil
                  cider-popup-stacktraces t
                  cider-repl-popup-stacktraces t)))

(use-package ac-cider :ensure t)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(use-package paredit
  :ensure t
  :config (progn (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
                 (add-hook 'scheme-mode-hook 'paredit-mode)))

(use-package clojure-mode
  :ensure t
  :config (progn
            (add-hook 'clojure-mode-hook 'paredit-mode)
            (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)))

(evil-define-key 'normal paredit-mode-map
  "D" 'paredit-kill
  ;; "dd" 'paredit-kill-sexps-on-whole-line
  "gh" 'paredit-backward
  "gj" 'paredit-forward-up
  "gk" 'paredit-backward-up
  "gl" 'paredit-forward

  "w(" 'paredit-wrap-round
  "w[" 'paredit-wrap-square
  "w{" 'paredit-wrap-curly
  "w<" 'paredit-wrap-angled
  "wh" 'paredit-forward-barf-sexp
  "wl" 'paredit-forward-slurp-sexp
  "wH" 'paredit-splice-sexp-killing-backward
  "ww" 'paredit-wrap-round
  "wu" 'paredit-splice-sexp

  ;; "J" 'paredit-join-sexps
  "ws" 'paredit-split-sexp)

;; elisp
(evil-define-key 'normal emacs-lisp-mode-map
  (kbd "RET") 'eval-last-sexp)

(evil-define-key 'normal emacs-lisp-mode-map
    (kbd "<C-return>") 'eval-print-last-sexp-comment)

; magit
(use-package magit
  :ensure t
  :config
  (progn
    (setq magit-push-always-verify nil)
    (setq magit-revert-buffers t)))
(eval-after-load "magit"
  '(progn (define-key magit-mode-map (kbd "M-h") nil)))
(evil-set-initial-state 'magit-mode 'emacs)
(evil-set-initial-state 'magit-popup-mode 'emacs)
(evil-set-initial-state 'magit-refs-mode 'emacs)
(evil-set-initial-state 'magit-revision-mode 'emacs)

; python
(evil-define-key 'visual python-mode-map
  (kbd "RET") 'python-shell-send-region)

(evil-define-key 'normal python-mode-map
  "gs" 'python-shell-switch-to-shell)

; global evil key
(define-key evil-normal-state-map "L" 'helm-projectile-switch-to-buffer)
;; (define-key evil-normal-state-map "L" 'ido-switch-buffer)
;; (define-key evil-normal-state-map "L" 'helm-buffers-list)
(define-key evil-normal-state-map "H" 'projectile-project-buffers-other-buffer)
;; (define-key evil-normal-state-map "H" 'previous-buffer)
;; (define-key evil-normal-state-map "L" 'next-buffer)

; (define-key evil-insert-state-map (kbd "RET") 'newline-and-indent)

(setq evil-default-cursor '("DodgerBlue1" box)
      evil-normal-state-cursor '("gray" box)
      evil-emacs-state-cursor '("pink" box)
      evil-motion-state-cursor '("SeaGreen1" box)
      evil-insert-state-cursor '("white" bar)
      evil-visual-state-cursor '("white" hbar)
      evil-replace-state-cursor '("orange" hbar))

(global-set-key (kbd "RET") 'newline-and-indent)
(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)

(define-key evil-normal-state-map "Y" (kbd "y$"))

(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)
(define-key evil-normal-state-map "-" 'dired-jump)
(evil-define-key 'normal dired-mode-map "-" 'dired-up-directory)
;; (setq dired-isearch-filenames t)

(use-package coffee-mode
  :ensure t
  :config (evil-define-key 'visual coffee-mode-map "r" 'coffee-compile-region))
;; (setq coffee-indent-tabs-mode t)

(use-package web-mode
  :ensure t
  :config (progn 
            (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))))

(use-package jsx-mode
  :ensure t)

(display-time-mode 1)

(setq-default TeX-engine 'xetex)

(use-package js2-mode :ensure t)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; golang
(defun my-go-mode-hook ()
  (add-to-list (make-local-variable 'company-backends) 'company-go)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (go-eldoc-setup))

(add-hook 'go-mode-hook 'my-go-mode-hook)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)

(evil-set-initial-state 'ibuffer-mode 'normal)
(evil-define-key 'normal ibuffer-mode
  "j" 'ibuffer-forward-line
  "k" 'ibuffer-backward-line)

;; Don't wait for any other keys after escape is pressed.
(setq evil-esc-delay 0)

;; (require 'calfw)

(setq org-agenda-include-diary t)

(setq wg-prefix-key (kbd "C-a"))
(setq wg-mode-line-display-on t)

;; (workgroups-mode 1)

(require 'linum-relative)

(require 'volatile-highlights)
(volatile-highlights-mode t)

(add-hook 'after-init-hook 'global-company-mode)


(use-package elpy
  :ensure t
  :config (elpy-enable))

(use-package perspective
  :ensure t
  :config (persp-mode)
  :bind (("M-l" . persp-next)
         ("M-h" . persp-prev)))

(use-package persp-projectile
  :ensure t)

(global-set-key (kbd "M-/") 'hippie-expand)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(use-package deft
  :ensure t
  :config (setq deft-extension "org"
                deft-directory org-directory
                deft-text-mode 'org-mode
                deft-use-filename-as-title t))
(evil-set-initial-state 'deft-mode 'emacs)

(use-package org :ensure t)

(eval-after-load "org"
  '(progn (define-key org-mode-map (kbd "M-h") nil)
          (define-key org-mode-map (kbd "C-a") nil)))

(defun my-eshell-mode-hook ()
  (rename-uniquely)
  (define-key eshell-mode-map (kbd "C-a") nil)
  (define-key eshell-mode-map
    (kbd "M-p")
    'helm-eshell-history)
  (evil-define-key 'normal eshell-mode-map "^" 'eshell-bol))
(add-hook 'eshell-mode-hook 'my-eshell-mode-hook)

;; (setq ajb-bs-configuration "projectile")

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

(defun my-haskell-mode-hook ()
  (add-to-list (make-local-variable'company-backends) 'company-ghc)
  (ghc-init)
  (custom-set-variables '(company-ghc-show-info t)
                        '(haskell-process-type 'cabal-repl)))

(eval-after-load "haskell-mode"
  '(progn
    (define-key haskell-mode-map (kbd "C-x C-d") nil)
    (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
    (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
    (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
    (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
    (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
    (define-key haskell-mode-map (kbd "C-c M-.") nil)
    (define-key haskell-mode-map (kbd "C-c C-d") nil)))

(eval-after-load "haskell-interactive-mode"
  '(progn
     (define-key haskell-interactive-mode-map (kbd "C-a") nil)
     (evil-define-key 'normal haskell-interactive-mode-map "^" 'haskell-interactive-mode-beginning)))

(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

(setq guide-key/guide-key-sequence t)
(guide-key-mode 1)


(evil-set-initial-state 'image-mode 'emacs)

(evil-set-initial-state 'process-menu-mode 'emacs)

(setq doc-view-resolution 200)

(global-set-key (kbd "M-x") 'helm-M-x)

(use-package dictionary :ensure t)


(use-package list-processes+ :ensure t)

(use-package elnode :ensure t)

;; (use-package symon :ensure t)
;; (symon-mode)

(use-package hydra :ensure t)

(use-package discover :ensure t)
(global-discover-mode t)

(use-package winner
  :ensure t
  :config (winner-mode))

(use-package cypher-mode :ensure t)

(use-package yaml-mode :ensure t)
(use-package jade-mode :ensure t)
(use-package stylus-mode :ensure t)

(use-package paradox :ensure t)


(add-to-list 'load-path "~/.el")
(require 'org-conf)
(require 'mu4e-conf)
(require 'scheme-conf)
(require 'theme-conf)
(require 'misc-conf)
(require 'hydra-conf)

(define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
(define-key doc-view-mode-map (kbd "k") 'doc-view-previous-line-or-previous-page)

(use-package top-mode :ensure t)

; (require 'cfdg-mode)

(require 'kotlin-mode)
(add-to-list 'auto-mode-alist '("\\.kt\\'" . kotlin-mode))

(use-package android-mode :ensure t)
(custom-set-variables '(android-mode-sdk-dir "~/.android"))

(use-package gradle-mode :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))))

(use-package groovy-mode :ensure t)

(setq tramp-default-method "ssh")

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;; (use-package haxe-mode :ensure t)

(use-package tuareg :ensure t)

(use-package clojure-cheatsheet :ensure t)

(use-package helm-orgcard :ensure t)

(use-package circe :ensure t)

(use-package swiper :ensure t)
(setq swiper-completion-method 'helm)
(global-set-key "\C-s" 'swiper)

;; (use-package zone
;;   :config (zone-when-idle 120))

(use-package popwin :ensure t)
(popwin-mode 1)

;; (use-package 4clojure :ensure t)

(global-set-key (kbd "C-x C-l") 'list-processes)

(use-package helm-dash :ensure t)

(setq helm-dash-common-docsets '("Redis" "Clojure" "Python 3" "Java")) 

(global-set-key (kbd "C-x C-d") 'helm-dash)

(global-set-key (kbd "C-c C-p C-&") 'projectile-run-async-shell-command-in-root)
(global-set-key (kbd "C-c C-p") nil)

(use-package xkcd :ensure t)

(use-package sml-mode :ensure t)

(use-package aggressive-indent :ensure t)

;; (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'clojure-mode-hook #'aggressive-indent-mode)
;; (add-hook 'scheme-mode-hook #'aggressive-indent-mode)

(global-set-key (kbd "C-x C-f") 'dictionary-lookup-definition)

(use-package sx :ensure t)

(use-package foreman-mode :ensure t)
(evil-set-initial-state 'foreman-mode 'emacs)
(global-set-key (kbd "C-x C-p") 'foreman)

(use-package graphviz-dot-mode :ensure t)
(define-key graphviz-dot-mode-map (kbd "C-c C-c") 'graphviz-dot-preview)

(use-package focus :ensure t)

(use-package rust-mode :ensure t)

(use-package emmet-mode :ensure t)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

(use-package lfe-mode :ensure t)

(add-hook 'edebug-mode-hook (lambda ()
                                (if edebug-mode
                                    (evil-emacs-state)
                                  (evil-normal-state))))

(use-package pyenv-mode :ensure t)

(use-package avy :ensure t)

(use-package ranger :ensure t)

(evil-define-key 'normal helm-grep-mode
  (kbd "RET") 'helm-grep-mode-jump-other-window)

(use-package enlive :ensure t)

(require 'bing-dict)

(use-package litable :ensure t)

;; (use-package mediawiki :ensure t)

(use-package nginx-mode :ensure t)

(use-package eww-lnum :ensure t)
(eval-after-load "eww"
  '(progn (define-key eww-mode-map "f" 'eww-lnum-follow)
          (define-key eww-mode-map "F" 'eww-lnum-universal)))

(use-package ruby-mode :ensure t)
(add-to-list 'auto-mode-alist '("\\.cr\\'" . ruby-mode))

(use-package page-break-lines :ensure t)
(global-page-break-lines-mode)

(use-package helm-pages :ensure t)

(use-package wgrep-helm :ensure t)

(use-package nim-mode :ensure t)

(require 'local-conf nil 'noerror)
