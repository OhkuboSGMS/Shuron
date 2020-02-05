#!/bin/sh
pandoc  -F pandoc-include  -F pandoc-crossref  -F pandoc-citeproc --bibliography=reference.bib --csl=aaai.csl  $1.md -o $1.tex  --data-dir . --top-level-division=chapter --listings --template template.tex
platex $1.tex  -o $1.dvi
platex $1.tex  -o $1.dvi
dvipdfmx $1.dvi
rm $1.dvi $1.log $1.toc $1.out $1.aux
open $1.pdf


# -F pandoc-citeproc --bibliography=reference.bib
# --filter tbl-filter.py