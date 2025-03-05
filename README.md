## A Collection of Proteome Panels and Meta-Data

It aggregates protein panel data and metadata for protein quantitative
trait locus (pQTL) tools, 'pQTLtools', <https://jinghuazhao.github.io/pQTLtools/>.
The data encompass affinity-based panels such as 'Olink', <https://olink.com/> and
'Somascan', <https://somalogic.com/>, along with their mass spectrometry-based
counterparts from 'CellCarta', <https://cellcarta.com/> and 'Seer', <https://seer.bio/>.
The metadata include updated annotations and publication details.

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
