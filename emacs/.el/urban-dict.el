;;; urban-dict.el --- query urban dictionary

;; Copyright (C) 2015 ZHOU Feng

;; Author: ZHOU Feng <zf.pascal@gmail.com>
;; URL: http://github.com/zweifisch/urban-dict
;; Keywords: urban dictionary
;; Version: 0.0.1
;; Created: 6th July 2015

;;; Commentary:
;;
;; query urban dictionary
;;
(require 'enlive)

(defun urban-dict-query (word)
  (enlive-let (enlive-query (enlive-fetch (format "http://www.urbandictionary.com/define.php?term=%s" word)) [.def-panel])
              ((word [.word])
               (defination [.meaning]))
              `((word . ,(enlive-text (car word)))
                (defination . ,(enlive-text (car defination))))))

;;;###autoload
(defun urban-dict-at-point ()
  (interactive)
  (let* ((word (thing-at-point 'word))
         (d (urban-dict-query word))
         (pos (point)))
    (end-of-line)
    (open-line 1)
    (next-line 1)
    (insert (cdr (assoc 'word d)))
    (insert (cdr (assoc 'defination d)))
    (goto-char pos)))

(provide 'urban-dict)
;;; urban-dict.el ends here
