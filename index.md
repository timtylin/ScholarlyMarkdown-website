---
header-includes:
    - <title>ScholarlyMarkdown</title>
---

<div style="margin: 150px auto 100px; width: 100%;">
<img src="images/scholmd-logo-tight.png" style="margin: 0px auto 0px; display: block;">
<p style="text-align: center; margin-top: 50px;">
<em>make academic writing less frustrating</em>
</p>
</div>

> **Note:** The ScholarlyMarkdown Project is currently in early alpha and should be considered extremely experimental. This website is also under heavy construction and is essentially a draft copy for a much more complete site, which will be launched somewhere around *fall 2015*. Please bookmark this page or follow the maintainer on Twitter @timtylin

Let's keep the dream of [academic writing using Markdown](https://github.com/scholmd/scholmd/wiki) alive.

ScholarlyMarkdown is a syntax/standard/best-practice of scholarly and academic communication that is web-first, semantic XML-second, and LaTeX/Word a close third. Its main goal is to produce a semantically model of a scholarly article based on Markdown input, and translate it to a variety of formats that is suitable for both online scholarly communication, archiving, and publication. 

ScholarlyMarkdown introduces some new syntax for scholarly and academic features. However, at the same time it aims to be composed of 100% valid Github-Flavored Markdown and PHP Markdown Extra syntax and almost 90% backwards compatibility with existing renderers of those syntaxes, while being 100% compatible with Pandoc-markdown. It contains no completely new syntax over the previous standards, and instead provides its power from conventions.

Furthermore, ScholarlyMarkdown borrows a unique templating system/language from Pandoc with variables and metadata that may be set using YAML blocks inside the document. This allows flexibility to configure the output formatting to your heart's content without polluting the source text with presentation-specific code.

## More Info

[ScholarlyMarkdown Guide](Scholarly-Markdown-Guide.html)

[ScholarlyMarkdown FAQs](Scholarly-Markdown-FAQ.html)

[ScholarlyMarkdown HTML Schema](Scholarly-Markdown-HTML-Schema.html)

## Implementation

**Scholdoc** is the reference implementation of ScholarlyMarkdown. It is a fork of Pandoc and is build upon the same general parsing engine, but because it is focused exclusively on academic writing it can afford to be more nimble with breaking changes. Think of it as a prototyping tool for new ideas.

- [Scholdoc project website](http://scholdoc.scholarlymarkdown.com)
- [Scholdoc repository on GitHub](https://github.com/timtylin/scholdoc)
- [Example papers using ScholarlyMarkdown and Scholdoc](https://github.com/timtylin/scholdoc-examples)


**ScholarlyMarkdown Core CSS** is a CSS3 stylesheet that provides the necessary baseline formatting for all HTML output of ScholarlyMarkdown (figure spacing, math element spacing, etc). Some namespacing is used to avoid overriding existing styling. You should include it in every HTML file that `scholdoc` generates.

[You can find the latest ScholarlyMarkdown Core CSS here](scholdoc-distribution/css/core/scholmd-core-latest.css)

**ScholarlyMarkdown Heuristically Theme** is a CSS3 stylesheet that, along with the Heuristica webfont, produces the look and feel of this website. It is a responsive theme designed to look good for general academic documents. Special attention have been paid to make sure that mathematical content looks good with this theme. Heuristically includes the ScholarlyMarkdown Core CSS so there is no need to link to it separately in your HTML.

[You can get the latest version of the Heuristically theme here](scholdoc-distribution/css/heuristically/heuristically-latest.zip)

## Maintainer

ScholarlyMarkdown is developed and maintained by [Tim T.Y. Lin](mailto:timtylin@gmail.com)



