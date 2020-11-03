;;; red.el --- Support for the Red programming language.

;; Copyright (C) 2015 Joshua Cearley and contributors.

;; This file is NOT part of Emacs.

;; Author: Joshua Cearley <joshua.cearley@gmail.com>
;; Version: 0.0.4

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

;;; Code:

(defconst red-integer-regex
  "\\<\\(-?[1-9][0-9]*\\|0\\)\\>"
  "Definition of Red integers.")

(defconst red-hexadecimal-regex
  "\\<\\([0-9A-F]+h\\)\\>"
  "Definition of Red hexadecimal integers.")

(defconst red-float-regex
  "\\<\\([-+]?\\(0\\|[1-9][0-9]*\\)\\(E[-+]?[1-9][0-9]*\\|\\.[0-9]+\\(E[-+]?[1-9][0-9]*\\)?\\)\\)\\>"
  "Definition of Red floating point numbers.")

;;; pairs are two integers
;;; http://www.red-lang.org/2015/06/054-new-datatypes-exceptions-and-set.html
(defconst red-pair-regex
  "\\<\\(-?[1-9][0-9]*\\|0\\)x\\(-?[1-9][0-9]*\\|0\\)\\>"
  "Definition of Red pairs.")

;; percentages are simple floats with a % sigil
(defconst red-percent-regex
  "\\<-?[1-9][0-9]*\\(?:\\.[0-9]+\\)?%\\>"
  "Definition of Red percentage numbers.")

;; tuples are 3-12 integers separated by periods
(defconst red-tuple-regex
  "\\<\\(?:0\\|[1-9][0-9]*\\)\\(?:\\.\\(?:0\\|[1-9][0-9]*\\)\\)\\{2,12\\}\\>"
  "Definition of Red tuples.")

;; setters are words ending with :
(defconst red-setter-regex
  "\\_<\\(\\s_\\|\\w\\)+: "
  "Definition of Red setters.")

;;; Special parts which require text highlights

;; symbols
;; "% * ** + - / // < << <= <> = == =? > >= >> >>> ? ?? NaN? a-an"

(defconst red-words-regex
  (concat "\\<"
	  (regexp-opt-group
	   (split-string
	    "
NaN? a-an about absolute acos action? add ail alias all and and~ any
any-block? any-function? any-object? any-path? any-string? any-word?
append arccosine arcsine arctangent arctangent2 as as-pair asin ask at
atan atan2 attempt back bind bitset? block? body-of break byte!
c-string! case catch cause-error cdecl char? charset clear comment
complement complement? complete-from-path compose cond construct
context continue copy cos cosine datatype? declare
default-input-completer dehex difference divide do does e either
empty? equal? error? eval-set-path even? exclude exit exp extend false
fifth file? find first float! float32! float? forall foreach forever
form fourth func function function? get get-path? get-word?
greater-or-equal? greater? halt has hash? head head? help if in index?
input insert integer! integer? intersect issue? keys-of last last-lf?
length? lesser-or-equal? lesser? lit-path? lit-word? load local log-10
log-2 log-e logic! logic? loop lowercase make map? max min modify
modulo mold multiply native? negate negative? next none?  not
not-equal? object object? odd? op? or or~ pad pair? paren? parse
parse-trace path? percent? pick pointer! poke positive? power prin
print probe put quit quit-return quote random read-input reduce
refinement? reflect remainder remove repeat replace return reverse
round routine? same? second select series? set set-buffer-history
set-path? set-word? shift shift-left shift-logical shift-right sin
sine skip sort source spec-of square-root stats strict-equal? string?
struct! subtract swap switch tail tail? take tan tangent third throw
to to-hex trim true try tuple? type? typeset? union unique unless
unset? axis until uppercase url? value? values-of variadic vector?
what while word? words-of xor xor~ zero?")
	   t t)
	  "\\>")
  "Words which are defined by default in the Red programming language.")

(defconst red-font-lock-keywords
  `((,red-tuple-regex . font-lock-constant-face)
    (,red-percent-regex . font-lock-constant-face)
    (,red-float-regex . font-lock-constant-face)
    (,red-hexadecimal-regex . font-lock-constant-face)
    (,red-integer-regex . font-lock-constant-face)
    (,red-words-regex . font-lock-function-name-face)
    (,red-setter-regex . font-lock-variable-name-face))
  "Font lock table for the Red programming language")

;;; Syntax table.
(defvar red-syntax-table
  (let ((syn-table (make-syntax-table)))
    ;; Lisp style comments
    (modify-syntax-entry ?\; "<" syn-table)
    (modify-syntax-entry ?\n ">" syn-table)
    (modify-syntax-entry ?\\ "." syn-table)
    (modify-syntax-entry ?^ "\\" syn-table)
    ;; Dashes are part of identifiers, and thus words
    (modify-syntax-entry ?- "w" syn-table)
    syn-table
    )
  "Syntax table for the Red language.")

;;; Standard intelligent comments.
(defun red-comment-dwim (arg)
  "`Do What I Mean' commenting for Red. Based on the `comment-dwim' function."
  (interactive "*P")
  (require 'newcomment)
  (let ((comment-start ";") (comment-end ""))
    (comment-dwim arg)))

;;; Line indentation.
(defvar red-indentation-amount 3
  "How many cells of indentation are used in Red source code.")

(defun red-get-indentation-for-line ()
  "Figures out the proper indentation for the current line."
  (save-excursion
    (if (bobp)
	0
      (let ((indentation 0)
	    (closers "[\])}]")
	    (openers "[\[({]")
	    (potatos "[^])}\t ]"))
	;; dedent if closers are present, but only if the line
	;; contains nothing except for closers
	(let* ((bol (progn (beginning-of-line)
			   (point)))
	       (eol (progn (end-of-line)
			   (point)))
	       (open (how-many openers bol eol))
	       (close (how-many closers bol eol))
	       (vegetables (how-many potatos bol eol))
	       (diff (- open close)))
	  (if (and (= 0 vegetables) (< diff 0))
	      (setq indentation (* diff red-indentation-amount))))
	;; add previous line's indentation
	(previous-line)
	(setq indentation (+ indentation (current-indentation)))
	;; indent if openers are present
	(let* ((bol (progn (beginning-of-line)
			   (point)))
	       (eol (progn (end-of-line)
			   (point)))
	       (open (how-many openers bol eol))
	       (close (how-many closers bol eol))
	       (diff (- open close)))
	  (if (> diff 0)
	      (setq indentation (+ indentation (* diff red-indentation-amount)))))
	(max 0 indentation)))))

(defun red-indent-line ()
  "Indents the current line using Red's indentation rules."
  (interactive "*")
  (let* ((a (point))
	 (b (progn (back-to-indentation) (point))))
    (indent-line-to (red-get-indentation-for-line))
    (back-to-indentation)
    (forward-char (- a b))))

(defun red-electric-insert-and-indent ()
  "Automatically reindents the current line after inserting a character."
  (interactive "*")
  (self-insert-command 1)
  (red-indent-line))

;;; Mode definition.
(define-derived-mode red-mode prog-mode
  "Red"
  "Major mode for editing source code in the Red or Red/System programming languages."
  :syntax-table red-syntax-table

  ;; install font lock settings
  (setq font-lock-defaults '((red-font-lock-keywords)))

  ;; map smart commenting
  (define-key red-mode-map [remap comment-dwim] 'red-comment-dwim)

  ;; map electric indentation
  ;(define-key red-mode-map "]" 'red-electric-insert-and-indent)
  ;(define-key red-mode-map ")" 'red-electric-insert-and-indent)
  ;(define-key red-mode-map "}" 'red-electric-insert-and-indent)

  ;; map our indenter
  (make-local-variable indent-line-function)
  (setq indent-line-function 'red-indent-line))

;;; Auto-insert

(define-auto-insert
  '("\\.red\\'" . "Red script")
  '(lambda ()
     (skeleton-insert
      '(""
	"Red [" \n
	> "Title: \"Untitled\"" \n
	> "Author: \"" user-full-name "\"" \n
	> "Version: 0.0.1" \n
	"]" > \n
     nil))))

(define-auto-insert
  '("\\.reds\\'" . "Red/System module")
  '(lambda ()
     (skeleton-insert
      '(""
	"Red/System [" \n
	> "Title: \"Untitled\"" \n
	> "Author: \"" user-full-name "\"" \n
	> "Version: 0.0.1" \n
	"]" > \n
     nil))))

;;; Postamble

;; Automatically activated `red-mode' when a Red or Red/System buffer
;; is opened.
(add-to-list 'auto-mode-alist '("\\.reds?\\'" . red-mode))

;; Allow auto-loading this plugin.
(provide 'red)
