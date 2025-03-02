## pQTLdata 0.5

(2025/3/2)

* Revise README.md/pQTLdata.Rmd/_pkgdown.yml

## pQTLdata 0.4

(2025/3/2)

* CRAN submission
* Extend Description and add seer1980 to data/datalist.

## pQTLdata 0.3

(2025/2/20)

* Add Olink-Target-96-Assay-List.xlsx (15 panels).
* Drop olink-explore-ht-assay-list-2023-07-12.xlsx (5,343) for olink-explore-ht-assay-list.xlsx (5,416=5,400+).
* Add single quotes to software names in Title/Description inside DESCRIPTION (suggested by Uwe Ligges).
* Minor changes including splitting utils.R and vignette.

## pQTLdata 0.2

(2025/2/19)

* Remove biomaRt, hg19, hg19Tables, st[4|6|18] except their R scripts and revise vignette.
* Add Ensembl gene ID to caprion & URL to DESCRIPTION but simplify inst/scripts/docs.sh.
* Add Information on Thermo Fisher Scientific - LSMS / NCI Proteomic Data Commons.
* Add/remove information for Olink® Target 96 Inflammation Panels.
* Add inst/README.md, SomaLogic/ given SomaScan.db is developed.

## pQTLdata 0.1

(2024/06/10)

* Add
    - Olink/, EndNote/, scripts/ to inst/.
    - caprion.rda and caprion.R.
    - seer1980.rda and seer1980.R.
    - biomaRt.rda, hg19.rda, hg19Tables.rda, inf1.rda, scallop_inf1, st4.rda, st6.rda, st18.rda, but drop hgTables.
      Q8NF90 and Q8WWJ7 in inf1.rda were not listed at the UCSC, and replaced with P12034 and P30203 as on UniProt.
    - SomaScan lookup (panels, box, ST4, ST6).
* Remove \uFEFF characters with iconv.
* Adopt pkgdown, bookdown-driven vignette, a 1/10 version increment algorithm.
* Imports knitr, Rdpack.
* Suggests dplyr, grid, VennDiagram.
* First release.
