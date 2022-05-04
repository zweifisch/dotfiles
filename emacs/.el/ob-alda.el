;;; ob-alda.el --- org-babel functions for alda evaluation

;; Copyright (C) 2021 Feng Zhou

;; Author: Feng Zhou <zf.pascal@gmail.com>
;; URL: http://github.com/zweifisch/ob-alda
;; Keywords: org babel alda
;; Version: 0.0.1
;; Created: 18th Aug 2021
;; Package-Requires: ((org "8"))

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; org-babel functions for alda evaluation
;;

;;; Code:
(require 'ob)
(require 'json)

(defvar ob-alda-process-output nil)

(defvar ob-alda-eoe "alda >")
(defvar ob-alda-timeout 5)

(defun org-babel-execute:alda (body params)
  (let ((session (or (cdr (assoc :session params)) "default")))
    (ob-alda--ensure-session session)
    (ob-alda--eval-in-repl session body)))

(defun ob-alda--ensure-session (session)
  (let ((name (format "*alda-%s*" session)))
    (unless (and (get-process name)
                 (process-live-p (get-process name)))
      (with-current-buffer (get-buffer-create name)
        (start-process name name "alda" "repl" "--server" "--port" "7878")))))

(defun ob-alda--eval-in-repl (session body)
  (let* ((name (format "*alda-%s*" session))
         (result (json-read-from-string
                  (shell-command-to-string
                   (format "alda repl --client --port 7878 --message '{\"op\": \"eval-and-play\",\"code\": \"%s\"}'" body))))
         (status (assoc-default 'status result)))
    (elt status 0)))

(provide 'ob-alda)
;;; ob-alda.el ends here
