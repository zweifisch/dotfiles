(require 'org)
(require 'ob)
(require 'json)
(require 'url)
(require 'url-http)

(defvar url-http-end-of-headers)

(defun ob-llm--request (api prompt model)
  "Send PROMPT to API using MODEL and return response synchronously."
  (let* ((url-request-method "POST")
         (url-request-extra-headers
          `(("Content-Type" . "application/json")
            ("Authorization" . ,(concat "Bearer " (getenv "OPENROUTER_API_KEY")))))
         (url-request-data
          (json-encode `(("model" . ,model)
                         ("messages" . [,(list (cons "role" "user") 
                                              (cons "content" prompt))]))))
         (buffer (url-retrieve-synchronously api)))
    (when buffer
      (with-current-buffer buffer
        (goto-char url-http-end-of-headers)
        (let* ((json-object-type 'alist)
               (json-array-type 'vector)
               (json-key-type 'symbol)
               (json (json-read))
               (choices (alist-get 'choices json))
               (message (alist-get 'message (aref choices 0)))
               (content (alist-get 'content message)))
          (kill-buffer buffer)
          content)))))

(defgroup ob-llm nil
  "org-mode blocks for llm"
  :group 'org)

(defcustom ob-llm:api "https://openrouter.ai/api/v1/chat/completions"
  "API base URL"
  :group 'ob-llm
  :type 'string)

(defcustom ob-llm:model "openai/gpt-4o-mini"
  "Default model to use"
  :group 'ob-llm
  :type 'string)

(defun org-babel-execute:llm (body params)
  "Execute org-babel llm block"
  (let* ((api (or (cdr (assoc :api params))
                  ob-llm:api))
         (model (or (cdr (assoc :model params))
                    ob-llm:model))
         (response (ob-llm--request api body model)))
    response))

(provide 'ob-llm)
