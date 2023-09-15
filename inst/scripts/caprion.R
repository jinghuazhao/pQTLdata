HOME <- Sys.getenv("HOME")
load(paste(HOME,"Caprion","pilot",,"caprion.rda",sep="/"))
caprion <- protein_list
save(caprion,file='caprion.rda',compress='xz')

library(pQTLdata)
library(dplyr)
library(valr)

modify <- function()
{
# glist-hg19
  INF <- Sys.getenv("INF")
  glist_hg19 <- read.table(file.path(INF,"csd3","glist-hg19"),col.names=c("chr","start","end","gene")) %>%
                filter(! chr %in% c("XY","Y"))
  X <- with(glist_hg19,chr=="X")
  glist_hg19[X,"chr"] <- "23"
  ucsc <- transmute(pQTLdata::hg19Tables,chr=gsub("chr","",X.chrom),start=chromStart,end=chromEnd,Gene=hgncSym) %>%
          select(Gene,chr,start,end)
  X <- with(ucsc,chr=="X")
  ucsc[X,"chr"] <- "23"
  caprion <- select(pQTLdata::caprion,Protein,Accession,Gene) %>%
             mutate(Protein=gsub("_HUMAN","",Protein)) %>%
             rename(prot=Protein)
  quadruple <- function(d,label) data.frame(Gene=label,chr=min(d$chr),start=min(d$start),end=max(d$end))
  subset(glist_hg19,grepl("^AMY1",gene))
  subset(glist_hg19,grepl("^C4B",gene)&chr=="6")
  subset(glist_hg19,grepl("^HIST1H4|^HIST2H4[A-B]|HIST4H4",gene))
  subset(glist_hg19,grepl("^HBA",gene))
  AMY <- quadruple(subset(glist_hg19,grepl("^AMY1",gene)),label="AMY")
  C4B <- quadruple(subset(glist_hg19,grepl("^C4B",gene)&chr=="6"),label="C4B")
  HIST <- quadruple(subset(glist_hg19,grepl("^HIST1H4|^HIST2H4[A-B]|HIST4H4",gene)),label="HIST")
  HBA <- quadruple(subset(glist_hg19,grepl("^HBA",gene)),label="HBA")
  caprion_modified <- caprion
  caprion_modified[55,"Gene"] <- "AMY"
  caprion_modified[237,"Gene"] <- "C4B"
  caprion_modified[278,"Gene"] <- "C1orf123"
  caprion_modified[385,"Gene"] <- "FYB"
  caprion_modified[390,"Gene"] <- "FAM198A"
  caprion_modified[433,"Gene"] <- "HIST"
  caprion_modified[435,"Gene"] <- "HBA"
  caprion_modified[845,"Gene"] <- "SEPT2"
  caprion_modified[846,"Gene"] <- "SEPT7"
  APOC <- subset(glist_hg19,gene %in%c("APOC2","APOC4")) %>%
          rename(Gene=gene)
  ucsc_modified <- bind_rows(ucsc,APOC,AMY,C4B,HIST,HBA)
  a <- filter(caprion_modified,caprion_modified[[3]]%in%ucsc_modified[["Gene"]])
  b <- filter(ucsc_modified,ucsc_modified[["Gene"]]%in%caprion_modified[["Gene"]])
  subset(b,Gene%in%subset(b,duplicated(Gene))$Gene)
}

misc <- function()
## alternatives
{
  hg19 <- select(hg19Tables,X.chrom,chromStart,chromEnd,acc,uniprotName,geneName,hgncSym) %>%
          setNames(c("chrom","start","end","uniprot","prot","gene","hgnc"))
  glist <- read.table("~/INF/csd3/glist-hg19",col.names=c("chrom","start","end","gene"))
  bed_intersect(hg19,glist)
  load("~/cambridge-ceu/turboman/turboman_hg19_reference_data.rda")
  refgenes <- refgene_gene_coordinates_h19 %>%
              mutate(chromosome=paste0("chr",chromosome)) %>%
              setNames(c("chrom","start","end","gene","mid")) %>%
              bed_intersect(glist)
# 11
  filter(caprion_modified,!caprion_modified[[3]]%in%hg19[["gene"]]) %>% pull(Gene)
  filter(caprion_modified,!caprion_modified[[3]]%in%refgene_gene_coordinates_h19[["gene_name"]]) %>% pull(Gene)
# 20
  filter(caprion_modified,!caprion_modified[3]]%in%glist[["gene"]]) %>% pull(Gene)
  filter(caprion_modified,caprion_modified[[3]]%in%ucsc_modified[["Gene"]]) %>% pull(Gene) %>% length
}
