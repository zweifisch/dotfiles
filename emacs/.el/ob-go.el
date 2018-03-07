;;; ob-go.el --- org-babel functions for go evaluation

;; Copyright (C) 2018 Feng Zhou

;; Author: Feng Zhou <zf.pascal@gmail.com>
;; Keywords: org babel go
;; Version: 0.0.1
;; Created: 24th Feb 2018
;; Package-Requires: ((org "8"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; org-babel functions for go evaluation
;;

;;; Code:
(require 'ob)

(defun org-babel-execute:go (body params)
  (ob-go--eval body))

(defun ob-go--eval (body)
  (let ((temp-file (concat (make-temp-file "ob-go" 't) "/main.go")))
    (with-temp-file temp-file (insert body))
    (shell-command-to-string (concat "go run " temp-file))))

(provide 'ob-go)
;;; ob-go.el ends here
