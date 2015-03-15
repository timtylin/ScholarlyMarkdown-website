---
title: ScholarlyMarkdown FAQs
author: Tim T.Y. Lin
---

Why isn't my math showing correctly in HTML?
:   By default ScholarlyMarkdown uses MathJax for rendering, check the MathJax support page for list of supported latex commands. In the future there will also be support for KaTeX once it is mature enough to handle multiline equations, numbered labels, and macros.

Why isn't my math showing correctly in LaTeX?
:   Most common cause is a badly imported or unexpected package. Check whether the rendered LaTeX code is malformed first.

Complaints about undefined sequence
:   Make sure all LaTeX commands are defined in a `math_def` class math block. Also, MathJax and LaTeX have different rules when dealing with pre-defined/conflicting macro names; just because your math displays correctly with MathJax doesn't always mean LaTeX likes it, and vice versa.

Complain about undefined packages (algorithms, etc)
:   Need to also use `texlive-science` in addition to `texlive-latex-basic` and `texlive-latex-recommended` for Debian

Complain about "can't find size of bounding box"
:   Try to avoid rendering to dvi, which tends to produce more problems when interacting with various image formats.

Layout is weird in Algorithms
:   The most likely issue is tabs. Tabs always gets converted to 4 spaces, which may be different from how your text editor is configured.

## General tips

- Encourage use of `\providecommand` instead of `\def` or `\newcommand`

