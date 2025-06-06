(blink-cursor-mode -1)

;; (setq url-gateway-method 'socks)
;; (setq socks-server '("Default server" "127.0.0.1" 13659 5))

(setq initial-scratch-message ""
      inhibit-startup-message t
      visible-bell nil)

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
; (add-to-list 'package-archives
;             '("melpa" . "http://melpa.org/packages/") t)
; (add-to-list 'package-archives
;              '("org" . "http://orgmode.org/elpa/") t)

(setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
			 ("nongnu" . "http://mirrors.ustc.edu.cn/elpa/nongnu/")))

;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(elm-mode
                      use-package
                      volatile-highlights
                      know-your-http-well
                      bison-mode
                      ; ghc
                      ; company-ghc
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

(define-key minibuffer-local-completion-map (kbd "SPC") nil)

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

(defun zf/open-in-tmux ()
  "open current path in tmux"
  (interactive)
  (shell-command-to-string
   (format "tmux new-window -c %s" default-directory)))

(defun zf/open-project-in-tmux ()
  "open current project in tmux"
  (interactive)
  (shell-command-to-string
   (format "tmux new-window -c %s" (vc-root-dir))))

; evil-leader
(evil-leader/set-key
  ;; "F" 'projectile-find-file
  "f" 'helm-projectile-find-file
  "F" 'helm-find-files
  "z" 'helm-semantic-or-imenu
  ;; "B" 'ido-switch-buffer
  ;; "B" 'helm-buffers-list
  "B" 'helm-mini
  ;; "b" 'projectile-switch-to-buffer
  "b" 'helm-projectile-switch-to-buffer
  "R" 'helm-recentf
  "r" 'helm-projectile-recentf
  "j" 'helm-bookmarks

  "A" 'org-agenda
  "h" 'helm-org-in-buffer-headings

  ;; "t" 'org-narrow-to-subtree
  ;; "T" 'widen
  "t" 'lsp-treemacs-symbols
  "T" 'treemacs

  "i" 'helm-imenu

  "g" 'helm-projectile-grep
  ;; "g" 'helm-projectile-ag
  ;; "g" 'helm-projectile-rg
  "G" 'ag-project
  "o" 'zf/open-in-tmux
  "O" 'zf/open-project-in-tmux
  ;; "e" 'eshell-here
  ;; "e" 'switch-to-shell-in-project

  ;; "e" 'multi-vterm-project
  ;; "E" 'multi-vterm-dedicated-toggle

  ;; "i" 'ein:notebooklist-open
  "c" 'org-capture
  "s" 'magit-status
  "a" 'avy-goto-word-or-subword-1
  ;; "v" 'wg-switch-to-workgroup
  ;; "V" 'projectile-persp-switch-project
  "v" 'persp-switch
  "V" 'helm-projectile-switch-project
  ;; "m" 'mu4e
  "d" 'dictionary-search
  "D"  'youdao-dictionary-search-at-point
  ;; "D" 'bing-dict-at-point
  )

(global-evil-leader-mode)
(evil-leader/set-leader "|")
(evil-define-key 'normal global-map
  "gj" 'avy-goto-word-or-subword-1
  "," 'evil-execute-in-god-state)

;; (setq projectile-use-git-grep nil)
(setq projectile-use-git-grep t)
(setq helm-ag-insert-at-point 'symbol)

(defun zf/use-git-grep ()
  (interactive)
  (setq projectile-use-git-grep (if projectile-use-git-grep nil t)))

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
(global-set-key (kbd "C-a f") 'switch-window)

; recentf
(recentf-mode 1)
(setq recentf-max-saved-items 512)

; evil-nerd-commenter
(eval-after-load 'evil-nerd-commenter-operator
  '(progn
     (define-key evil-normal-state-map "gc" 'evilnc-comment-operator)
     (define-key evil-visual-state-map "gc" 'evilnc-comment-operator)))

(use-package evil-nerd-commenter :ensure t)

(use-package undo-tree :ensure t)
(setq undo-tree-auto-save-history nil)
(global-undo-tree-mode)
(evil-set-undo-system 'undo-tree)
(setq undo-tree-history-directory-alist '(("." . "~/tmp/undo")))

(use-package evil-surround :ensure t
  :config (global-evil-surround-mode 1))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.wiki$" . markdown-mode))
  :config
  (setq markdown-fontify-code-blocks-natively t)
  :bind (:map markdown-mode-map
              ("C-c C-c" . zf/exec-line-as-sh-fenced))
  :init
  (setq markdown-command "multimarkdown"))

; (use-package help-fns+ :ensure t)

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

;; (setq projectile-use-git-grep nil)

(use-package helm :ensure t
  :config
  (progn
    ;; (use-package helm-config)
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

(use-package helm-rg :ensure t)

(use-package rg :ensure t)

(use-package ag :ensure t)

; python
;; (use-package python-mode :ensure t)
;; (use-package elpy
;;   :ensure t
;;   :config (elpy-enable))
;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args ""
;;       python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;       python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;       python-shell-completion-setup-code
;;       "from IPython.core.completerlib import module_completion"
;;       python-shell-completion-module-string-code
;;       "';'.join(module_completion('''%s'''))\n"
;;       python-shell-completion-string-code
;;       "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

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
              "gd" 'cider-find-var
              "gn" 'cider-find-ns
              "gb" 'cider-pop-back
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

; (use-package clj-refactor :ensure t)
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

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((elixir-mode . lsp-deferred))
  :custom
  (lsp-elixir-server-command '("~/.elixir-ls/release/language_server.sh"))
  (lsp-elixir-mix-env "dev")
  (lsp-keymap-prefix "C-c l"))

;; (add-hook 'elixir-mode-hook
;;           (lambda ()
;;             (add-hook 'before-save-hook #'elixir-format nil t)))

                                        ; global evil key
;; (define-key evil-normal-state-map "L" 'helm-projectile-switch-to-buffer)
;; (define-key evil-normal-state-map "L" 'ido-switch-buffer)
(define-key evil-normal-state-map "H" 'projectile-project-buffers-other-buffer)
;; (define-key evil-normal-state-map "H" 'previous-buffer)
;; (define-key evil-normal-state-map "L" 'next-buffer)

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
  :mode (("\\.tsx$" . web-mode)
         ("\\.vue\\'" . web-mode))
  :ensure t
  :init
  (add-hook 'web-mode-hook 'variable-pitch-mode)
  (add-hook 'web-mode-hook 'company-mode)
  ;; (add-hook 'web-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook (lambda () (setq web-mode-markup-indent-offset 2
                                            web-mode-code-indent-offset 2)))
  (add-hook 'web-mode-hook (lambda ()
                             (when (string-equal "tsx" (file-name-extension buffer-file-name))
                               (setup-tide-mode)))))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))


(setq css-indent-offset 2)

(add-to-list 'auto-mode-alist '("\\.acss\\'" . css-mode))


(add-hook 'web-mode-hook
          (lambda ()
            (if (equal web-mode-content-type "javascript")
                (web-mode-set-content-type "jsx"))))

(evil-define-key 'normal web-mode-map
  (kbd "%") 'web-mode-navigate
  (kbd "SPC") 'web-mode-fold-or-unfold)

;; (use-package vue-mode :ensure t)

(display-time-mode 1)

(setq-default TeX-engine 'xetex)

(use-package js2-mode
  :ensure t
  :config (progn
            (setq js2-strict-missing-semi-warning nil)
            (setq js2-strict-trailing-comma-warning nil)
            (setq js2-mode-assume-strict t)
            (setq js2-basic-offset 2)
            (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
            (add-to-list 'auto-mode-alist '("\\.cjs\\'" . js2-mode))))


(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)


(require 'volatile-highlights)
(volatile-highlights-mode t)

(use-package perspective
  :ensure t
  :init (persp-mode)
  :custom
  (persp-mode-prefix-key (kbd "C-c M-p"))
  ;; :bind (("M-l" . persp-next)
         ;; ("M-h" . persp-prev))
  )

(use-package persp-projectile
  :ensure t)

(global-set-key (kbd "M-/") 'hippie-expand)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "M-l") 'windmove-swap-states-right)
(global-set-key (kbd "M-h") 'windmove-swap-states-left)

;; (use-package deft
;;   :ensure t
;;   :config (setq deft-extension "org"
;;                 deft-directory org-directory
;;                 deft-text-mode 'org-mode
;;                 deft-use-filename-as-title t))
;; (evil-set-initial-state 'deft-mode 'emacs)

(use-package org :ensure t
  :bind (:map org-mode-map
              ("M-h" . nil)
              ("C-a" . nil)
              ("M-n" . 'outline-next-visible-heading)
              ("M-p" . 'outline-previous-visible-heading)))

(defun eshell/x ()
    (delete-window)
    (eshell/exit))

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
(evil-set-initial-state 'xref--xref-buffer-mode 'emacs)

(setq doc-view-resolution 200)

(global-set-key (kbd "M-x") 'helm-M-x)

(use-package dictionary :ensure t)


; (use-package list-processes+ :ensure t)

(use-package elnode :ensure t)

;; (use-package symon :ensure t)
;; (symon-mode)

;; (use-package discover :ensure t)
;; (global-discover-mode t)

(use-package winner
  :ensure t
  :config (winner-mode))

(use-package cypher-mode :ensure t)

(use-package yaml-mode :ensure t)
; (use-package jade-mode :ensure t)
; (use-package stylus-mode :ensure t)

(use-package paradox :ensure t)


(add-to-list 'load-path "~/.el")
(require 'org-conf)
; (require 'mu4e-conf)
; (require 'scheme-conf)
(require 'theme-conf)
(require 'shell-switch)
;; (require 'shell-conf)
(require 'misc-conf)
(require 'eww-conf)
(require 'npm-scripts)

; (define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
; (define-key doc-view-mode-map (kbd "k") 'doc-view-previous-line-or-previous-page)

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

; (use-package clojure-cheatsheet :ensure t)

(use-package helm-org :ensure t)

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

(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))

(use-package company :ensure t
  :config )

(use-package company
  :ensure t
  :hook ((prog-mode . company-mode)
         (elixir-mode . company-mode))
  :config (progn
            (setq company-tooltip-align-annotations t)
            (setq company-minimum-prefix-length 1)
            ;; (add-hook 'after-init-hook 'global-company-mode)
            ))



(yas-global-mode)



(use-package lsp-mode
  :config
  (setq lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting t
        lsp-enable-snippet nil  ;; Not supported by company capf, which is the recommended company backend
        lsp-pyls-plugins-flake8-enabled t)
  (lsp-register-custom-settings
   '(("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" nil t)
     ("pyls.plugins.pyls_black.enabled" t t)
     ("pyls.plugins.pyls_isort.enabled" t t)

     ;; Disable these as they're duplicated by flake8
     ("pyls.plugins.pycodestyle.enabled" nil t)
     ("pyls.plugins.mccabe.enabled" nil t)
     ("pyls.plugins.pyflakes.enabled" nil t)))
  :hook
  ((python-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :bind (:map evil-normal-state-map
              ("gh" . lsp-describe-thing-at-point)))

(setq lsp-deferred t)  ; Defer LSP server start until a Python file is opened

(use-package lsp-ui
  :config (setq lsp-ui-sideline-show-hover t
                lsp-ui-sideline-delay 0.5
                lsp-ui-doc-delay 5
                lsp-ui-sideline-ignore-duplicates t
                lsp-ui-doc-position 'bottom
                lsp-ui-doc-alignment 'frame
                lsp-ui-doc-header nil
                lsp-ui-doc-include-signature t
                lsp-ui-doc-use-childframe t)
  :commands lsp-ui-mode
  :bind (:map evil-normal-state-map
              ("gd" . lsp-ui-peek-find-definitions)
              ("gb" . pop-global-mark)
              ("gr" . lsp-ui-peek-find-references)))

(setenv "WORKON_HOME" "/opt/homebrew/anaconda3/envs")

;; (use-package pyvenv
;;   :demand t
;;   :config
;;   (pyvenv-tracking-mode 1))
                                        ; Automatically use pyvenv-workon via dir-locals



(use-package rust-mode
  :ensure t
  :hook (rust-mode . lsp))

;; Add keybindings for interacting with Cargo
(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode)
  :config (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common))

;; (use-package flycheck-rust
;;   :ensure t
;;   :hook (flycheck-mode-hook . flycheck-rust-setup))

(setq company-tooltip-align-annotations t)



(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

;; golang

(use-package go-mode
  :ensure t
  :config (progn
            (add-to-list (make-local-variable 'company-backends) 'company-go)
            (setq gofmt-command "goimports")
            (add-hook 'before-save-hook 'gofmt-before-save)
            (go-eldoc-setup)
            
            (evil-define-key 'normal go-mode-map
              "gd" 'godef-jump
              "gD" 'godef-jump-other-window
              "K" 'godef-describe)
            (evil-define-key 'normal godoc-mode-map
              "q" 'quit-window
              "g?" 'describe-mode)))

(use-package go-eldoc :ensure t)
(use-package company-go :ensure t)
(exec-path-from-shell-copy-env "GOPATH")

;; go install golang.org/x/tools/gopls@latest
(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'go-mode-hook #'yas-minor-mode)




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

(evil-set-initial-state 'comint-mode 'normal)

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

(use-package youdao-dictionary :ensure t)

(use-package typescript-mode :ensure t)

(use-package ponylang-mode :ensure t)

(use-package ob-async :ensure t)

(use-package puppet-mode :ensure t)

(defun insert-image-from-url ()
  (interactive)
  (let* ((path (read-string "url: " (car kill-ring)))
         (basename (concat "images/" (md5 path) "." (file-name-extension path)))
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

(defun insert-image-from-clipboard (folder mime ext)
  (let* ((dirname (file-name-directory buffer-file-name))
         (imagename
          (with-current-buffer (get-content-from-clipboard mime)
            (let ((filename (format "%s/%s.%s" folder (md5 (current-buffer) nil nil 'no-conversion) ext)))
              (write-region nil nil (format "%s/%s" dirname filename))
              filename))))
    (insert (format "[[file:%s]]" imagename))
    (org-display-inline-images)))

(defun insert-image-from-clipbarod-as-jpeg ()
  (interactive)
  (insert-image-from-clipboard "images" "image/jpeg" "jpg"))

(defun insert-image-from-clipbarod-as-png ()
  (interactive)
  (insert-image-from-clipboard "images" "image/png" "png"))

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

;; (pdf-tools-install)


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

;; (use-package fcitx :ensure t
;;   :config (progn
;;             (fcitx-aggressive-setup)
;;             (setq fcitx-use-dbus t)))

; (use-package rainbow-mode :ensure t)

(use-package dockerfile-mode :ensure t)

(add-to-list 'auto-mode-alist '("\\.g4\\'" . antlr-mode))

(use-package protobuf-mode :ensure t)

(use-package lua-mode :ensure t)

(defun format-query-at-point ()
  (interactive)
  (save-excursion
    (let* ((url (read-string "url: " (thing-at-point 'sentence)))
           (query (url-parse-query-string url)))
      (end-of-line)
      (open-line 1)
      (next-line 1)
      (insert
       (string-join
        (-map (lambda (x) (concat "|" (car x) "|" (cadr x) "|")) query) "\n")))))

(use-package switch-window :ensure t
  :config (progn
            (setq switch-window-shortcut-style 'qwerty)))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . setup-tide-mode)))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq typescript-indent-level
        (or (plist-get (tide-tsfmt-options) ':indentSize) 2))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  (evil-define-key 'normal tide-mode-map
    "gr" 'xref-find-references
    "gd" 'tide-jump-to-definition
    "gb" 'tide-jump-back))

(evil-define-key 'normal tide-references-mode-map
  "j" 'tide-find-next-reference
  "k" 'tide-find-previous-reference
  "q" 'quit-window
  (kbd "RET") 'tide-goto-reference)

(setq company-tooltip-align-annotations t)

(defun rfc-at-point ()
  (interactive)
  (save-excursion
    (let ((rfc (read-string
                 "rfc: "
                 (replace-regexp-in-string "[^0-9]*" "" (thing-at-point 'word)))))
      (rfc-open rfc))))

(defun rfc-view ()
  (interactive)
  (save-excursion
    (let ((rfc (read-string "rfc: ")))
      (rfc-open rfc))))

(defun rfc-open (number)
  (let* ((txt (format "/usr/share/doc/RFC/links/rfc%s.txt" rfc))
         (gz (concat txt ".gz")))
    (cond ((file-readable-p txt) (find-file txt))
          ((file-readable-p gz) (find-file gz)))))

(defun search-google-at-point ()
  (interactive)
  (save-excursion
    (let ((keywords (thing-at-point 'line)))
      (browse-url-xdg-open (concat "https://www.google.com/search?q=" keywords)))))

(add-to-list 'auto-mode-alist
             '("/\\(rfc\\|std\\)[0-9]+\\.txt\\'" . rfcview-mode))
(autoload 'rfcview-mode "rfcview" nil t)

(evil-define-key 'normal rfcview-mode-map
  (kbd "TAB") 'rfcview-next-button
  (kbd "RET") 'rfcview-maybe-goto-link)

(defun floating-number-at-point ()
  (when (search-backward-regexp "[^0-9.]" nil 'noerror)
    (goto-char (match-end 0))
    (search-forward-regexp "[0-9.]+" nil 'noerror)
    (string-to-number
     (match-string 0))))

(defun zf/deduct-number-at-point ()
  (interactive)
  (save-excursion
    (let ((num (floating-number-at-point)))
      (zf/deduct-number num))))

(defun zf/deduct-number (num)
  (end-of-line)
  (open-line 1)
  (next-line 1)
  (insert "| 97% | 97.5% | 98% | 98.5% | 100% | 101.5% | 102% | 102.5% | 103% |\n")
  (insert (format "| %0.4f | %0.4f | %0.4f | %0.4f | %0.4f | %0.4f | %0.4f | %0.4f | %0.4f |"
                  (* num 0.97) (* num 0.975) (* num 0.98) (* num 0.985) num (* num 1.015) (* num 1.02) (* num 1.025) (* num 1.03))))

(defun calc-line-at-point ()
  (interactive)
  (save-excursion
    (let ((expr (thing-at-point 'line)))
      (end-of-line)
      (insert (format " = %s" (calc-eval expr))))))

(defun qr-encode-region (start end)
  (interactive "r")
  (let ((buffer "QR"))
    (kill-buffer (get-buffer-create buffer))
    (call-process-region start end "qrencode"
                         nil buffer nil
                         "-t" "utf8" "-s" "6" "-o" "-")
    (switch-to-buffer buffer)))

; (use-package pinentry :ensure t)
(setenv "INSIDE_EMACS" (format "%s,comint" emacs-version))
; (pinentry-start)

(setq ring-bell-function 'ignore)

(defun zf/copy-path ()
  "copy full path of current buffer."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (progn
          (message file-name)
          (kill-new file-name))
      (error "Buffer not visiting a file"))))

(defun zf/copy-path-with-line-number ()
  "Copy full path of current buffer with current line number."
  (interactive)
  (let ((file-name (buffer-file-name))
        (line-number (line-number-at-pos)))
    (if file-name
        (let ((full-path (format "%s:%d" file-name line-number)))
          (message full-path)
          (kill-new full-path))
      (error "Buffer not visiting a file"))))

(setq require-final-newline nil)

(defun zf/ob-copy-src-block ()
  (interactive)
  (org-edit-src-code)
  (mark-whole-buffer)
  (kill-ring-save 1 (point-max))
  (org-edit-src-abort))

(defun zf/kill-all()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer 
          (delq (current-buffer) 
                (remove-if-not 'buffer-file-name (buffer-list)))))

(defun zf/kill-buffers (regexp)
  "Kill buffers matching REGEXP without asking for confirmation."
  (interactive "sKill buffers matching this regular expression: ")
  (flet ((kill-buffer-ask (buffer) (kill-buffer buffer)))
    (kill-matching-buffers regexp)))

(use-package plantuml-mode :ensure t
  :config (progn
            (setq plantuml-jar-path (expand-file-name "~/.plantuml.jar"))))

(use-package purescript-mode :ensure t)

(use-package psc-ide :ensure t
  :config
  (add-hook 'purescript-mode-hook
            (lambda ()
              (psc-ide-mode)
              (company-mode)
              (flycheck-mode)
              (turn-on-purescript-indentation))))

(use-package string-inflection :ensure t)


(use-package graphql-mode :ensure t)

(use-package focus :ensure t)

(use-package racket-mode :ensure t)

(use-package feature-mode :ensure t)

(use-package dart-mode :ensure t)

(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/notes/org")
      :bind (:map org-roam-mode-map
              (("C-r C-r" . org-roam)
               ("C-r C-f" . org-roam-find-file)
               ("C-r C-g" . org-roam-graph))
              :map org-mode-map
              (("C-r C-i" . org-roam-insert))
              (("C-r C-I" . org-roam-insert-immediate))))

(put 'narrow-to-region 'disabled nil)

; (use-package vterm :ensure t)

(use-package deft
  :ensure t
  :config (setq deft-extension "org"
                deft-directory org-directory
                deft-text-mode 'org-mode
                deft-use-filename-as-title t))
(evil-set-initial-state 'deft-mode 'emacs)

; (use-package multi-vterm :ensure t)

;; (use-package multi-vterm
;; 	:config
;; 	(add-hook 'vterm-mode-hook
;; 			(lambda ()
;; 			(setq-local evil-insert-state-cursor 'box)
;; 			(evil-insert-state)))
;; 	(define-key vterm-mode-map [return]                      #'vterm-send-return)
;;     (unbind-key "C-a" vterm-mode-map)
;; 	(setq vterm-keymap-exceptions nil)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-e")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-f")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-v")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-b")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-w")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-u")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-n")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-m")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-p")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-j")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-k")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-r")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-t")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-g")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-c")      #'vterm--self-insert)
;; 	(evil-define-key 'insert vterm-mode-map (kbd "C-SPC")    #'vterm--self-insert)
;; 	(evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
;; 	(evil-define-key 'normal vterm-mode-map (kbd ",c")       #'multi-vterm)
;; 	(evil-define-key 'normal vterm-mode-map (kbd ",n")       #'multi-vterm-next)
;; 	(evil-define-key 'normal vterm-mode-map (kbd ",p")       #'multi-vterm-prev)
;; 	(evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
;; 	(evil-define-key 'normal vterm-mode-map (kbd "o")        #'evil-insert-resume)
;; 	(evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume))

(setq server-name "server")

;; (require 'peg-mode)


(defun zf/rustc-current-file ()
  "rustc"
  (interactive)
  (let ((compilation-save-buffers-predicate 'ignore)
        (compilation-ask-about-save nil))
    (compile (concat "rustc -o tmp --edition 2021 " (buffer-file-name) " && ./tmp") t)))

(defun zf/rustc-expand-current-file ()
  "rustc"
  (interactive)
  (let ((compilation-save-buffers-predicate 'ignore)
        (compilation-ask-about-save nil))
    (compile (concat "rustc -Zunpretty=expanded " (buffer-file-name)) t)))


;; (use-package beacon
;;   :ensure t)

;; (beacon-mode 1)


(use-package envrc
  :ensure t
  :config (envrc-global-mode))

(use-package treemacs
  :ensure t
  :defer t
  :config
  (setq treemacs-width 60)
  (setq treemacs-display-icons-p nil)
  (setq treemacs-header-icons-p nil)
  )

;; :bind (:map treemacs-mode-map (("j" . treemacs-next-line) ("k" . treemacs-previous-line)))

(use-package treemacs-evil
  :ensure t)

;; Optional: Integrate with lsp-mode for symbol outline
(use-package lsp-treemacs
  :after (lsp treemacs)
  :ensure t
  :config
  (lsp-treemacs-sync-mode 1))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package gptel
  :ensure t)

(defun zf/use-ollama ()
  "use ollama"
  (interactive)
  (setq
   gptel-backend (gptel-make-ollama "Ollama"
                   :host "localhost:11434"
                   :stream t
                   :models '(deepseek-r1:14b))))

(defun zf/use-gemini ()
  "use gemini"
  (interactive)
  (message
   (getenv "GEMINI_API_KEY"))
  (setq
   gptel-model 'gemini-2.5-flash-preview-04-17
   gptel-backend (gptel-make-gemini "Gemini"
                   :key (getenv "GEMINI_API_KEY")
                   :stream t)))


(use-package valign :ensure t)


(defun zf/copy-markdown-code-block ()
  "Copy the content of the markdown code block at point to the kill ring."
  (interactive)
  (save-excursion
    (let (start end content)
      ;; Search backward for the beginning of a code block
      (when (not (looking-at "```"))
        (if (re-search-backward "^```" nil t)
            (forward-line 1)  ; Move to the line after the opening backticks
          (error "No code block found before point")))
      ;; Mark the start
      (setq start (point))
      ;; Search forward for the end of the code block
      (if (re-search-forward "^```" nil t)
          (progn
            (beginning-of-line)  ; Move to the beginning of the closing backticks
            (setq end (point))
            (setq content (buffer-substring-no-properties start end))
            (kill-new content)
            (message "Copied to kill ring (%d characters)" (length content)))
        (error "No closing code block found")))))


(defun zf/exec-line-as-sh ()
  "Run the text of the current line as a shell command"
  (interactive)
  (let* ((line (buffer-substring (line-beginning-position) (line-end-position))))
    (end-of-line)
    (newline)
    (insert (shell-command-to-string line))))

(defun zf/exec-line-as-sh-fenced ()
  "Run the current line as a shell command and insert the output in a fenced code block."
  (interactive)
  (let ((line (string-trim (buffer-substring-no-properties
                            (line-beginning-position)
                            (line-end-position)))))
    (if (string-empty-p line)
        (message "No command to run on this line.")
      (save-excursion
        (forward-line)
        (end-of-line)
        (newline)
        (insert "```")
        (newline)
        (insert (string-trim-right (shell-command-to-string line)))
        (newline)
        (insert "```")))))

(defun zf/find-file-at-point-in-right-window ()
  "Open the file at point in a window to the right.
If no window exists to the right, one is created.
If no filename is found at point, a message is displayed."
  (interactive)
  (require 'ffap)
  (let ((filename (ffap-file-at-point)))
    (if filename
        (progn
          (select-window (or (window-in-direction 'right)
                             (split-window-right)))
          (find-file filename))
      (message "No filename found at point."))))

(defvar ffap-string-at-point-region)
(defun zf/find-file-at-point-with-line-in-right-window ()
  "Open the file at point in a window to the right, and go to position if present.
Supports positions in the following formats: \"path:line path(line)\",
\"path:line:col\" and \"path(line,col)\"."
  (interactive)
  (require 'ffap)
  (let ((fname (ffap-file-at-point)))
    (unless fname
      (user-error "File does not exist."))
    (let* ((fullname (expand-file-name fname))
           (line-number-pattern ":\\([0-9]+\\)\\=" ) ; path:line format
           (line-number-pattern-alt "\\=(\\([0-9]+\\))") ; path(line) format
           (line-and-column-numbers-pattern ":\\([0-9]+\\):\\([0-9]+\\)\\=") ; path:line:col format
           (line-and-column-numbers-pattern-alt "\\=(\\([0-9]+\\),\\([0-9]+\\))") ; file(line,col) format
           (get-number (lambda (pattern match-number backward)
                         (save-excursion
                           (goto-char (cadr ffap-string-at-point-region))
                           (and (if backward
                                    (re-search-backward pattern (line-beginning-position) t)
                                  (re-search-forward pattern (line-end-position) t))
                                (string-to-number (match-string match-number))))))
           (line-number (or (funcall get-number line-and-column-numbers-pattern 1 t)
                            (funcall get-number line-and-column-numbers-pattern-alt 1 nil)
                            (funcall get-number line-number-pattern 1 t)
                            (funcall get-number line-number-pattern-alt 1 nil)))
           (column-number (or (funcall get-number line-and-column-numbers-pattern 2 t)
                              (funcall get-number line-and-column-numbers-pattern-alt 2 nil))))
      (evil-echo "%s, %s"
                 (if line-number (format "line: %s" line-number) "no line")
                 (if column-number (format "column: %s" column-number) "no column"))
      (select-window (or (window-in-direction 'right)
                         (split-window-right)))
      (find-file-at-point fullname)
      (when line-number
        (goto-char (point-min))
        (forward-line (1- line-number))
        (when column-number
          (move-to-column (1- column-number)))))))

(define-key evil-normal-state-map "gF" 'zf/find-file-at-point-with-line-in-right-window)

(defun zf/cd-to-path-at-point ()
  "Change `default-directory` to the directory at point if it exists."
  (interactive)
  (let ((path (thing-at-point 'filename t)))
    (if (and path (file-directory-p path))
        (progn
          (setq default-directory (file-name-as-directory (expand-file-name path)))
          (message "Changed directory to: %s" default-directory))
      (message "No valid directory at point."))))

(defun zf/cd-to-project-root ()
  "Change `default-directory` to the root of the project containing the current buffer file."
  (interactive)
  (if buffer-file-name
      (let* ((proj (project-current nil (file-name-directory buffer-file-name))))
        (if proj
            (let ((root (project-root proj)))
              (setq default-directory root)
              (message "Changed directory to project root: %s" root))
          (message "No project found for this buffer.")))
    (message "Current buffer is not visiting a file.")))


(defun zf/utc-to-local-time (utc-string)
  "Convert UTC-STRING to local time string."
  (format-time-string "%Y-%m-%d %H:%M:%S %Z"
                      (encode-time (parse-time-string utc-string))))

(defun zf/build-helm-pr-source (command)
  "Build helm candidates from COMMAND."
  (let* ((output (shell-command-to-string command))
         (reviews (json-parse-string output :array-type 'list :object-type 'alist))
         (col-title (- (window-width) (+ 6 60 23 3))))
    (mapcar (lambda (review)
              (format (format "%%-6s %%-%ds %%-60s %%-23s" col-title)
                      (alist-get 'number review)
                      (truncate-string-to-width (alist-get 'title review) col-title 0 nil t)
                      (truncate-string-to-width (alist-get 'headRefName review) 60 0 nil t)
                      (zf/utc-to-local-time (alist-get 'createdAt review))))
            reviews)))

(defun zf/view-pr (candidate)
  "Open CANDIDATE pr in browser."
  (let ((pr-number (car (split-string candidate "|"))))
    (shell-command (format "gh pr view --web %s" pr-number))))

(defun zf/checkout-pr (candidate)
  "Checkout CANDIDATE pr."
  (let ((pr-number (car (split-string candidate "|"))))
    (shell-command (format "gh pr checkout %s" pr-number))))

(defun zf/helm-github-prs ()
  "Helm interface for GitHub PRs."
  (interactive)
  (helm :sources
        (list
         (helm-build-sync-source "Review Requests"
           :candidates (zf/build-helm-pr-source "gh pr list --search review-requested:@me --json number,title,headRefName,createdAt,author")
           :action '(("View PR" . zf/view-pr)
                     ("Checkout Branch" . zf/checkout-pr)))
         (helm-build-sync-source "My PRs"
           :candidates (zf/build-helm-pr-source "gh pr list --author @me --json number,title,headRefName,createdAt")
           :action '(("View PR" . zf/view-pr)
                     ("Checkout Branch" . zf/checkout-pr)))
         (helm-build-sync-source "All Open PRs"
           :candidates (zf/build-helm-pr-source "gh pr list --json number,title,headRefName,createdAt")
           :action '(("View PR" . zf/view-pr)
                     ("Checkout Branch" . zf/checkout-pr))))
        :buffer "*helm github prs*"))

(defun zf/gh-pr-view-at-point ()
  "Run 'gh pr view --web' on the number at point."
  (interactive)
  (let ((number (number-at-point)))
    (if number
        (let ((command (format "gh pr view --web %d" number)))
          (message "Running: %s" command)
          (start-process "gh-pr-view" nil "gh" "pr" "view" "--web" (number-to-string number)))
      (message "No number found at point"))))
