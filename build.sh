#!/bin/bash

CSS="css/scholmd-heuristically-latest.min.css"

scholdoc --toc --css="$CSS" --email-obfuscation=javascript -t html "Scholarly-Markdown-Guide.md" -o "Scholarly-Markdown-Guide.html"

scholdoc --css="$CSS" -t html "Scholarly-Markdown-HTML-Schema.md" -o "Scholarly-Markdown-HTML-Schema.html"

scholdoc --css="$CSS" -t html "Scholarly-Markdown-FAQ.md" -o "Scholarly-Markdown-FAQ.html"

scholdoc --css="$CSS" --email-obfuscation=javascript -t html "index.md" -o "index.html"