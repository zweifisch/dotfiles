(require 'org)
(require 'ob)

(defgroup ob-redis nil
  "org-mode blocks for redis"
  :group 'org)

(defcustom ob-redis:default-db 0
  "default redis db"
  :group 'ob-redis
  :type 'integer)

(defcustom ob-redis:default-host "127.0.0.1"
  "default redis host"
  :group 'ob-redis
  :type 'string)

(defcustom ob-redis:default-port 6379
  "default redis port"
  :group 'ob-redis
  :type 'integer)

(defun org-babel-execute:redis (body params)
  "org-babel redis hook"
  (let* ((db (or (cdr (assoc :db params))
                 ob-redis:default-db))
         (host (or (cdr (assoc :host params))
                 ob-redis:default-host))
         (port (or (cdr (assoc :port params))
                 ob-redis:default-port))
         (cmd (format "redis-cli --no-raw -h %s -p %d -n %d"
                      host port db)))
    (org-babel-eval cmd body)))

(provide 'ob-redis)
