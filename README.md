---
output: github_document
---



## A Collection of Proteome Panels and Metadata

It aggregates protein panel data and metadata for protein quantitative trait locus (pQTL) analysis using 'pQTLtools' (<https://jinghuazhao.github.io/pQTLtools/>). The package includes data from affinity-based panels such as 'Olink' (<https://olink.com/>) and 'SomaScan' (<https://somalogic.com/>), as well as mass spectrometry-based panels from 'CellCarta' (<https://cellcarta.com/>) and 'Seer' (<https://seer.bio/>). The metadata encompasses updated annotations and publication details.

### Installation

1. Install from R

```r
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("jinghuazhao/pQTLdata")
```

2. Install from GitHub repository

```bash
git clone https://github.com/jinghuazhao/pQTLdata
R CMD INSTALL pQTLdata
```

3. Install from zip file

```bash
wget https://github.com/jinghuazhao/pQTLdata/archive/refs/heads/main.zip
unzip main
```

### A summary of datasets

```r
library(help=pQTLdata)
help(pQTLdata)
```
