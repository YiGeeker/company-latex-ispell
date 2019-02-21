# company-latex-ispell

It's especially designed for LaTeX mode or TeX mode, because when you
type a "\\", you will get a lot of candidates including key words for
LaTeX and English words for ispell using `company-ispell`. Using
`company-latex-ispell`, you will get only key words candidates when
you type a "\\", and if you type a word without a "\\" at beginning,
you will get only English word candidates.

## Usage ##

Add the path to `load-path`

~~~el
(setq load-path (append '("path/to/company-latex-ispell.el") load-path))
~~~

then add to `company-backends`

~~~el
(setq company-backends '((company-latex-ispell)))
~~~

## License ##

This software is distributed under the term of GPLv3.
