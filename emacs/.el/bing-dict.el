;;; bing-dict.el --- english <-> chinese dictinary using the bing online dictionary http://cn.bing.com/dict/

;; Copyright (C) 2015 ZHOU Feng

;; Author: ZHOU Feng <zf.pascal@gmail.com>
;; URL: http://github.com/zweifisch/bing-dict
;; Keywords: dictionary bing chinese
;; Version: 0.0.1
;; Created: 30th June 2015

;;; Commentary:
;;
;; english <-> chinese dictinary using the bing online dictionary http://cn.bing.com/dict/
;;

(defun bing-dict-fetch (word)
  (with-current-buffer (get-buffer-create "*bing*")
    (erase-buffer)
    (insert
     (with-current-buffer (url-retrieve-synchronously (format "http://cn.bing.com/dict/%s" word))
       (buffer-string)))
    (goto-char (point-min))
    (search-forward-regexp "\n[\t\n ]*\n+")
    (decode-coding-region (point) (point-max) 'utf-8)))

(defun bing-dict-parse ()
  (with-current-buffer (get-buffer-create "*bing*")
    (goto-char (point-min))
    (search-forward-regexp "\n[\t\n ]*\n+")
    (libxml-parse-html-region (point) (point-max))))

(defun bing-dict-children (element)
  (when (listp element)
    (cdr (cdr element))))

(defun bing-dict-attr (element attr)
  (cdr (assoc attr (cadr element))))

(defun bing-dict-has-class (element class)
  (let ((class-names (bing-dict-attr element 'class)))
    (when class-names 
      (member class (split-string class-names)))))

(defun bing-dict-get-elements-by-class-name (element class)
  (let ((results (when (bing-dict-has-class element class) (list element)))
         (children (bing-dict-children element)))
    (when children
      (dolist (child children)
        (when (listp child)
          (let ((elements (bing-dict-get-elements-by-class-name child class)))
            (when elements
              (setq results (append results elements)))))))
    results))

(defun bing-dict-get-elements-by-tag-name (element tag)
  (let ((results (when (eq (car element) tag) (list element)))
         (children (bing-dict-children element)))
    (when children
      (dolist (child children)
        (when (listp child)
          (let ((elements (bing-dict-get-elements-by-tag-name child tag)))
            (when elements
              (setq results (append results elements)))))))
    results))

(defun bing-dict-get-element-by-id (element id)
  (if (string= id (bing-dict-attr element 'id)) element
    (let (result)
      (dolist (child (bing-dict-children element))
        (when (and (listp child) (null result))
          (let ((r (bing-dict-get-element-by-id child id)))
            (when r (setq result r)))))
      result)))

(defun bing-dict-text (element)
  (if (stringp element) element
    (let ((result ""))
      (dolist (child (bing-dict-children element))
        (setq result (concat result (bing-dict-text child))))
      result)))

(defun bing-dict-query (word)
  (bing-dict-fetch word)
  (let* ((html (bing-dict-parse))
         (def-block (car (bing-dict-get-elements-by-class-name html "qdef")))
         (word (bing-dict-text
                (bing-dict-get-element-by-id def-block "headword")))
         (pronounce-us (bing-dict-text
                        (car (bing-dict-get-elements-by-class-name def-block "hd_prUS"))))
         (pronounce (bing-dict-text
                     (car (bing-dict-get-elements-by-class-name def-block "hd_pr"))))
         (definations (mapcar 'bing-dict-text (bing-dict-get-elements-by-tag-name def-block 'li))))
    `((word . ,word) (us . ,pronounce-us) (en . ,pronounce) (definations . ,definations))))

;;;###autoload
(defun bing-dict-at-point ()
  (interactive)
  (let* ((word (thing-at-point 'word))
         (d (bing-dict-query word))
         (pos (point)))
    (end-of-line)
    (open-line 1)
    (next-line 1)
    (insert (cdr (assoc 'word d)) "\n")
    (insert (cdr (assoc 'us d)) (cdr (assoc 'en d)) "\n")
    (dolist (defination (cdr (assoc 'definations d)))
      (insert defination "\n"))
    (goto-char pos)))
