HOME <- Sys.getenv("HOME")
load(paste(HOME,"Caprion","pilot","caprion.rda",sep="/"))
caprion <- protein_list
library(biomaRt)
library(dplyr)
ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
gene_ensembl <- getBM(
  attributes = c("hgnc_symbol", "ensembl_gene_id", "chromosome_name", "start_position", "end_position"),
  filters = "hgnc_symbol",
  values = pQTLdata::caprion$Gene,
  mart = ensembl
)
caprion <- left_join(pQTLdata::caprion, gene_ensembl, by = c("Gene" = "hgnc_symbol")) %>%
           group_by(Gene,Protein,Accession,Protein.Description,GO.Cellular.Component,GO.Function,GO.Process) %>%
           summarize(ensGenes=paste(ensembl_gene_id,collapse=";"),
                     starts=paste(start_position,collapse=";"),
                     ends=paste(end_position,collapse=";"),
                     start=min(start_position),end=max(end_position))
save(caprion,file='caprion.rda',compress='xz')

library(pQTLdata)

nodup <- function(x) sapply(x, function(s) unique(unlist(strsplit(s,";")))[1])

ucsc <- hg19Tables %>%
        group_by(acc) %>%
        summarize(
             prot=paste(uniprotName,collapse=";"),
             chrom=paste(X.chrom,collapse=";"),
             start=min(chromStart),
             end=max(chromEnd),
             gene=paste(geneName,collapse=";")
        )
# uniprot IDs are the same if proteins are the same
p <- select(caprion,Accession,Protein,Gene) %>%
     left_join(ucsc,by=c("Protein"="prot")) %>%
     select(Accession,Protein,Gene,gene,acc,chrom,start,end)
# however even with same uniprotID their protein names may be different
u <- select(caprion,Accession,Protein,Gene) %>%
     left_join(ucsc,by=c("Accession"="acc")) %>%
     mutate(chrom=nodup(chrom)) %>%
     filter(!is.na(Protein)) %>%
     select(Accession,Protein,gene,Gene,prot,chrom,start,end)
# The following check shows merge by uniprot is more sensible
filter(p,Accession!=acc)
filter(p,Gene!=gene)
filter(p,is.na(start))
filter(u,Protein!=prot)
umiss <- with(u,is.na(start))
filter(u,umiss) %>% pull(Accession)
# "P04745" "P02655" "P55056" "P0C0L5" "P62805" "P69905"
# confirmed form UniProt.org that Gene is more up-to-date
# (obsolute), (APOC2), (APOC4), (C4B; C4B_2), (H4C1; H4C2; H4C3; H4C4; H4C5; H4C6; H4C8; H4C9; H4C11; H4C12; H4C13; H4C14; H4C15; H4C16), (HBA1; HBA2)
# They are amended according to glist-hg19 in the function below.
u[umiss,"Protein"] <- paste0(c("AMY1","APOC2","APOC4","CO4B","H4","HBA"),"_HUMAN")
u[umiss,"Gene"] <- c("AMY1","APOC2","APOC4","CO4B","H4C","HBA")
u[umiss,"chrom"] <- c("chr1","chr19","chr19","chr6","chr6","chr16")
u[umiss,"start"] <- c(104198140,45449238,45445494,31949833,26021906,222845)
u[umiss,"end"] <- c(104301311,45452822,45452822,32003195,27841289,227520)
caprion_modified <- u
caprion_ucsc_modified <- select(u,-c(chrom,start,end)) %>%
                         left_join(ucsc) %>%
                         select(-c(acc,prot,gene))
a <- filter(u,umiss) %>%
     transmute(acc=Accession,prot=Protein,gene=Gene,chrom,start,end)
ucsc2 <- ucsc %>%
         mutate(prot=nodup(prot),chrom=nodup(chrom),gene=nodup(gene)) %>%
         bind_rows(a)

quadruple <- function(d,label)
             with(d,data.frame(Gene=label,chrom=paste0("chr",min(chr)),start=min(start),end=max(end)))

glist_refgene <- function()
{
# glist-hg19 lookup
  INF <- Sys.getenv("INF")
  glist_hg19 <- read.table(file.path(INF,"csd3","glist-hg19"),col.names=c("chr","start","end","gene")) %>%
                filter(! chr %in% c("XY","Y"))
  X <- with(glist_hg19,chr=="X")
  glist_hg19 <- mutate(glist_hg19,chrom=paste0("chr",chr))
  glist_hg19[X,"chr"] <- "23"
  subset(glist_hg19,grepl("^AMY1",gene))
  subset(glist_hg19,grepl("^C4B",gene)&chr=="6")
  subset(glist_hg19,grepl("^HIST1H4|^HIST2H4[A-B]|HIST4H4",gene))
  subset(glist_hg19,grepl("^HBA",gene))
  AMY1 <- quadruple(subset(glist_hg19,grepl("^AMY1",gene)),label="AMY")
  C4B <- quadruple(subset(glist_hg19,grepl("^C4B",gene)&chr=="6"),label="C4B")
  HIST <- quadruple(subset(glist_hg19,grepl("^HIST1H4[A-L]",gene)),label="HIST")
  HBA <- quadruple(subset(glist_hg19,grepl("^HBA",gene)),label="HBA")
  glist_hg19 <- glist_hg19 %>%
                group_by(gene) %>%
                summarize(chrom=paste(chrom,collapse=";"),start=min(start),end=max(end)) %>%
                mutate(chrom=nodup(chrom))
# refgenes
  load("~/cambridge-ceu/turboman/turboman_hg19_reference_data.rda")
  refgenes <- refgene_gene_coordinates_h19 %>%
              mutate(chromosome=paste0("chr",chromosome)) %>%
              setNames(c("chrom","start","end","gene","mid")) %>%
              bed_intersect(glist_hg19)
}
