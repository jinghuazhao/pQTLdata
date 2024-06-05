## pQTLdata 0.1

(2024/06/05)

* Adopt pkgdown.
* Adopt a 1/10 version increment algorithm.
* Add bookdown-driven vignette.
* Imports knitr, Rdpack
* Suggests dplyr, grid, VennDiagram.
* Remove \uFEFF characters with iconv.
* Add inst/Olink.
* Add caprion.rda and inst/scripts/caprion.R.
* Add seer1980.rda and inst/scripts/seer1980.R.
* Add biomaRt.rda, hg19.rda, hg19Tables.rda, inf1.rda, scallop_inf1, st4.rda, st6.rda, st18.rda, but drop hgTables.
  Q8NF90 and Q8WWJ7 in inf1.rda were not listed at the UCSC, and replaced with P12034 and P30203 as on UniProt.
  Tidy up various options of SomaLogic lookup (panels, box, ST4, ST6).
* First release.
