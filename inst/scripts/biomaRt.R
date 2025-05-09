create_biomaRt <- function()
{
  library(biomaRt)
  listEnsemblArchives()
  ensembl <- useMart("ensembl", dataset="hsapiens_gene_ensembl", host="grch37.ensembl.org", path="/biomart/martservice")
  attr <- listAttributes(ensembl)
  subset(attr,grepl("ensembl",name))
  g <- c('ensembl_gene_id', 'chromosome_name', 'start_position', 'end_position', 'description', 'hgnc_symbol')
  t <- c('ensembl_transcript_id', 'transcription_start_site', 'transcript_start', 'transcript_end')
  u <- "uniprotswissprot"
  gtu <- getBM(attributes = c(g,t,u), mart = ensembl)
  biomaRt <- subset(gtu,uniprotswissprot!=""&chromosome_name%in%c(1:22,"X","Y"))
  save(biomaRt,file='biomaRt.rda',compress='xz')
}
