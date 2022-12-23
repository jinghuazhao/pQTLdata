#!/usr/bin/bash

module load gcc/6 texlive

Rscript -e 'setwd("~/pQTLdata");devtools::document()'

export name=pQTLdata
export version=0.1
R CMD build --resave-data --compact-vignettes=both ${name}
R CMD INSTALL ${name}_${version}.tar.gz

R CMD check --as-cran ${name}_${version}.tar.gz
rm -rf ${HOME}/R/${name}.Rcheck
mv ${name}_${version}.tar.gz ${name}.Rcheck R
