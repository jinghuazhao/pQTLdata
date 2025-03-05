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
#' [`caprion`]               |   Caprion panel
#' [`inf1`]                  |   Olink/INF panel
#' [`Olink_Explore_1536`]    |   Olink/NGS 1472 panels
#' [`Olink_Explore_3072`]    |   Olink/Explore 3072 panels
#' [`Olink_Explore_HT`]      |   Olink/Explore HT panels
#' [`Olink_Target_96`]       |   Olink/Target 96 panels
#' [`Olink_qPCR`]            |   Olink/qPCR panels
#' [`SomaScan160410`]        |   SomaScan panel
#' [`SomaScanV4.1`]          |   SomaScan v4.1 panel
#' [`SomaScan11k`]           |   SomaScan 11k panel
#' [`scallop_inf1`]          |   SCALLOP/INF meta-analysis results
#' [`seer1980`]              |   ST1 from Suhre et al. (2024) bioRxiv
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
#' \donttest{
#' # Olink-SomaScan panel overlap
#' p <- list(setdiff(inf1$uniprot,"P23560"),
#'           setdiff(SomaScan160410$UniProt[!is.na(SomaScan160410$UniProt)],"P23560"))
#' cnames <- c("INF1","SomaScan")
#' os <- VennDiagram::venn.diagram(x = p, category.names=cnames, filename=NULL,
#'                                 disable.logging = TRUE,height=8,width=8,units="in")
#' grid::grid.newpage()
#' grid::grid.draw(os)
#' m <- merge(inf1,SomaScan160410,by.x="uniprot",by.y="UniProt")
#' u <- setdiff(with(m,unique(uniprot)),"P23560")
#' o <- subset(inf1,uniprot %in% u)
#' dim(o)
#' vars <- c("UniProt","chr","start","end","extGene","Target","TargetFullName")
#' s <- subset(SomaScan160410[vars], UniProt %in% u)
#' dim(s)
#' us <- s[!duplicated(s),]
#' dim(us)
#' us
#' }

"_PACKAGE"
