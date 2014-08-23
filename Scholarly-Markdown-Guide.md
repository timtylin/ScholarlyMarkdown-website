---
title: ScholarlyMarkdown Syntax Guide
author:
        - Tim T.Y. Lin (<timtylin@gmail.com>)
        - Graham Beales
subject: The differences between ScholarlyMarkdown and Pandoc's implementation of Markdown.
date: August 22, 2014
company: University of British Columbia
keywords: markdown, scholarly, scholmd, latex, html, word, docx, .tex, guide
---

## First steps

### Creating a new document

Any plain-text file is a valid ScholarlyMarkdown (Scholmd) document. Open up a plain text file, and start by typing:

    Hello!
    ¡Hola!
    Bonjour!

Save the file anywhere to any name you like. Typically, Markdown files are saved with a `.md` extension, but since a Markdown file is just a plaintext file, you can save it with a `.txt` extension without confusing people. Since a ScholMD file is designed to be backwards-compatible with Markdown, you can save the file as `.md` or `.txt` as you like, or as some people do with `.scholmd`.

For the purposed of this tutorial, we'll save it to a file called `hello.scholmd`.

### Rendering output

Currently the reference implementation for ScholarlyMarkdown rendering is a program called `scholdoc`, which is based on [Pandoc](http://johnmacfarlane.net/pandoc). Place the binary somewhere on your execution path, then run:

    scholdoc hello.scholmd

Scholdoc will immediately output a file called `hello.html`. This is an HTML5 webpage. If you open it up with a web browser, you should see the following: 

> Hello!
> ¡Hola!
> Bonjour!

#### Why is there no line-break between the greetings?

By default, Markdown (and subsequently ScholarlyMarkdown) ignores all line breaks within a paragraph. This is a common practice when dealing with plain-text documents that might not have the benefit of automatic word wrapping. To preserve the line breaks yourself (such as when writing addresses or a poem), you have two options:

1. Add either a `\` character or two spaces after each line
2. Use a [line block](http://johnmacfarlane.net/pandoc/README.html#line-blocks) instead of a paragraph

#### Changing the look

The output HTML5 file should follow a [schema described here in pseudo-HAML format](Scholarly-Markdown-HTML-Schema.html), which allows you to write a custom CSS file. The schema follow semantic versioning for APIs: before 0.x.x, any minor revision may be backwards-incompatible with previous versions. After 1.x.x, only major revisions may introduce incompatible changes.

A custom css file can be included using the `--css=URL` flag to `scholdoc`, or by using the `css` field in the metadata.

#### Standard ScholarlyMarkdown CSS

ScholarlyMarkdown also defines a default core CSS3 stylesheet that should be used for all output that follows the ScholarlyMarkdown [schema](Scholarly-Markdown-HTML-Schema.html) (which is that `scholdoc` does). 

The latest ScholarlMarkdown Core can be found [here](scholdoc-distribution/CSS/core/scholmd-core-latest.css).


## Math

### Inline Math

Inline math is delimited by **two** backticks followed immediately by anything other than a whitespace, followed by two backticks.  So``` ``a+b=c`` ```is displayed as ``a+b=c``, yet an inline code block``` `` `code` `` ```is still displayed as expected:`` `code` ``.

### Display/Block Level Math

To create display/block level math, surround it by three backticks with the math label as follows:

    ```math {#yourmathlabel}
        \textit{insert latex math code here}
    ```

The the {#label} is optional, but it produces a useful reference for other uses in the document, and functions just as any other reference.  The `` math `` keyword is required to distinguish the math block from the format-specification keyword used in Github-Flavoured Markdown.

So the above code block is displayed as:

```math {#yourmathlabel}
    \textit{insert latex math code here}
```

ScholarlyMarkdown smartly aligns and/or gathers an equation based upon the length of the equation as well as whether you have aligned it using the \& symbol as in LaTeX.

#### Citing display math expressions

Citing display equations is done using the a special reference/label syntax in ScholarlyMarkdown, using the `#` character (think "hashtags").

To show a numeric reference to the previous math expression, simply type your reference label surrounded by squared brackets `[#yourmathlabel]`. This will show up as: [#yourmathlabel]. Alternatively, you can surround it in parenthesis `(#yourmathlabel)`, which will show up as: (#yourmathlabel). These numbers will also link back to the math expression in formats that support them.

Numeric references are automatically prepended with non-breaking spaces, so you should not worry about line breaks occurring right before a number.

See also the following section on [Numbered internal references].

### HTML math support

ScholarlyMarkdown officially supports [Mathjax](http://www.mathjax.org) exclusively for math support in HTML. In additional, every HTML5 webpage output by `scholdoc` includes the necessary markup to include the latest version of Mathjax from the official CDN. This behavior can be disabled by the `--no-mathjax-cdn` flag given to `scholdoc`.

### Differences from Pandoc

The first change is that whereas ScholarlyMarkdown uses **two** backtick \` symbol to deliminate inline math, Pandoc uses the dollar sign \$ symbol.  ScholarlyMarkdown retains backwards-compatability with Pandoc by reading all text between \$ symbols as LaTeX math as well.

The second and most important change is that ScholarlyMarkdown provides more complete syntax for display/block level math with a seamless system for equation labeling and numbering, whereas Pandoc does not.


### Guide for advanced LaTeX users

LaTeX macros can be defined in ScholarlyMarkdown using a special Math block:

    ```math_def
        {latex math definitions}
    ```

which will move the equation into the beginning of the header rather than the body of the document.

If you include line breaks with the `\\` symbol, ScholarlyMarkdown automatically wraps your math in a `gathered` environment. If you use alignment symbols `&` in addition to the line break `\\` symbol, ScholarlyMarkdown wraps your math in a `aligned` environment instead. You do not need to manually add the environment. If you want to disable this behavior, use the `math_plain` instead of the `math` keyword.

### Guide for Word users

## Numbered internal references

When you specify a reference in the opening line of a Figure, table, equation, or algorithm, ScholarlyMarkdown automatically creates clickable references and numbers them by their placement in the document ignoring the name you give to the reference. So I could make this figure:

    #### Figure: Look at the funny reference! {#figureReference25}
    
    ![](http://i.imgur.com/T2geA8K.jpg){#subFigureReference width=20%}
    
    : The number in the reference tag does not match what is displayed
        
and when the reference `(#figureReference25)` is used (note the click-ability of the following number!): (#figureReference25) it does not show the number 25, but instead the actual number of the figure itself:

#### Figure: Look at the funny reference! {#figureReference25}
        
![](http://i.imgur.com/T2geA8K.jpg){#subFigureReference width=20%}

: The number in the reference tag does not match what is displayed

and when the subfigure reference `[#subFigureReference]` is used (again, note its click-ability!): [#subFigureReference] the figure number is automatically displayed and calculated.

It should be noted that when the figure was referenced it was surrounded by parentheses, but when the sub figure was referenced it was not.  This is because of the differences between using a reference with parentheses versus square brackets. Both are valid, and simply cosmetic differences.

### Guide for advanced LaTeX users

Referencing a Reference/label can be done in two ways, as seen in the last two examples:

    1. (#label) maps to \eqref{label} in LaTeX
    2. [#label] maps to \ref{label} in LaTeX

which are displayed as follows:

1. (#label) maps to \eqref{label} in LaTeX
2. [#label] maps to \ref{label} in LaTeX

Notice that in the first line, `(#label)` is replaced by `(1)` and `[#label]` is replaced by `1` as is the case for `\eqref{label}` and `\req{label}` in LaTeX, respectively, and the `eqref{label}` and `\req{label}` are both stripped from the output as other LaTeX code is in Pandoc.

### Guide for Word users

## Figure environment

ScholarlyMarkdown allows for floating figures with attached captions and references. To define a figure block, start with a 4th-level header followed by ` Figure: `.  On the same line you may include an description of the figure that is specific to the Markdown file, and then a reference as below:

    #### Figure: this text is ignored {#referenceToFigure}

The content of the figure is specified on the the following lines.  In ScholarlyMarkdown, a figure can contain as many images as desired with each one specified on a new line that is started with an ` '!' `.  Following the exclamation mark is an optional subcaption contained in square brackets, followed by a link to the figure contained in parantheses, followed by an optional subfigure reference and width specification enclosed in curly braces, followed by an optional endline specification.  So the following line:

    ![my subCaption](figureLink){#subFigureReference width=75%}\

will produce place the image found at figureLink into the figure, with a subcaption "my subCaption" that will have reference "subFigureReference", a width of 75 of the block and will be the last figure in the row.

The final line of the figure block is a caption for the entire figure prepended with a colon and a space as such: `: Figure Caption`.

Using this syntax, can easily and cleanly make figures.  For example:

    #### Figure: this text is completely ignored {#figure1}
    
    ![sub](http://i.imgur.com/T2geA8K.jpg){#reginfig1 width=20%}\
    ![subfig](http://i.imgur.com/T2geA8K.jpg){width=same}
    ![](http://i.imgur.com/T2geA8K.jpg){width=30%}
    ![longer subcaption that flows](http://i.imgur.com/T2geA8K.jpg){#reginfig3 width=same}
    
    : Any following paragraph that begins with a colon character will be the caption
produces:

#### Figure: this text is completely ignored {#figure1}

![sub](http://i.imgur.com/T2geA8K.jpg){#reginfig1 width=20%}\
![subCaption](http://i.imgur.com/T2geA8K.jpg){width=same}
![](http://i.imgur.com/T2geA8K.jpg){width=30%}
![longer subcaption that flows](http://i.imgur.com/T2geA8K.jpg){#reginfig3 width=same}

: Any following paragraph that begins with a colon character will be the caption

Notice a few things here:

- There should always be a gap between the opening line and the content of the figure, as well as the content of the figure and the caption.
- Subfigures are automatically labelled "a, b, c" etc. if a subfigure reference is specified.
- Square brackets ` [] ` are still required even if you do not plan to add a subcaption.
- The reference for the subfigure as well as the width attribute are included in the same set of curly braces separated only by a space.

Figures are automatically numbered throughout the document, and smartly given a wide, aligned, or regular width label.  For HTML output they will also resize with the browser window.


### Differences from Pandoc

Pandoc's figure environment is extremely limited.  It only allows for captions, without internal references, automatic numbering, or anything similar.

### Guide for advanced LaTeX users

Normally, ScholarlyMarkdown translates figures to the `figure` environment LaTeX. If you have multi-column documents and you wish to use the `figure*` environment to span columns, use a `.wide` keyword at the end of the first line, within the reference's curly braces.  So, for example, the following figure opening:

    #### Figure: Yay figure informational text! {#figure2Reference .wide}

would create a figure that spans multiple columns, using the `figure*` environment.

### Guide for Word users

## Including Metadata

To include metadata in your file, ScholarlyMarkdown uses the YAML standard, for which you can see more details at the Official YAML website [here](http://www.yaml.org/spec/1.2/spec.html). A YAML section can be placed anywhere in a Markdown file without breaking the output.  As an example, the YAML data for this document is as follows:

    ---
    title: ScholarlyMarkdown Syntax Guide
    author:
            - Time Lin
            - Graham Beales
    subject: The differences between ScholarlyMarkdown and Pandoc's implementation of Markdown.
    date: August 22, 2014
    company: University of British Columbia
    keywords: markdown, scholarly, scholmd, latex, html, word, docx, .tex, guide
    ---

which is automatically parsed to include the title and the author at the top of this document.  The subject, company, and keywords fields were included for testing, but are not yet handled by the ScholarlyMarkdown program.

Current meaningful (in terms of document information) fields include:

- title
- author
- date
- bibliography

with the author field being the only one that accepts a list as input.

### Abstracts

An abstract can be included as as metadata in your ScholarlyMarkdown file.  However, there is a second way to include abstracts besides the YAML format.  Instead, you include an abstract by using a second level header 'Abstract' with a colon after it as follows:


    ## Abstract:
    This is an abstract!

Currently ScholarlyMarkdown limits the abstract to a single paragraph. It is planned in the future to also support multiple paragraphs and structured abstracts.

The abstract can be included anywhere in the Markdown file, and will be inserted into the metadata. Whether it displays or not depends upon the template used to create the output from ScholarlyMarkdown.

### Differences from Pandoc Markdown

ScholarlyMarkdopwn offers the second "section title" format to include an abstract.

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

