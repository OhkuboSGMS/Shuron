#!/bin/sh
pandoc  --bibliography=reference.bib --csl=aaai.csl  --filter pandoc-crossref $1.md -o $1.tex  --filter tbl-filter.py --data-dir . --template template.tex
platex $1.tex  -o $1.dvi
platex $1.tex  -o $1.dvi
dvipdfmx $1.dvi
open $1.pdf
