
(use-package org-plus-contrib :ensure t)
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

(use-package org-bullets :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-log-done 'time)
(setq org-use-speed-commands t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ruby . t)
   (scheme . t)
   (python . t)
   (js . t)
   (sh . t)
   (shell . t)
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
   (ditaa . t)
   (clojure . t)))

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

(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")

(setq org-babel-clojure-backend 'cider)

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

(require 'org-mime)

(require 'org-velocity)

(provide 'org-conf)
