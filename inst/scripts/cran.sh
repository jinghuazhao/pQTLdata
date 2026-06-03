#!/usr/bin/env bash

set -euo pipefail

src=$HOME/pQTLdata
dst=$HOME/R/pQTLdata

rsync -a --delete \
  --exclude='docs/' --exclude='pkgdown/' \
  --exclude='README.Rmd' --exclude='LICENSE.md' \
  --exclude='.*' --exclude='*/.*' \
  "$src/" "$dst/"

module load ceuadmin/R

pkg=$(awk -F': *' '$1=="Package"{print $2}' "$src/DESCRIPTION")
ver=$(awk -F': *' '$1=="Version"{print $2}' "$src/DESCRIPTION")

cd ~/R

R CMD build --compact-vignettes=both --md5 --resave-data --log "$pkg"
R CMD INSTALL --compact-docs --data-compress=xz "${pkg}_${ver}.tar.gz"
R CMD check --as-cran "${pkg}_${ver}.tar.gz"
