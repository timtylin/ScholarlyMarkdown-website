---
title: ScholarlyMarkdown
---

*making academic writng less frustrating and future-proof since 2014*

Let's keep the dream of [academic writing using Markdown](https://github.com/scholmd/scholmd/wiki) alive.

ScholarlyMarkdown is a syntax/standard/best-practice of scholarly and academic communication that is web-first, semantic XML-second, and LaTeX/Word a close third. Its main goal is to produce a semantically model of a scholarly article based on Markdown input, and translate it to a variety of formats that is suitable for both online scholarly communication, archiving, and publication. 

To achieve this goal, ScholarlyMarkdown aggregates some very recent developments in terms of standards and techniques:

- Pandoc-markdown/citeproc integration
- CSL
- JATS
- Semantic HTML5
- MathJax
- Webfonts
- Responsive web design
- Docx/MathML
- YAML
- Templating

ScholarlyMarkdown introduces some new syntax for scholarly and academic features. However, at the same time it aims to be composed of 100% valid Github-Flavored Markdown and PHP Markdown Extra syntax and almost 90% backwards compatibility with existing renderers of those syntaxes, while being 100% compatible with Pandoc-markdown. It contains no completely new syntax over the previous standards, and instead provides its power from conventions.

Furthermore, ScholarlyMarkdown borrows a unique templating system/language from Pandoc with variables and metadata that may be set using YAML blocks inside the document. This allows flexibility to configure the output formatting to your heart's content without polluting the soucre text with presentation-specific code.

## Guides

[ScholarlyMarkdown Guide](Scholarly-Markdown-Guide.html)

[ScholarlyMarkdown FAQs](Scholarly-Markdown-FAQ.html)

[ScholarlyMarkdown HTML Schema](Scholarly-Markdown-HTML-Schema.html)

## Implementation

**Scholdoc** is the reference implementation of ScholarlyMarkdown. It is a fork of Pandoc and is build upon the same parsing engine. You can find the latest binary distributions here:

- [OSX (10.7 or above)](scholdoc-distribution/osx/scholdoc-0.1.1-alpha-osx.zip)

**ScholarlyMarkdown Core CSS** is a CSS3 stylesheet that provides the necessary baseline formatting for all HTML output of ScholarlyMarkdown (figure spacing, math element spacing, etc). You should include it in every HTML file that `scholdoc` generates.

[You can find the latest ScholarlyMarkdown Core CSS here](scholdoc-distribution/css/core/scholmd-core-latest.css)

## Maintainer

ScholarlyMarkdown is developed and maintained by [Tim T.Y. Lin](timtylin@gmail.com)



