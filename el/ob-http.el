(require 'ob)

(defstruct ob-http/request method url headers body)

(defun ob-http/take-while (pred coll)
  (cond ((not coll) '())
        (t (if (apply pred (list (car coll)))
             (cons (car coll) (ob-http/take-while pred (cdr coll)))
             '()))))

(defun ob-http/drop-while (pred coll)
  (cond ((not coll) '())
        (t (if (apply pred (list (car coll)))
             (ob-http/drop-while pred (cdr coll))
             coll))))

(defun ob-http/split-with (pred coll)
  (list (ob-http/take-while pred coll) (ob-http/drop-while pred coll)))

(defun ob-http/string-is-empty (s)
  (or (string= "" s) (if (string-match "\\`[ \t\n\r]+\\'" s) t nil)))

(defun ob-http/parse-input (raw)
  (let* ((lines (split-string raw "\\(\r\n\\|[\n\r]\\)"))
         (header-body (ob-http/split-with
                       (lambda (x) (not (ob-http/string-is-empty x))) lines))
         (body (cadr header-body))
         (headers (car header-body))
         (method-url (split-string (car headers) " "))
         (method (car method-url))
         (url (cadr method-url)))
    (make-ob-http/request
     :method method
     :url url
     :headers (nthcdr 1 headers)
     :body (mapconcat 'identity (nthcdr 1 body) "\n"))))

(defun org-babel-execute:http (body params)
  (let* ((req (ob-http/parse-input body))
         (proxy (cdr (assoc :proxy params)))
         (body (ob-http/request-body req))
         (cmd (format "curl -i %s -X %s %s %s %s"
                      (if proxy (format "-x %s" proxy) "")
                      (ob-http/request-method req)
                      (mapconcat (lambda (x) (format "-H \"%s\"" x))
                              (ob-http/request-headers req) " ")
                      (if (not (ob-http/string-is-empty body))
                          (let* ((tmp (org-babel-temp-file "http-")))
                            (with-temp-file tmp (insert body))
                            (format "-d @\"%s\"" tmp))
                        "")
                      (ob-http/request-url req)
                      )))
    (message cmd)
    (org-babel-eval cmd "")))

(provide 'ob-http)
