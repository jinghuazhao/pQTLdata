#!/usr/bin/bash

iconv -l
# caught ï»¿ in front of @article{sun18, in refs.bib
iconv -f ISO-8859-1 -t UTF-8 refs.bib > refs.txt
diff refs.bib refs.txt
# caught \u2265 as in \item{\code{Uncorrelated.with.PAV.(r2≥0.1)}}{Uncorrelated with PAV}
iconv -f ISO-8859-1 -t UTF-8 utils.R > utils.txt
diff utils.R utils.txt
