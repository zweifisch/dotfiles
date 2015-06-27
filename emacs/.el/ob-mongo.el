(require 'org)
(require 'ob)

(defgroup ob-mongo nil
  "org-mode blocks for mongodb"
  :group 'org)

(defcustom ob-mongo:default-db "test"
  "default mongodb database"
  :group 'ob-mongo
  :type 'string)

(defcustom ob-mongo:default-host "127.0.0.1"
  "default mongodb host"
  :group 'ob-mongo
  :type 'string)

(defcustom ob-mongo:default-port 27017
  "default mongodb port"
  :group 'ob-mongo
  :type 'integer)

(defun org-babel-execute:mongo (body params)
  "org-babel mongo hook"
  (let* ((db (or (cdr (assoc :db params))
                 ob-mongo:default-db))
         (host (or (cdr (assoc :host params))
                 ob-mongo:default-host))
         (port (or (cdr (assoc :port params))
                 ob-mongo:default-port))
         (cmd (format "mongo --quiet --host %s --port %d %s"
                      host port db)))
    (org-babel-eval cmd body)))

(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("mongo" . js)))

(provide 'ob-mongo)
