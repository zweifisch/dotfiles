;;; ob-forth.el --- org-babel functions for go evaluation

;; Copyright (C) 2021 Feng Zhou

;; Author: Feng Zhou <zf.pascal@gmail.com>
;; Keywords: org babel forth
;; Version: 0.0.1
;; Created: 10th April 2021
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
;; org-babel functions for forth evaluation
;;

;;; Code:
(require 'ob)

(defun org-babel-execute:forth (body params)
  (ob-forth--eval body))

(defun ob-forth--eval (body)
  (let ((temp-file (make-temp-file "ob-forth")))
    (with-temp-file temp-file (insert (concat body " bye")))
    (shell-command-to-string (concat "gforth " temp-file))))

(provide 'ob-forth)
;;; ob-forth.el ends here
