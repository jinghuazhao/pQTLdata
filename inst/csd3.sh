#!/usr/bin/bash

module load texlive

Rscript -e 'setwd("~/pQTLdata");devtools::document()'

export name=pQTLdata
export version=$(awk '/Version/{print $2}' ~/pQTLdata/DESCRIPTION)
R CMD build --compact-vignettes=both --force --md5 --resave-data ${name}
R CMD INSTALL ${name}_${version}.tar.gz

R CMD check --as-cran ${name}_${version}.tar.gz
rm -rf ${HOME}/R/${name}.Rcheck
mv ${name}_${version}.tar.gz ${name}.Rcheck R
