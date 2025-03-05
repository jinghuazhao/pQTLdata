# In place of makeOrganismPackage() but only kept as script for reference.

library(OrganismDbi)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
odb <- OrganismDbi::makeOrganismDbFromTxDb(txdb = TxDb.Hsapiens.UCSC.hg19.knownGene)
print(odb)
cols <- AnnotationDbi::columns(odb)
print(cols)
tx <- GenomicFeatures::transcripts(odb, columns = c("UNIPROT", "SYMBOL", "ENSEMBL"))
head(tx)
chrs <- paste0("chr", c(1:22, 'X', 'Y'))
hg19 <- subset(as.data.frame(tx), seqnames %in% chrs & !is.na(UNIPROT))
head(hg19)
names(hg19)[1] <- "chr"
head(hg19)
save(hg19,file='hg19.rda',compress='xz')

gs <- function()
# Full genome sequence
{
  suppressMessages(library(BSgenome.Hsapiens.UCSC.hg19))
  print(Hsapiens)
  suppressMessages(library(BSgenome))
  getSeq(Hsapiens,seqnames(Hsapiens))
}

hgs <- gs()
print(hgs)
