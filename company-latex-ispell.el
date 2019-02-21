;;; company-ispell.el --- company-mode completion backend using Ispell

;; Copyright (C) 2009-2011, 2013-2016  Free Software Foundation, Inc.

;; Author: Nikolaj Schumacher

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:
;;

;;; Code:

(require 'company-ispell)

(defun company-auctex-prefix (regexp)
  "Returns the prefix for matching given REGEXP."
  (let ((prefix (and (derived-mode-p 'latex-mode)
                     (when (looking-back regexp)
                       (match-string-no-properties 1)))))
    (if prefix (cons prefix t) nil)))

;;;###autoload
(defun company-latex-ispell (command &optional arg &rest ignored)
  "`company-mode' completion backend using Ispell in `latex-mode'."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-ispell))
    (prefix (when (company-ispell-available)
	      (unless (company-auctex-prefix "\\\\\\([a-zA-Z]*\\)\\=")
		(company-grab-word))))
    (candidates
     (let ((words (company-ispell--lookup-words
                   arg
                   (or company-ispell-dictionary ispell-complete-word-dict)))
           (completion-ignore-case t))
       (if (string= arg "")
           ;; Small optimization.
           words
         ;; Work around issue #284.
         (all-completions arg words))))
    (sorted t)
    (ignore-case 'keep-prefix)))

(provide 'company-ispell)
;;; company-ispell.el ends here
