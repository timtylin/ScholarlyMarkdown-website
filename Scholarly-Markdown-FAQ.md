---
title: ScholarlyMarkdown FAQs
author: Tim T.Y. Lin
---

Why isn't my math showing correctly in HTML?
:   By default uses MathJax for rendering, check the MathJax support page for list of supported latex commands.

Why isn't my math showing correctly in LaTeX?
:   Most common cause is a badly imported package, check whether the LaTeX output is malformed first.

Complaints about undefined sequence
:   Make sure all LaTeX commands are defined in a `math_def` class math block

Complain about undefined paclages (algorithms, etc)
:   Need to also use `texlive-science` in addition to `texlive-latex-basic` and `texlive-latex-recommended` for Debian

Complain about "can;t find size of bounding box"
:   Exclusively use `pdflatex, don't use anything else

Layout is weird in Algorithms
:   Do not use tabs! Tabs get turned into spaces!

## General tips

- Encourage use of `\providecommand` instead of `\def` or `\newcommand`

