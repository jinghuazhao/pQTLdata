create_hg19 <- function()
{
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
}

create_hg19_makeOrganismPackage <- function()
{
  library(OrganismDbi)
  gd <- list(join1 = c(GO.db="GOID", org.Hs.eg.db="GO"),
             join2 = c(org.Hs.eg.db = "ENTREZID", TxDb.Hsapiens.UCSC.hg19.knownGene = "GENEID"))
  destination <- tempfile()
  dir.create(destination)
  makeOrganismPackage(pkgname = "Homo.sapiens.hg19", graphData = gd,
                      organism = "Homo sapiens", version = "1.0.0",
                      maintainer = "Maintainer<maintainer@email>",
                      author = "Author Name", destDir = destination,
                      license = "Artistic-2.0")
  library(Homo.sapiens.hg19)
  Homo.sapiens.hg19
  cols <- columns(Homo.sapiens.hg19)
  cols
  tx <- transcripts(Homo.sapiens.hg19, columns=c("UNIPROT","SYMBOL","ENSEMBL"))
  chrs <- paste0("chr",c(1:22,'X','Y'))
  hg19 <- subset(as.data.frame(tx),seqnames %in% chrs & !is.na(UNIPROT))
  names(hg19)[1] <- "chr"
  save(hg19,file='hg19.rda',compress='xz')
}

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
