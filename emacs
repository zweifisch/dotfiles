;; Prevent the cursor from blinking
(blink-cursor-mode -1)

(setq initial-scratch-message ""
      inhibit-startup-message t
      visible-bell t)

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

;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))

(setq backup-directory-alist '(("." . "~/.tmp")))
;; (setq make-backup-files nil)

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(evil
                      evil-indent-textobject
                      evil-matchit
                      evil-nerd-commenter
                      evil-leader
                      paredit
                      subatomic-theme
                      flatui-theme
                      solarized-theme
                      monokai-theme
                      stylus-mode
                      virtualenvwrapper
                      ;; elscreen
                      elm-mode
                      org-present
                      ace-jump-mode  ; easymotion
                      use-package
                      go-mode
                      go-eldoc
                      company-go
                      linum-relative
                      volatile-highlights
                      know-your-http-well
                      company
                      alchemist
                      smart-mode-line
                      quack
                      elpy
                      evil-god-state
                      geiser
                      graphviz-dot-mode
                      ;; diff-hl
                      bison-mode
                      ghc
                      company-ghc
                      guide-key
                      helm
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
      '(org-mode deft
        python
        ; jedi
        ; ein
        help-fns+
        evil-surround
        coffee-mode
        ; zencoding-mode
        markdown-mode
        ; mustache-mode
        yaml-mode
        ;; auto-complete
        web-mode
        jade-mode
        haskell-mode
        clojure-mode
        cider
        exec-path-from-shell
        kivy-mode
        ; auctex
        multi-term
        slime
        swank-js
        js2-mode
        smart-tab
        mmm-mode
        rainbow-delimiters
        calfw
        anaphora
        ;; workgroups2
        ))
(el-get 'sync my:el-get-packages)

;; powerline fiplr slime-repl swank-clojure
;; yasnippet emms dired-sort dired+ auto-dictionnary
;; autopair google-maps org2blog rainbow-mode switch-window
;; sr-speedbar typopunct

;; theme and modes

;; (load-theme 'subatomic t)
;; (load-theme 'solarized-dark t)
;; (load-theme 'zenburn t)
(load-theme 'monokai t)

; powerline
;; (powerline-default-theme)

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
  "f" 'ido-find-file
  ;; "B" 'ido-switch-buffer
  "B" 'helm-buffers-list
  ;; "b" 'projectile-switch-to-buffer
  "b" 'helm-projectile-switch-to-buffer
  ;; "b" 'ace-jump-buffer
  "R" 'helm-recentf
  "r" 'helm-projectile-recentf

  "a" 'org-agenda

  "g" 'helm-projectile-grep
  "o" 'browse-url
  "e" 'eshell
  ;; "i" 'ein:notebooklist-open
  "c" 'org-capture
  "s" 'magit-status
  "j" 'ace-jump-mode
  ;; "v" 'wg-switch-to-workgroup
  "v" 'projectile-persp-switch-project
  ;; "v" 'helm-projectile-switch-project
  "d" 'vc-diff)

(global-evil-leader-mode)
(evil-leader/set-leader "|")
(evil-define-key 'normal global-map
  "gj" 'ace-jump-mode
  "," 'evil-execute-in-god-state)

(global-set-key (kbd "C-a") nil)
(global-set-key (kbd "C-a |") 'evil-window-vsplit)
(global-set-key (kbd "C-a -") 'evil-window-split)
(global-set-key (kbd "C-a p") 'persp-prev)
(global-set-key (kbd "C-a n") 'persp-next)
(global-set-key (kbd "C-a c") 'projectile-persp-switch-project)
(global-set-key (kbd "C-a x") 'persp-kill)
(global-set-key (kbd "C-a l") 'evil-window-right)
(global-set-key (kbd "C-a h") 'evil-window-left)
(global-set-key (kbd "C-a j") 'evil-window-down)
(global-set-key (kbd "C-a k") 'evil-window-up)

; evil-nerd-commenter
(setq evilnc-hotkey-comment-operator "gc")
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
(setq recentf-max-saved-items 512)

(require 'use-package)

; projectile
(use-package projectile
  :ensure t
  :config
  (progn
    (projectile-global-mode)
    (setq projectile-completion-system 'helm
          projectile-switch-project-action 'projectile-dired
          projectile-remember-window-configs t)
  ))

(use-package helm
  :config
  (progn
    (use-package helm-config)
    (define-key helm-map (kbd "ESC") 'helm-keyboard-quit)
    (define-key helm-map (kbd "C-j") 'helm-next-line)
    (define-key helm-map (kbd "C-k") 'helm-previous-line)))

(use-package helm-projectile
  :ensure t
  :config (helm-projectile-on))

;; (use-package switch-window
;;   :ensure t
;;   :config (setq switch-window-shortcut-style 'qwerty
;;                 switch-window-relative)
;;   :bind ("C-a o" . switch-window))
 
; ein

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

; org-mode
;; (evil-set-initial-state 'org-mode 'emacs)

(setq org-src-fontify-natively t)  ; code block

(setq org-directory "~/.org/")
(setq org-agenda-files (list org-directory))

(setq org-capture-templates
      '(("t" "Tasks" entry (file+headline "todo.org" "Tasks")
         "* TODO %?")
        ("c" "Collection" entry (file+datetree "collect.org" "Collections")
         "* %x")
        ("j" "Journal" entry (file+datetree "journal.org" "* %?\nEntered on %U\n  %i\n  %a"))))

(setq calendar-week-start-day 1)

(setq org-todo-keywords
      '((sequence "TODO" "NEXT" "|" "DONE" "ABORTED")))

; deft
(setq deft-extension "org"
      deft-directory org-directory
      deft-text-mode 'org-mode)

; org-mode

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

; paredit

;; (add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)
;; (add-hook 'clojure-mode-hook 'evil-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;; clojure

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

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
  "ww" 'paredit-splice-sexp

  ;; "J" 'paredit-join-sexps
  "O" 'paredit-split-sexp)

;; elisp
(evil-define-key 'normal emacs-lisp-mode-map
  (kbd "RET") 'eval-last-sexp)

(evil-define-key 'normal scheme-mode-map
  (kbd "RET") 'geiser-eval-last-sexp)

; cider
(evil-define-key 'normal cider-mode-map
  (kbd "RET") 'cider-eval-last-sexp)

(evil-define-key 'visual cider-mode-map
  (kbd "RET") 'cider-eval-region)

(setq nrepl-hide-special-buffers t
      cider-repl-pop-to-buffer-on-connect nil
      cider-popup-stacktraces t
      cider-repl-popup-stacktraces t)

; magit
(use-package magit
  :ensure t
  :bind (("<escape>" . magit-mode-quit-window)))

; python
(evil-define-key 'visual python-mode-map
  (kbd "RET") 'python-shell-send-region)

(evil-define-key 'normal python-mode-map
  "gs" 'python-shell-switch-to-shell)

; global evil key
(define-key evil-normal-state-map "L" 'projectile-ibuffer)
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

;; coffee
(evil-define-key 'visual coffee-mode-map
  "r" 'coffee-compile-region)
;; (setq coffee-indent-tabs-mode t)

;; web-mode
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))

(use-package jsx-mode
  :ensure t)

(display-time-mode 1)

(add-to-list 'term-unbind-key-list "C-a")
(add-to-list 'term-bind-key-alist '("C-z" . term-stop-subjob))

(setq-default TeX-engine 'xetex)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
          (lambda ()
            (slime-js-minor-mode 1)))

(setq slime-contribs '(slime-fancy slime-js))

(when (member "DejaVu Sans Mono for Powerline" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono for Powerline-10"))

;; dangerous
(setq enable-local-variables :all)

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

(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'respectful)
(add-to-list 'rm-blacklist " Undo-Tree")
(add-to-list 'rm-blacklist " Paredit")
(add-to-list 'rm-blacklist " VHl")

(require 'quack)

(use-package ob-http :ensure t)

(add-to-list 'load-path "~/.el")

;; babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ruby . t)
   (scheme . t)
   (python . t)
   (js . t)
   (sh . t)
   (sql . t)
   (dot . t)
   (haskell . t)
   (mongo . t)
   (coffee . t)
   (redis . t)
   (http . t)
   (cypher . t)
   (go . t)
   (clojure . t)))

(add-to-list 'org-src-lang-modes (quote ("dot". graphviz-dot)))

(setq org-confirm-babel-evaluate nil)

(setq org-edit-src-content-indentation 0
      org-src-tab-acts-natively t
      org-src-fontify-natively t
      org-confirm-babel-evaluate nil)

(setq org-babel-clojure-backend 'cider)

(elpy-enable)

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


(eval-after-load "org"
  '(progn (define-key org-mode-map (kbd "M-h") nil)
          (define-key org-mode-map (kbd "C-a") nil)))

(eval-after-load "magit"
  '(progn (define-key magit-mode-map (kbd "M-h") nil)))

(defun my-eshell-mode-hook ()
  (define-key eshell-mode-map (kbd "C-a") nil)
  (evil-define-key 'normal eshell-mode-map "^" 'eshell-bol))
(add-hook 'eshell-mode-hook 'rename-uniquely)
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

(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

(setq guide-key/guide-key-sequence t)
(guide-key-mode 1)


(evil-set-initial-state 'image-mode 'emacs)

(defun projectile-persp-switch-project (project-to-switch)
  "Switch to a project or perspective we have visited before.
If the perspective of corresponding project does not exist, this
function will call `persp-switch' to create one and switch to
that before `projectile-switch-project' invokes
`projectile-switch-project-action'.

Otherwise, this function calls `persp-switch' to switch to an
existing perspective of the project unless we're already in that
perspective in which case `projectile-switch-project' is called."
  (interactive (list (projectile-completing-read
                      "Switch to project: "
                      (projectile-relevant-known-projects))))
  (let* ((name (file-name-nondirectory (directory-file-name project-to-switch)))
         (persp (gethash name perspectives-hash))
         (is-curr (and persp (equal persp persp-curr))))
    (when (and (not (string= "" name)) (or (not persp) (not is-curr)))
        (persp-switch name))
    (when (and (not (string= "" name)) (or (not persp) is-curr))
        (projectile-switch-project-by-name project-to-switch))))

(evil-set-initial-state 'process-menu-mode 'emacs)

(setq doc-view-resolution 200)

(global-set-key (kbd "M-x") 'helm-M-x)

(defun my-minibuffer-hook ()
  (local-set-key (kbd "M-p") 'clipboard-yank))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-hook)

(use-package dictionary :ensure t)

(require 'mu4e)

(setq mu4e-maildir "~/mail")
(setq mu4e-drafts-folder "/primary/[Gmail].Drafts")
(setq mu4e-sent-folder   "/primary/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/primary/[Gmail].Trash")

(setq mu4e-sent-messages-behavior 'delete)

(setq mu4e-get-mail-command "tsocks offlineimap")

(setq message-kill-buffer-on-exit t)

(setq mu4e-headers-skip-duplicates t)

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

(defun toggle-windows-split()
  (interactive)
  (if (not (window-minibuffer-p))
      (if (< 1 (count-windows))
          (progn
            (window-configuration-to-register ?u)
            (delete-other-windows))
        (jump-to-register ?u))))

(define-key global-map (kbd "C-a o") 'toggle-windows-split)

(use-package cypher-mode :ensure t)

(use-package dash :ensure t)
