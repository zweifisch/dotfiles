(require 'org)
(require 'ob)

(defun org-babel-execute:coffee (body params)
  "org-babel coffee hook"
  (org-babel-eval "coffee" body))

(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("coffee" . coffee)))

(provide 'ob-coffee)
