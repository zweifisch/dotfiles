;;; bing-dict.el --- english <-> chinese dictinary using the bing online dictionary http://bing.com/dict/

;; Copyright (C) 2015 ZHOU Feng

;; Author: ZHOU Feng <zf.pascal@gmail.com>
;; URL: http://github.com/zweifisch/bing-dict
;; Keywords: dictionary bing chinese
;; Version: 0.0.1
;; Created: 30th June 2015

;;; Commentary:
;;
;; english <-> chinese dictinary using the bing online dictionary http://bing.com/dict/
;;
(require 'enlive)

(defun bing-dict-query (word)
  (enlive-let (enlive-query (enlive-fetch (format "http://bing.com/dict/%s" word)) [.qdef])
              ((word [:headword])
               (pronounce-us [.hd_prUS])
               (pronounce [.hd_pr])
               (definations [li]))
              `((word . ,(enlive-text (car word)))
                (us . ,(enlive-text (car pronounce-us)))
                (en . ,(enlive-text (car pronounce)))
                (definations . ,(mapcar 'enlive-text definations)))))

;;;###autoload
(defun bing-dict-at-point ()
  (interactive)
  (let* ((word (thing-at-point 'word))
         (result (bing-dict-query word)))
    (with-output-to-temp-buffer "*bing*"
      (princ
       (with-temp-buffer
         (insert (cdr (assoc 'word result)) "\n")
         (insert (cdr (assoc 'us result)) (cdr (assoc 'en result)) "\n")
         (dolist (defination (cdr (assoc 'definations result)))
           (insert defination "\n"))
         (buffer-string))))))

(provide 'bing-dict)
;;; bing-dict.el ends here
