;; Prevent the cursor from blinking
(blink-cursor-mode -1)

(setq initial-scratch-message ""
      inhibit-startup-message t
      visible-bell t)

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
(setq-default tab-width 3)
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

(defvar my-packages '(evil
                      evil-indent-textobject
                      evil-matchit
                      evil-nerd-commenter
                      evil-leader
                      subatomic-theme
                      virtualenvwrapper
                      flycheck))
(dolist (p my-packages)
  (when (not (package-installed-p p)) (package-install p)))

(setq my:el-get-packages
      '(org-mode deft
        python jedi ein
        projectile
        help-fns+
        evil-surround
        coffee-mode
        zencoding-mode
        markdown-mode
        mustache-mode
        yaml-mode
        auto-complete
        magit))
(el-get 'sync my:el-get-packages)

;; powerline fiplr helm clojure-mode slime-repl swank-clojure
;; yasnippet anything emms dired-sort dired+ auto-dictionnary
;; autopair google-maps org2blog rainbow-mode switch-window
;; sr-speedbar typopunct solarized-theme

;; theme and modes

(load-theme 'subatomic t)
;; (load-theme 'solarized-dark t)
;; (load-theme 'zenburn t)

; powerline
;; (powerline-default-theme)

; evil
(evil-mode)

(setq-default evil-symbol-word-search t)

(define-key evil-normal-state-map " " 'evil-toggle-fold)
(define-key evil-normal-state-map ";" 'evil-ex)

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
  "F" 'projectile-find-file
  "b" 'projectile-switch-to-buffer
  "R" 'projectile-recentf
  "g" 'projectile-grep

  "f" 'ido-find-file
  "B" 'ido-switch-buffer
  "r" 'recentf-open-files

  "s" 'projectile-switch-project
  "e" 'eshell
  "i" 'ein:notebooklist-open
  "c" 'org-capture
  "d" 'deft)
(global-evil-leader-mode)

; evil-nerd-commenter
(evilnc-default-hotkeys)

; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'jedi:ac-setup)
(setq jedi:complete-on-dot t)

(add-hook 'python-mode-hook 'flycheck-mode)

;; (setq flycheck-check-syntax-automatically '(mode-enabled save))

; recentf
(recentf-mode 1)
(setq recentf-max-saved-items 256)

; projectile
(projectile-global-mode)
(setq projectile-completion-system 'grizzl
      projectile-remember-window-configs t)

;; virtualenv
(require 'virtualenvwrapper)
(venv-initialize-eshell)
(setq venv-location "~/.venv/")
(setq eshell-prompt-function
      (lambda ()
        (concat venv-current-name " $ ")))
;; virtualenv in modline
(setq-default mode-line-format (cons '(:exec venv-current-name) mode-line-format))

; ein

; python
(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args ""
      python-shell-prompt-regexp "In \\[[0-9]+\\]: "
      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
      python-shell-completion-setup-code
      "from IPython.core.completerlib import module_completion"
      python-shell-completion-module-string-code
      "';'.join(module_completion('''%s'''))\n"
      python-shell-completion-string-code
      "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

; org-mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-directory "~/notes/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-capture-templates
      '(("t" "Tasks" entry (file+headline (concat org-directory "/todo.org") "Tasks")
         "* TODO %?")
        ("c" "Collection" entry (file+datetree (concat org-directory "/collect.org") "Collections")
         "* %x")
        ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a"))))

(custom-set-variables '(org-agenda-files (quote ("~/notes/org/journal.org"))))
(setq org-agenda-files (list "~/notes/org/journal.org" "~/notes/org/zf.org" ))  

(setq org-todo-keywords
      '((sequence "TODO" "NEXT" "|" "DONE" "ABORTED")))

; deft
(setq deft-extension "org"
      deft-directory org-directory
      deft-text-mode 'org-mode)

; evil-org-mode

