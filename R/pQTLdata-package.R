#' A summary of datasets
#'
#' \tabular{ll}{
#' Objects              \tab   Description\cr
#' \cr
#' \strong{Datasets}\cr
#' \cr
#' biomaRt              \tab   Curated data from biomaRt\cr
#' caprion              \tab   Caprion panel\cr
#' hg19                 \tab   Curated data from Bioconductor\cr
#' hg19Tables           \tab   Curated data from UCSC genome browser\cr
#' inf1                 \tab   Olink/INF panel\cr
#' Olink_Explore_1536   \tab   Olink/NGS 1472 panels\cr
#' Olink_Explore_3072   \tab   Olink/Explore 3072 panels\cr
#' Olink_Explore_HT     \tab   Olink/Explore HT panels\cr
#' Olink_qPCR           \tab   Olink/qPCR panels\cr
#' SomaLogic160410      \tab   SomaLogic panel\cr
#' SomaScanV4.1         \tab   SomaScan v4.1 panel\cr
#' SomaScan11k          \tab   SomaScan 11k panel\cr
#' scallop_inf1         \tab   SCALLOP/INF meta-analysis results\cr
#' st4                  \tab   ST4 of the INTERVAL SomaLogic paper\cr
#' st6                  \tab   ST6 of the INTERVAL SomaLogic paper\cr
#' st18                 \tab   ST18 of the INTERVAL SomaLogic paper\cr
#' swath_ms             \tab   SWATH-MS panel\cr
#' \cr
#' \strong{Installations}\cr
#' \cr
#' EndNote              \tab   Proteogenomics references\cr
#' Olink                \tab   Olink-COVID analysis by MGH\cr
#' \cr
#' }
#'
#' Some generic description for the datasets are as follows.
#' -  chr Chromosome.
#' -  start Start position.
#' -  end End position.
#' -  gene Gene name.
#' -  UniProt UniProt ID.
#'
#' @docType package
#' @name pQTLdata
#' @aliases pQTLdata-package
#'
#' @import knitr
#'
#' @examples
#' \dontrun{
#' # datasets
#' head(biomaRt)
#'
#' # Olink-SomaLogic panel overlap
#' p <- list(setdiff(inf1$uniprot,"P23560"),
#'           setdiff(SomaLogic160410$UniProt[!is.na(SomaLogic160410$UniProt)],"P23560"))
#' cnames <- c("INF1","SomaLogic")
#' VennDiagram::venn.diagram(x = p, category.names=cnames,
#'                           filename='os.png', imagetype="png", output=TRUE)
#' m <- merge(inf1,SomaLogic160410,by.x="uniprot",by.y="UniProt")
#' u <- setdiff(with(m,unique(uniprot)),"P23560")
#' options(width=220)
#' o <- subset(inf1,uniprot %in% u)
#' dim(o)
#' o
#' vars <- c("UniProt","chr","start","end","extGene","Target","TargetFullName")
#' s <- subset(SomaLogic160410[vars], UniProt %in% u)
#' dim(s)
#' us <- s[!duplicated(s),]
#' dim(us)
#' us
#'
#' # SCALLOP/INF1
#' INF <- Sys.getenv("INF")
#' INF1_merge <- merge(inf1,
#'                     read.delim(file.path(INF,"work","INF1.merge-rsid"),as.is=TRUE),
#'                     by="prot")
#' INF1_uniprot <- unique(with(INF1_merge,uniprot))
#'
#' # INTERVAL SomaLogic at box
#' HOME <- Sys.getenv("HOME")
#' box <- read.delim(file.path(HOME,"SomaLogic","doc","INTERVAL-box.tsv"),as.is=TRUE)
#' box_INF1 <- subset(box,UniProt %in% INF1_uniprot)
#' box_uniprot <- setdiff(unique(with(box_INF1,UniProt)),"P23560")
#' setdiff(INF1_uniprot,box_uniprot)
#'
#' # Phenoscanner database
#' ps <- merge(subset(read.delim(file.path(INF,"work","pQTL_2018.txt.gz"),as.is=TRUE),
#'             pmid==29875488),
#'             box,by.x="trait",by.y="TargetFullName")
#' z <- subset(ps,UniProtgwas %in% INF1_uniprot & p<=1.5e-11)
#'
#' # ST4 on Nature
#' st4regions <- subset(st4, UniProt %in% INF1_uniprot)
#' unique_uniprot_list <- setdiff(intersect(st4$UniProt,inf1$uniprot),"P23560")
#' subset(INF1_merge,uniprot %in% unique_uniprot_list)
#' }
#' @author Jing Hua Zhao in collaboration with other colleagues
#' @keywords internal

"_PACKAGE"
