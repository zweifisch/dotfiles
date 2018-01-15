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

;; (setq debug-on-error t)
(setq debug-on-error nil)

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

; (add-hook 'before-save-hook 'delete-trailing-whitespace)


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

(defvar my-packages '(elm-mode
                      use-package
                      volatile-highlights
                      know-your-http-well
                      bison-mode
                      ghc
                      company-ghc
                      guide-key))
(dolist (p my-packages)
  (when (not (package-installed-p p)) (package-install p)))

;; smart-tab
;; emms dired-sort auto-dictionnary
;; autopair google-maps
;; sr-speedbar typopunct


(require 'use-package)

; evil

(use-package evil :ensure t)
(use-package evil-indent-textobject :ensure t)
(use-package evil-matchit :ensure t)
(use-package evil-leader :ensure t)
(use-package evil-god-state :ensure t)

(evil-mode)

(setq-default evil-symbol-word-search t)

(evil-set-initial-state 'ibuffer-mode 'normal)
(evil-define-key 'normal ibuffer-mode
  "j" 'ibuffer-forward-line
  "k" 'ibuffer-backward-line)

;; Don't wait for any other keys after escape is pressed.
(setq evil-esc-delay 0)

(define-key evil-normal-state-map " " 'evil-toggle-fold)
(define-key evil-normal-state-map ";" 'evil-ex)
(define-key evil-normal-state-map (kbd "<up>") 'evil-scroll-line-up)
(define-key evil-normal-state-map (kbd "<down>") 'evil-scroll-line-down)

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
  "f" 'helm-projectile-find-file
  "F" 'helm-find-files
  ;; "B" 'ido-switch-buffer
  "B" 'helm-buffers-list
  ;; "b" 'projectile-switch-to-buffer
  "b" 'helm-projectile-switch-to-buffer
  "R" 'helm-recentf
  "r" 'helm-projectile-recentf
  "j" 'helm-bookmarks

  "A" 'org-agenda
  "h" 'helm-org-in-buffer-headings
  "t" 'org-narrow-to-subtree

  "g" 'helm-projectile-grep
  "G" 'ag-project
  "o" 'browse-url
  "e" 'eshell-here
  "E" 'switch-to-shell-in-project
  ;; "i" 'ein:notebooklist-open
  "c" 'org-capture
  "s" 'magit-status
  "a" 'avy-goto-word-or-subword-1
  ;; "v" 'wg-switch-to-workgroup
  "V" 'projectile-persp-switch-project
  "v" 'persp-switch
  ;; "v" 'helm-projectile-switch-project
  "m" 'mu4e
  "d" 'dictionary-search
  "D" 'bing-dict-at-point)

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

; evil-nerd-commenter
(eval-after-load 'evil-nerd-commenter-operator
  '(progn
     (define-key evil-normal-state-map "gc" 'evilnc-comment-operator)
     (define-key evil-visual-state-map "gc" 'evilnc-comment-operator)))

(use-package evil-nerd-commenter :ensure t)

(use-package evil-surround :ensure t
  :config (global-evil-surround-mode 1))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.wiki$" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package help-fns+ :ensure t)

; projectile
(use-package projectile
  :ensure t
  :config
  (progn
    (projectile-global-mode)
    (setq projectile-completion-system 'helm
          projectile-switch-project-action 'projectile-dired
          projectile-remember-window-configs t
          projectile-use-git-grep 1)))

(use-package helm :ensure t
  :config
  (progn
    (use-package helm-config)
    (setq helm-grep-file-path-style 'relative)
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

(use-package ag :ensure t)

; python
;; (use-package python-mode :ensure t)
(use-package flycheck :ensure t)
(use-package elpy
  :ensure t
  :config (elpy-enable))
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

; python
(evil-define-key 'visual python-mode-map
  (kbd "RET") 'python-shell-send-region)

(evil-define-key 'normal python-mode-map
  "gs" 'python-shell-switch-to-shell)

(add-hook 'python-mode-hook 'flycheck-mode)

; shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq-default truncate-lines t)

(use-package exec-path-from-shell :ensure t)
(exec-path-from-shell-initialize)

; sql
(evil-define-key 'visual sql-mode-map
  (kbd "RET") 'sql-send-region)

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
                  cider-pprint-fn 'puget
                  cider-repl-pop-to-buffer-on-connect nil
                  cider-popup-stacktraces t
                  cider-repl-use-pretty-printing t
                  cider-repl-popup-stacktraces t)))

(use-package paredit
  :ensure t
  :config (progn (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
                 (add-hook 'scheme-mode-hook 'paredit-mode)))

(use-package clj-refactor :ensure t)
(use-package rainbow-delimiters :ensure t)

(defun my-clojure-mode-hook ()
  (paredit-mode)
  (rainbow-delimiters-mode)
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package clojure-mode
  :ensure t
  :config (progn
            (add-hook 'clojure-mode-hook 'my-clojure-mode-hook)))

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

; elixir
(use-package alchemist
  :ensure t)

(use-package elixir-mode
  :ensure t)

; global evil key
;; (define-key evil-normal-state-map "L" 'helm-projectile-switch-to-buffer)
;; (define-key evil-normal-state-map "L" 'ido-switch-buffer)
(define-key evil-normal-state-map "L" 'helm-mini)
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
(add-hook 'dired-mode-hook 'auto-revert-mode)
;; (setq dired-isearch-filenames t)
(setq dired-dwim-target t)

(use-package coffee-mode
  :ensure t
  :config (evil-define-key 'visual coffee-mode-map "r" 'coffee-compile-region))
;; (setq coffee-indent-tabs-mode t)

(use-package web-mode
  :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
            (setq-default web-mode-comment-formats (remove '("javascript" . "/*") web-mode-comment-formats))
            (add-to-list 'web-mode-comment-formats '("javascript" . "//"))))

;; (use-package vue-mode :ensure t)

(display-time-mode 1)

(setq-default TeX-engine 'xetex)

(use-package js2-mode
  :ensure t
  :config (progn
            (setq js2-strict-missing-semi-warning nil)
            (setq js2-strict-trailing-comma-warning nil)
            (setq js2-mode-assume-strict t)
            (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))))

;; golang

(use-package go-mode :ensure t)
(use-package go-eldoc :ensure t)
(use-package company-go :ensure t)
(exec-path-from-shell-copy-env "GOPATH")

(defun my-go-mode-hook ()
  (add-to-list (make-local-variable 'company-backends) 'company-go)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (go-eldoc-setup))

(add-hook 'go-mode-hook 'my-go-mode-hook)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)


(require 'volatile-highlights)
(volatile-highlights-mode t)

(use-package company :ensure t
  :config (add-hook 'after-init-hook 'global-company-mode))

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

(use-package org :ensure t
  :bind (:map org-mode-map
              ("M-h" . nil)
              ("C-a" . nil)))

(defun my-eshell-mode-hook ()
  (rename-uniquely)
  (define-key eshell-mode-map (kbd "C-a") nil)
  (define-key eshell-mode-map
    (kbd "M-p")
    'helm-eshell-history)
  (evil-define-key 'normal eshell-mode-map "^" 'eshell-bol))
(add-hook 'eshell-mode-hook 'my-eshell-mode-hook)

;; (setq ajb-bs-configuration "projectile")

(add-hook 'haskell-mode-hook 'haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-decl-scan-mode)

(setq haskell-process-type 'stack-ghci)
(setq haskell-process-path-ghci "stack")
(setq haskell-process-args-ghci "ghci")

(eval-after-load "haskell-interactive-mode"
  '(progn
     (define-key haskell-interactive-mode-map (kbd "C-a") nil)
     (evil-define-key 'normal haskell-interactive-mode-map "^" 'haskell-interactive-mode-beginning)))

(use-package hindent :ensure t)
(add-hook 'haskell-mode-hook #'hindent-mode)

(use-package flycheck-haskell :ensure t)

(add-hook 'haskell-mode-hook 'flycheck-mode)
(add-hook 'flycheck-mode-hook 'flycheck-haskell-configure)

;; (use-package company-ghci :ensure t)
;; (push 'company-ghci company-backends)
;; (add-hook 'haskell-mode-hook 'company-mode)


;; (setq guide-key/guide-key-sequence t)
;; (guide-key-mode 1)


(evil-set-initial-state 'image-mode 'emacs)

(evil-set-initial-state 'process-menu-mode 'emacs)

(setq doc-view-resolution 200)

(global-set-key (kbd "M-x") 'helm-M-x)

(use-package dictionary :ensure t)


(use-package list-processes+ :ensure t)

(use-package elnode :ensure t)

;; (use-package symon :ensure t)
;; (symon-mode)

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
(require 'shell-switch)
(require 'misc-conf)
(require 'eww-conf)

(define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
(define-key doc-view-mode-map (kbd "k") 'doc-view-previous-line-or-previous-page)

; (require 'cfdg-mode)

(require 'kotlin-mode)
(add-to-list 'auto-mode-alist '("\\.kt\\'" . kotlin-mode))

(use-package android-mode :ensure t)

(use-package gradle-mode :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))))

(use-package groovy-mode :ensure t)

(setq tramp-default-method "ssh")
(setq tramp-default-user "root")

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;; (use-package haxe-mode :ensure t)

(use-package tuareg :ensure t)

(use-package clojure-cheatsheet :ensure t)

(use-package helm-orgcard :ensure t)

(use-package circe :ensure t)

;; (use-package swiper :ensure t)
;; (setq swiper-completion-method 'helm)
;; (global-set-key "\C-s" 'swiper)

(use-package helm-swoop :ensure t)
(global-set-key "\C-s" 'helm-swoop)

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

(evil-define-key 'normal helm-grep-mode-map
  (kbd "RET") 'helm-grep-mode-jump-other-window)

(use-package enlive :ensure t)

(require 'bing-dict)

(use-package litable :ensure t)

;; (use-package mediawiki :ensure t)

(use-package nginx-mode :ensure t)

(use-package ruby-mode :ensure t)
(add-to-list 'auto-mode-alist '("\\.cr\\'" . ruby-mode))

(use-package page-break-lines :ensure t)
(global-page-break-lines-mode)

(use-package helm-pages :ensure t)

(use-package wgrep-helm :ensure t)

(use-package nim-mode :ensure t)

(require 'evil-indent-textobject)

(evil-set-initial-state 'epa-key-list-mode 'emacs)

(use-package shell-pop :ensure t)

(defun npm-test ()
  "npm test"
  (interactive)
  (let ((compilation-save-buffers-predicate 'ignore)
        (compilation-ask-about-save nil))
    (compile "npm test" t)))

(defun npm-lint ()
  "npm test"
  (interactive)
  (let ((compilation-save-buffers-predicate 'ignore)
        (compilation-ask-about-save nil))
    (compile "npm run lint" t)))

(use-package term
  :config
  (evil-set-initial-state 'term-mode 'emacs)
  :bind (:map term-raw-map
              ("M-h" . nil)
              ("M-l" . nil)
              ("M-x" . nil)
              ("C-a" . nil)
              ("C-t" . nil)))

(use-package slime :ensure t)

(use-package multi-term :ensure t
  :config
  (setq multi-term-program "/bin/zsh"))

(require 'local-conf nil 'noerror)

(add-to-list 'comint-preoutput-filter-functions
             (lambda (output)
               (replace-regexp-in-string "\\[0G" "" output)))

(use-package extempore-mode :ensure t)

(use-package fsharp-mode :ensure t)

(use-package toml-mode :ensure t)

(use-package merlin :ensure t
  :config (progn
            (add-hook 'tuareg-mode-hook 'merlin-mode t)
            (add-hook 'caml-mode-hook 'merlin-mode t)
            (setq merlin-use-auto-complete-mode 'easy)
            (setq merlin-command 'opam)))

(use-package image+ :ensure t)

(eval-after-load 'image+ '(imagex-auto-adjust-mode 1))

(use-package processing-mode :ensure t
  :config (progn
            (setq processing-location "~/.processing/processing-java")
            (setq processing-application-dir "~/.processing")
            (setq processing-sketchbook-dir "~/sketchbook"))
  :bind (:map processing-mode-map
              ("C-c C-c" . processing-sketch-run)))

(setq dictionary-server "localhost")

(use-package typescript-mode :ensure t)

(use-package ponylang-mode :ensure t)

(use-package ob-async :ensure t)

(use-package puppet-mode :ensure t)

(defun insert-image-from-url ()
  (interactive)
  (let* ((path (read-string "url: " (car kill-ring)))
         (basename (concat (md5 path) "." (file-name-extension path)))
         (img (expand-file-name basename
               (file-name-directory buffer-file-name))))
    (unless (file-exists-p img)
      (url-copy-file path img))
    (insert (concat "[[file:" basename "]]"))
    (org-display-inline-images)))

(defun get-content-from-clipboard (format)
   (with-current-buffer (get-buffer-create "*clipboard*")
     (erase-buffer)
     (call-process "xclip" nil t nil "-selection" "clipboard" "-t" format "-o")
     (current-buffer)))

(defun insert-image-from-clipboard (mime ext)
  (let* ((dirname (file-name-directory buffer-file-name))
         (imagename
          (with-current-buffer (get-content-from-clipboard mime)
            (let ((filename (format "%s.%s" (md5 (current-buffer) nil nil 'no-conversion) ext)))
              (write-region nil nil (format "%s/%s" dirname filename))
              filename))))
    (insert (format "[[file:%s]]" imagename))
    (org-display-inline-images)))

(defun insert-image-from-clipbarod-as-jpeg ()
  (interactive)
  (insert-image-from-clipboard "image/jpeg" "jpg"))

(defun insert-image-from-clipbarod-as-png ()
  (interactive)
  (insert-image-from-clipboard "image/png" "png"))

(use-package pdf-tools :ensure t
  :config (progn
            (evil-make-overriding-map pdf-view-mode-map 'normal)
            (evil-define-key 'normal pdf-view-mode-map
              "gg" 'pdf-view-first-page
              "G" 'pdf-view-last-page
              "h" 'pdf-view-previous-page-command
              "j" (lambda () (interactive) (pdf-view-next-line-or-next-page 5))
              "k" (lambda () (interactive) (pdf-view-previous-line-or-previous-page 5))
              "l" 'pdf-view-next-page-command)
              (kbd "C-o") 'pdf-history-backward
              (kbd "C-i") 'pdf-history-forward
              "m" 'pdf-view-position-to-register
              "'" 'pdf-view-jump-to-register
              "/" 'pdf-occur
              "o" 'pdf-outline
              "f" 'pdf-links-action-perform
              "b" 'pdf-view-midnight-minor-mode))

(pdf-tools-install)


(defun eshell-here ()
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

(defun eshell/x ()
    (delete-window)
    (eshell/exit))

(defun dump-url-at-point ()
  (interactive)
  (save-excursion
    (let ((url (read-string "url: " (thing-at-point 'url))))
      (end-of-line)
      (open-line 1)
      (next-line 1)
      (insert
       (shell-command-to-string (format "w3m -dump '%s'" url))))))

(use-package ansible-doc :ensure t)

(use-package hackernews :ensure t)

(use-package fcitx :ensure t
  :config (progn
            (fcitx-aggressive-setup)
            (setq fcitx-use-dbus t)))

(use-package dockerfile-mode :ensure t)

(add-to-list 'auto-mode-alist '("\\.g4\\'" . antlr-mode))
