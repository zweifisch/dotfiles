
(use-package org :ensure org-plus-contrib)
(use-package ob-http :ensure t)
(use-package ob-cypher :ensure t)
(use-package ob-kotlin :ensure t)
(use-package inf-ruby :ensure t)
(use-package ob-sml :ensure t)
(use-package ob-ipython :ensure t)
(use-package ob-lfe :ensure t)
(use-package ob-elixir :ensure t)
(use-package ob-coffee :ensure t)
(use-package ob-swift :ensure t)
(use-package htmlize :ensure t)
(use-package ox-jira :ensure t)

(use-package jupyter :ensure t)

(use-package org-bullets :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-log-done nil)
(setq org-use-speed-commands t)
(setq org-catch-invisible-edits 'show-and-error)
(setq org-cycle-separator-lines 0)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ruby . t)
   (scheme . t)
   (python . t)
   (js . t)
   (shell . t)
   (go . t)
   (sql . t)
   (sqlite . t)
   (dot . t)
   (haskell . t)
   (mongo . t)
   ; (hy . t)
   (redis . t)
   (http . t)
   (cypher . t)
   (racket . t)
   ; (cfdg . t)
   (kotlin . t)
   (ansible . t)
   (ocaml . t)
   (ipython . t)
   ;; (haxe . t)
   ;; (go . t)
   (sml . t)
   (lfe . t)
   (perl . t)
   (elixir . t)
   ;; (rust . t)
   (eukleides . t)
   ;; (fomus . t)
   (mathomatic . t)
   ;; (ansible . t)
   ;; (elm . t)
   (plantuml . t)
   (ditaa . t)
   (groovy . t)
   (clojure . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/.plantuml.jar"))

(setq org-eukleides-path "/usr/bin/eukleides"
      org-eukleides-eps-to-raster "convert %s -antialias %s")

(add-to-list 'org-latex-packages-alist
             '("" "tikz" t))

(add-to-list 'org-src-lang-modes (quote ("dot". graphviz-dot)))
(add-to-list 'org-src-lang-modes (quote ("shell". sh)))

(setq org-babel-perl-command "perl6")

(setq org-edit-src-content-indentation 0
      org-src-tab-acts-natively t
      org-src-fontify-natively t
      org-confirm-babel-evaluate nil)

(setq org-image-actual-width nil)

(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)

(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")

(setq org-babel-clojure-backend 'cider)

(setq org-src-fontify-natively t)  ; code block

(setq org-directory "~/.org/")
(setq org-agenda-files (list org-directory))

(setq org-capture-templates
      '(("t" "Tasks" entry (file+headline "todo.org" "Tasks")
         "* TODO %?")
        ("c" "Collection" entry (file+headline "collect.org" "Collections")
         "* %x")
        ("j" "Journal" entry (file+olp+datetree "journal.org"))
        ("v" "Vocabulary" entry (file+headline "vocabulary.org" "Vocabulary")
         "* %^{The word} :drill:\n %t\n %^{Extended word (may be empty)} \n** Answer \n%^{The definition}")))

(setq calendar-week-start-day 1)

(setq org-agenda-include-diary t)

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
  (kbd "TAB") 'org-cycle
  (kbd "DEL") 'org-mark-ring-goto
  ;; (kbd "RET") 'browse-url-xdg-open
  (kbd "RET") 'org-open-at-point)

(evil-define-key 'normal org-src-mode-map
  "ge" 'org-edit-src-exit)

(evil-define-key 'emacs org-agenda-mode-map
  "j" 'org-agenda-next-line
  "k" 'org-agenda-previous-line
  (kbd "C-j") 'org-agenda-goto-date  ; "j"
  "n" 'org-agenda-capture)           ; "k"


(setq org-publish-project-alist
      '(("writing"
         :base-directory "~/notes/write"
         :html-extension "html"
         :base-extension "org"
         :publishing-directory "~/.writing"
         :publishing-function (org-html-publish-to-html)
         :html-preamble nil
         :html-postamble nil
         :port 9001)
        ("blog"
         :base-directory "~/pg/blog"
         :html-extension "html"
         :base-extension "org"
         :publishing-directory "~/.blog"
         :publishing-function (org-html-publish-to-html)
         :html-preamble nil
         :html-postamble nil
         :port 9002)
        ("wiki"
         :base-directory "~/notes/org"
         :html-extension "html"
         :base-extension "org"
         :publishing-directory "~/.wiki"
         :publishing-function (org-html-publish-to-html)
         :html-preamble nil
         :html-postamble nil
         :port 9000)))

(setq org-html-head-include-default-style nil
      org-html-head-include-scripts nil
      org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"markdown.css\" />")

(setq org-export-babel-evaluate nil)

(add-hook 'org-mode-hook (lambda ()
                           (org-indent-mode)))


(defun org-project-running ()
  (delq nil
        (mapcar (lambda (x)
                  (if (plist-get (cdr x) :started) (car x)))
                org-publish-project-alist)))

(defun org-project-idle ()
  (delq nil
        (mapcar (lambda (x)
                  (if (plist-get (cdr x) :started) nil (car x)))
                org-publish-project-alist)))

(defun serve-org-project (project)
  (interactive
   (list
    (completing-read "Project: " (org-project-idle))))
  (let ((settings (cdr (assoc project org-publish-project-alist))))
    (elnode-make-webserver
     (plist-get settings :publishing-directory)
     (plist-get settings :port))
    (plist-put settings :started t)))

(defun stop-org-project (project)
  (interactive
   (list
    (completing-read
     "Project: " (org-project-running))))
  (let ((settings (cdr (assoc project org-publish-project-alist))))
    (elnode-stop (plist-get settings :port))
    (plist-put settings :started nil)))

(defun browse-org-project (project)
  (interactive
   (list
    (completing-read
     "Project: " (org-project-running))))
  (let ((settings (cdr (assoc project org-publish-project-alist))))
    (browse-url (format "http://localhost:%d" (plist-get settings :port)))))

(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))

(use-package org-mime :ensure t)

(require 'org-velocity)

(use-package org-board :ensure t)

(setq org-hide-emphasis-markers t)

(defun org-hide-block-overlay ()
  (interactive)
  (save-excursion
    (goto-char (point-max))
    (while (re-search-backward "#\\+BEGIN_SRC\\|#\\+END_SRC" nil t)
      (let ((overlay (make-overlay
                      (line-beginning-position)
                      (1+ (line-end-position)))))
        (overlay-put overlay 'invisible t)))))

(defun org-remove-block-overlay ()
  (interactive)
  (remove-overlays))

(add-hook 'org-mode-hook 'set-org-mode-app-defaults)
(defun set-org-mode-app-defaults ()
  (setq org-file-apps
	'(("pdf" . "mupdf %s")
	  ("jpg" . "qiv %s")
	  ("png" . "qiv %s")
	  ("svg" . "qiv %s"))))

(setq org-export-with-sub-superscripts nil)

(setq org-link-abbrev-alist
  '(("google"    . "http://www.google.com/search?q=")))

(require 'org-tempo)

(provide 'org-conf)
