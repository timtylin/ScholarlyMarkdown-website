---
title: Scholarly Markdown file schema 0.1
date: 2014-04-15
---

## Abstract:

This document outlines the HTML5 class/element schema of a Scholarly Markdown document

## Main Document

```haml
<!DOCTYPE html>
%head
%body
    .scholmd-container
        .scholmd-main
            .scholmd-math-definitions.math
            .scholmd-content
```

### Content

```haml
.scholmd-content
    [%header] (if $title$)
        --- (if $subtitle$)
            %hgroup.scholmd-title-group
                %h1.scholmd-title
                %h1.scholmd-subtitle
            --- (else)
            %h1.scholmd-title
        --- (endif)
        [.scholmd-author] (if $author$)
            [.scholmd-author-name] (if $author.name$)
            [.scholmd-author-affiliation] (if $author.affiliation$)
        [.scholmd-date] (if $date$)
    [.scholmd-abstract] (if $abstract$)
        [%h2.scholmd-abstract-title] (if $abstract-title$)
    [%nav#TOC] (if $toc$)
    BODY
```

## Math

### Inline math

```haml
%span.math.scholmd-math-inline
```

### Display math

```haml
%span.math.scholmd-math-display
```

## Floats

### Captions

Captions are always contained in the following semantics:

```haml
.scholmd-float-caption
    %figcaption
        %span.scholmd-caption-head
            %span.scholmd-caption-head-prefix
            %span.scholmd-caption-head-label
        %span.scholmd-caption-text
```

and so are subcaptions (for multifigs)

```haml
.scholmd-float-subcaption
    %figcaption
        %span.scholmd-caption-head
            %span.scholmd-caption-head-prefix
            %span.scholmd-caption-head-label
        %span.scholmd-caption-text
```

### Figures

```haml
%figure.scholmd-float.scholmd-figure.[scholmd-widefloat]
    .scholmd-float-content
        --- many
        %figure.scholmd-subfig
                %img
            .scholmd-float-subcaption (only with >1 subfig)
        ...(repeat, with possible <br>)
    .scholmd-float-caption
```

### Table

```haml
%figure.scholmd-float.scholmd-table-float.[scholmd-widefloat]
    .scholmd-float-content
        %table
    .scholmd-float-caption
```

### Algorithm

```haml
%figure.scholmd-float.scholmd-algorithm.[scholmd-widefloat]
    .scholmd-float-content
        %p
    .scholmd-float-caption
```

### Code/Listings

```haml
%figure.scholmd-float.scholmd-listing-float.[scholmd-widefloat]
    .scholmd-float-content
        %code
    .scholmd-float-caption
```

## Numerical references

```haml
%span.scholmd-crossref
    %a
```

## Footnote

Reference link to footnote:

```haml
%a#fnref(REFID).footnoteRef
```

Footnote block:

```haml
.footnotes
    %hr
    %ol
        ---- (many)
        %li#fn(REFID)
```

## Citation

```haml
%span.scholmd-citation[data-cites="CITATION IDS DELIMITED BY SPACE"]
```

## Bibliography

```haml
.references
    %p (one for each reference)
```

