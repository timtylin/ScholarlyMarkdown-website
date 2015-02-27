---
title: ScholarlyMarkdown Syntax Guide
author:
        - Tim T.Y. Lin (<timtylin@gmail.com>)
        - Graham Beales
subject: The differences between ScholarlyMarkdown and Pandoc's implementation of Markdown.
date: January 31, 2015
company: University of British Columbia
keywords: markdown, scholarly, scholmd, latex, html, word, docx, .tex, guide
---

## Summary of new features in ScholarlyMarkdown

The following lists major additions over the [Pandoc Markdown](http://johnmacfarlane.net/pandoc/README.html#pandocs-markdown):

- New [Figure/Float convention](#floating-env)
- Uses code and fenced code block syntax for [inline and display math](#math)
- Native ability to give figures/floats and display math [identifiers](#numbered-internal-references) so they can be referenced
- Native ability to [specify width for images](#floating-subfigs)
- [Numeric references](#numbered-internal-references) to figures/display math by `[#id]` and `(#id)`
- [Special "Abstract:" section](#special-abstract) that is automatically inserted into the metadata

*Future plans (as of October 2014):*

- Special syntax/keyword for appendices
- Multi-lingual keyword support
- Text blocks that are enumerated and referenceable, in particular Theorems/Definitions/Examples
- Better handling of author metainfo (incorporating discussions [here](https://github.com/scholmd/scholmd/wiki/Article-metadata))
- Automatic RDF generation from metadata

### Current tools that support ScholarlyMarkdown

As much as possible, ScholarlyMarkdown is designed to fallback gracefully to most existing Markdown processor and editors, so you can write ScholarlyMarkdown using almost any text editor you want.

For final conversion to HTML, LaTeX, Word Docx, and others, the reference tool that implements all of the ScholarlyMarkdown extensions is [Scholdoc], which is a specialized fork of [Pandoc] that is limited to reading ScholarlyMarkdown and outputting to (*as of January 2015*) HTML and LaTeX.

## First steps

### Creating a new document

Any plain-text file is a valid ScholarlyMarkdown (Scholmd) document. Open up a plain text file, and start by typing:

    Hello!
    ¡Hola!
    Bonjour!

Save the file anywhere to any name you like. Typically, Markdown files are saved with a `.md` extension, but since a Markdown file is just a plaintext file, you can save it with a `.txt` extension without confusing people. Since a ScholMD file is designed to be backwards-compatible with Markdown, you can save the file as `.md` or `.txt` as you like, or as some people do with `.scholmd`.

For the purposed of this tutorial, we'll save it to a file called `hello.scholmd`.

### Rendering output

Currently the reference implementation of ScholarlyMarkdown is [Scholdoc], which is an open source, specialized fork of [Pandoc] that is limited to reading ScholarlyMarkdown and outputting to (*as of January 2015*) HTML and LaTeX.

Binary distributions are available from the [Scholdoc download page][scholdoc-dl]. Currently there are builds available for Windows, OS X, and Linux.

Make sure [Scholdoc] is installed and on your execution your execution path, then run:

    scholdoc hello.scholmd

Scholdoc will immediately output a file called `hello.html`. This is an HTML5 webpage. If you open it up with a web browser, you should see the following: 

> Hello!
> ¡Hola!
> Bonjour!

#### Why is there no line-break between the greetings?

By default, Markdown (and subsequently ScholarlyMarkdown) ignores all line breaks within a paragraph. This is a common practice when dealing with plain-text documents that might not have the benefit of automatic word wrapping. To preserve the line breaks yourself (such as when writing addresses or a poem), you have two options:

1. Add either a `\` character or two spaces after each line
2. Use a [line block](http://johnmacfarlane.net/pandoc/README.html#line-blocks) instead of a paragraph

### More on Markdown

The [official Scholmd wiki](https://github.com/scholmd/scholmd/wiki/) has a great [3-minute guide on plain Markdown.](https://github.com/scholmd/scholmd/wiki/Learn-markdown-in-3-minutes)

### Changing the look

The output HTML5 file should follow a [schema described here in pseudo-HAML format](Scholarly-Markdown-HTML-Schema.html), which allows you to write a custom CSS file. The schema follow semantic versioning for APIs: before 0.x.x, any minor revision may be backwards-incompatible with previous versions. After 1.x.x, only major revisions may introduce incompatible changes.

A custom css file can be included using the `--css=URL` flag to `scholdoc`, or by using the `css` field in the metadata.

#### Standard ScholarlyMarkdown CSS

ScholarlyMarkdown also defines a default core CSS3 stylesheet that should be used for all output that follows the ScholarlyMarkdown [schema](Scholarly-Markdown-HTML-Schema.html) (which is that `scholdoc` does). 

The latest ScholarlMarkdown Core can be found [here](scholdoc-distribution/CSS/core/scholmd-core-latest.css).


## Math

### Inline Math

Inline math works exactly like any inline code in Markdown, except it is delimited by **exactly two** backticks. For example, ``` ``a+b=c`` ```is interpreted and displayed as math: ``a+b=c``.

Using the Markdown code syntax for math prevents old converters and editors that doesn't understand ScholarlyMarkdown from trying to interpret the content math code.

Currently, ScholarlyMarkdown always assumes that the math content are LaTeX math commands. This allows for fairly straightforward conversion to LaTeX documents.

To preserve a common use for double-backtick syntax, the math content must start *immediately* after the starting backticks. If you write``` `` `code` `` ```it would still be displayed as normal Markdown inline code:`` `code` ``.

### Display/Block Level Math {#math-disp}

To create display/block level math, surround it by three backticks or tildes with the math label as follows:

    ```math #yourmathlabel
        \textit{insert latex math code here}
    ```

The `#label` is optional, but giving it a label will attach a number to this math expression, so you can [refer back to it later](#numbered-internal-references). The `math` keyword is required to distinguish the math block from the format-specification keyword used in Github-Flavoured Markdown.

So the above code block is displayed as:

```math #yourmathlabel
    \textit{insert latex math code here}
```

ScholarlyMarkdown smartly aligns and/or gathers an equation based upon the length of the equation as well as whether you have aligned it using the `&` symbol, as in LaTeX.

#### Citing display math expressions

Citing display equations is done using the a special reference/label syntax in ScholarlyMarkdown, using the `#` character (think "hashtags").

To show a numeric reference to the previous math expression, simply type your reference label surrounded by squared brackets `[#yourmathlabel]`. This will show up as [#yourmathlabel]  (the equation number). Alternatively, you can surround it in parenthesis `(#yourmathlabel)`, which will show up as (#yourmathlabel). These numbers will also link back to the math expression in formats that support them.

Numeric references are automatically prepended with non-breaking spaces, so you should not worry about line breaks occurring right before a number.

See also the following section on [Numbered internal references].

### HTML math support

ScholarlyMarkdown officially uses [Mathjax](http://www.mathjax.org) exclusively for math support in HTML. In additional, every HTML5 webpage output by `scholdoc` includes the necessary markup to include the latest version of Mathjax from the official CDN. This behavior can be disabled by the `--no-mathjax-cdn` flag given to `scholdoc`.

### Differences from Pandoc

The first change is that whereas ScholarlyMarkdown uses **two** backtick \` symbol to deliminate inline math, Pandoc uses the dollar sign \$ symbol.  ScholarlyMarkdown retains backwards-compatability with Pandoc by reading all text between \$ symbols as LaTeX math as well.

The second and most important change is that ScholarlyMarkdown provides more complete syntax for display/block level math with a seamless system for equation labeling and numbering, whereas Pandoc does not.


### Guide for advanced LaTeX users

LaTeX macros can be defined in ScholarlyMarkdown using a special Math block:

    ```math_def
        {latex math definitions}
    ```

which will move the definitions into the beginning of the header rather than the body of the document, ensuring that all math expressions your document can use these definitions. Note that this allows you to move these definitions out of the way of the main text (and perhaps into the bottom of your document).

If you include line breaks with the `\\` symbol, ScholarlyMarkdown automatically wraps your math in a `gathered` environment. If you use alignment symbols `&` in addition to the line break `\\` symbol, ScholarlyMarkdown wraps your math in a `aligned` environment instead. You do not need to manually add the environment. If you want to disable this behavior, use the `math_plain` instead of the `math` keyword.

### Guide for Word users

## Floating figure environment {#floating-env}

ScholarlyMarkdown allows for floating figures with attached captions and references. To define a figure block, start an ATX header of *any* level by the keyword `Figure:`.  On the same line you may include an description of the figure (it will be ignored by the parser), and then a finally a reference label. It will look like this:

    #### Figure: this text is ignored {#referenceToFigure}

On the next lines you follow with one or more Markdown images ("subfigures") as the content of the float (each on their own line):

    ![](image1.png)
    ![](image2.png)
    ![](image3.jpg)

Finally, a caption can be specified by a following paragraph that starts with the keyword `Caption:` (or just `:` will do)

    Caption: This is my first figure. Hello!

Putting them all together, we end up with the following figure:

#### Figure: this text is ignored {#figure1}

![](http://i.imgur.com/T2geA8K.jpg){width=30%}
![](http://i.imgur.com/T2geA8K.jpg){width=^}
![](http://i.imgur.com/T2geA8K.jpg){width=^}

Caption: This is my first figure. Hello!

### Adjusting the subfigures {#floating-subfigs}

There are several things you can do to the images inside the float block. First of all, each image can have its own subcaption (which goes inside the alt text block). Each subfigure can also have its own label attached (within curly braces), and a width can be specified in percentage of the container width.

    ![subcaption here](image.jpg){#subfigLabel width=50%}

You can also force a line break by adding a `\` to the end of an image. Here's a complete example (specifying `same` for the width will use the last **user-defined** width in the document):

    #### Figure: this text is ignored {#figure2}
    
    ![look at me](sealbaby.jpg){#sealA width=50%}\
    ![and also me](sealbaby.jpg){#sealB width=30%}
    ![](sealbaby.jpg){#sealC width=same}
    
    Caption: Look at all my baby seals!

The above displays as:

#### Figure: this text is ignored {#figure2}
![look at me](http://i.imgur.com/T2geA8K.jpg){#sealA width=50%}\
![and also me](http://i.imgur.com/T2geA8K.jpg){#sealB width=30%}
![](http://i.imgur.com/T2geA8K.jpg){#sealC width=same}
Caption: Look at all my baby seals!

A few things to note:

- There can at most be **one** blank line between the opening line and the content of the figure, as well as the content of the figure and the caption.
- Figure are given a number if and only if you supply a reference label to the figure or any of the subfigures.
- Subfigures are automatically labelled "a, b, c" etc. if *any* subfigure reference is specified.
- The reference for the subfigure as well as the width attribute are included in the same set of curly braces separated only by a space.

### Other kinds of floats (tables, code, etc)

Other kinds of floats can be used in ScholarlyMarkdown, and is controlled by the keyword that you use to start the float. The keyword `Figure:` leads to image floats. However, if you used `Table:` instead, it will parse a following Markdown table as float content instead of images (captions still work the same).

#### Table: float keyword and expected contents {#table:floatKeywords}

|  Keyword  | Expected float content |
|-----------|------------------------|
| Figure:   | One or more images     |
| Table:    | One table              |
| Textbox:  | One line block         |
| Algorithm: | One line block        |
| Code:     | One indented or fenced code block |
| Listing:  | One indented or fenced code block |

Caption: Valid float keywords in ScholarlyMarkdown and the contents they recognize

### Differences from Pandoc

Pandoc's figure environment is extremely limited.  It only allows for captions, without internal references, automatic numbering, or anything similar.

### Guide for advanced LaTeX users

Normally, ScholarlyMarkdown translates figures to the `\begin{figure}...\end{figure}` environment in LaTeX. If you have multi-column documents and you wish to use the `figure*` environment to span columns, use a `.wide` keyword at the end of the first line, within the reference's curly braces.  So, for example, the following figure opening:

    #### Figure: {#figlabel .wide}

would create a figure that spans multiple columns, using the `figure*` environment. In HTML output, this would also add a `scholmd-widefloat` class to the `<figure>` element, so it can be appropriately targeted by CSS rules. See the [ScholarlyMarkdown HTML schema](Scholarly-Markdown-HTML-Schema.html) for more details.

### Guide for Word users

## Numbered internal references

When you specify a reference in the opening line of a Figure or Math, ScholarlyMarkdown automatically creates clickable references and numbers them by their placement in the document ignoring the name you give to the reference. So when I make the following display formula for Maxwell's equations:

    ~~~math #maxwellEq
    \left.\begin{aligned}
    B'&=-\partial\times E\\
    E'&=\partial\times B - 4\pi j
    \end{aligned}
    \right\}
    \qquad \text{Maxwell's equations}
    ~~~

~~~math #maxwellEq
\left.\begin{aligned}
B'&=-\partial\times E\\
E'&=\partial\times B - 4\pi j
\end{aligned}
\right\}
\qquad \text{Maxwell's equations}
~~~

I can refer back to it by using the syntax `(#maxwellEq)`, which shows (#maxwellEq). I can also get just the number and omit the parenthesis by `[#maxwellEq]` which just gives [#maxwellEq]. The figure number is automatically calculated and displayed.

References to figures also work the same way. I can refer to Figure [#figure2] using `[#figure2]`, and subfigure [#sealB] using `[#sealB]`. The syntax is the same regardless. I can also use the parenthesis version (#figure2) and (#sealB).

Whenever possible, the numbered reference will always generate a clickable link to the original equation or figure.

### Guide for advanced LaTeX users

Numerical references translate to either the `\eqref` or `\ref` commands in LaTeX:

    - (#maxwellEq) maps to `\eqref{label}` in LaTeX
    - [#maxwellEq] maps to `\ref{label}` in LaTeX

which are displayed as follows:

- (#maxwellEq) maps to `\eqref{maxwellEq}` in LaTeX
- [#maxwellEq] maps to `\ref{maxwellEq}` in LaTeX

Note that only the numbers are displayed. There is currently no native support for things like `\autoref` in LaTeX. However, ScholarlyMarkdown automatically converts whitespace in front of a numbered reference into a non-breaking space (unless it was preceded by a punctuation mark). No more typing things like `figure~\ref{fig5}`!

### Guide for Word users


## Including Metadata

To include metadata in your file, ScholarlyMarkdown uses the YAML standard, for which you can see more details at the Official YAML website [here](http://www.yaml.org/spec/1.2/spec.html). A YAML section can be placed anywhere in a Markdown file without breaking the output.  As an example, the YAML data for this document is as follows:

    ---
    title: ScholarlyMarkdown Syntax Guide
    author:
            - Time Lin
            - Graham Beales
    subject: The differences between ScholarlyMarkdown and Pandoc's implementation of Markdown.
    date: October 01, 2014
    company: University of British Columbia
    keywords: markdown, scholarly, scholmd, latex, html, word, docx, guide
    ---

which is automatically parsed to include the title and the author at the top of this document.  The subject, company, and keywords fields were included for testing, but are not yet handled by the ScholarlyMarkdown program.

Current meaningful (in terms of document information) fields include:

- title
- author
- date
- bibliography

with the author field being the only one that accepts a list as input.

### Abstracts {#special-abstract}

An abstract can be included as metadata in a field `abstract:` in your ScholarlyMarkdown file.  However, there is a second way to include abstracts besides the YAML format.  Instead, you include an abstract by using a second level header 'Abstract' with a colon after it as follows:

    ## Abstract:
    This is an abstract!

Currently ScholarlyMarkdown limits the abstract to a single paragraph. It is planned in the future to also support multiple paragraphs and structured abstracts.

The abstract can be included anywhere in the Markdown file, and will be inserted into the metadata. Whether it displays or not depends upon the template used to create the output from ScholarlyMarkdown.

### Differences from Pandoc Markdown

ScholarlyMarkdown offers the second "section title" format to include an abstract.

## Header levels

ScholarlyMarkdown has a fixed definition of how header levels translate to the different formats. This is to avoid semantic confusion when authoring.

#### Table: Scholmd header levels {#table:scholmdHeaders}

| HTML Level  | LaTeX/Word meaning     |
|-------------|------------------------|
| Header 1    | Chapter                |
| Header 2    | Section                |
| Header 3    | Subsection             |
| Header 4    | Subsubsection          |
| Header 5    | Paragraph              |
| Header 6    | Subparagraph           |

Caption: all header levels and their implied semantic meaning


## Templating System

### Differences from Pandoc

## HTML Output Reference

### Guide to ScholarlyMarkdown DOM schema

## LaTeX Output Reference

### LaTeX math and float models

## Word Output Reference

## Scholdoc usage

### Differences from Pandoc

`Scholdoc` accepts all of the options that Pandoc does, with a few different defaults:

- The --standalone option is on by default for .html output.


## Suggestions and guidelines



[Scholdoc]: http://scholdoc.scholarlymarkdown.com
[Pandoc]: http://johnmacfarlane.net/pandoc/
[scholdoc-dl]: http://scholdoc.scholarlymarkdown.com/download/