#' A summary of datasets
#'
#' @docType package
#' @name pQTLdata
#' @aliases pQTLdata-package
#'
#' @details
#' Available data are listed in the following table.
#'
#' Objects                   |  Description
#' --------------------------|------------------------------------
#' **Datasets**              |   &nbsp;
#' [`biomaRt`]               |   Curated data from biomaRt
#' [`caprion`]               |   Caprion panel
#' [`hg19`]                  |   Curated data from Bioconductor
#' [`hg19Tables`]            |   Curated data from UCSC genome browser
#' [`inf1`]                  |   Olink/INF panel
#' [`Olink_Explore_1536`]    |   Olink/NGS 1472 panels
#' [`Olink_Explore_3072`]    |   Olink/Explore 3072 panels
#' [`Olink_Explore_HT`]      |   Olink/Explore HT panels
#' [`Olink_qPCR`]            |   Olink/qPCR panels
#' [`SomaScan160410`]        |   SomaScan panel
#' [`SomaScanV4.1`]          |   SomaScan v4.1 panel
#' [`SomaScan11k`]           |   SomaScan 11k panel
#' [`scallop_inf1`]          |   SCALLOP/INF meta-analysis results
#' [`seer1980`]              |   ST1 from Suhre et al. (2024) bioRxiv
#' [`st4`]                   |   ST4 of the INTERVAL SomaLogic paper
#' [`st6`]                   |   ST6 of the INTERVAL SomaLogic paper
#' [`st18`]                  |   ST18 of the INTERVAL SomaLogic paper
#' [`swath_ms`]              |   SWATH-MS panel
#' **Installations**         |   &nbsp;
#' EndNote/                  |   Proteogenomics references
#' Olink/                    |   Olink-COVID analysis by MGH
#'
#' Some generic description for the datasets are as follows.
#' -  chr Chromosome.
#' -  start Start position.
#' -  end End position.
#' -  gene Gene name.
#' -  UniProt UniProt ID.
#'
#' @section Usage:
#' Vignettes on package usage:
#' - An Overview of pQTLdata. `vignette("pQTLdata")`.
#' @md
#'
#' @import knitr
#' @importFrom Rdpack reprompt
#'
#' @author Jing Hua Zhao in collaboration with other colleagues.
#' @keywords internal
#' @examples
#' \dontrun{
#' # See more on SCALLOP-INF at https://jinghuazhao.github.io/INF/
#' # datasets
#' head(biomaRt)
#'
#' # Olink-SomaScan panel overlap
#' p <- list(setdiff(inf1$uniprot,"P23560"),
#'           setdiff(SomaScan160410$UniProt[!is.na(SomaScan160410$UniProt)],"P23560"))
#' cnames <- c("INF1","SomaScan")
#' VennDiagram::venn.diagram(x = p, category.names=cnames, filename=NULL,
#'                           disable.logging = TRUE, imagetype="png", output=TRUE)
#' m <- merge(inf1,SomaScan160410,by.x="uniprot",by.y="UniProt")
#' u <- setdiff(with(m,unique(uniprot)),"P23560")
#' options(width=220)
#' o <- subset(inf1,uniprot %in% u)
#' dim(o)
#' o
#' vars <- c("UniProt","chr","start","end","extGene","Target","TargetFullName")
#' s <- subset(SomaScan160410[vars], UniProt %in% u)
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
#' # INTERVAL SomaScan data at box
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

"_PACKAGE"
