#' @title Caprion panel
#' @description Information based on Caprion pilot studies
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 987 rows and 12 variables:
#' \describe{
#'   \item{\code{Gene}}{HGNC symbols simplified in four instances}
#'   \item{\code{Gene.orig}}{HGNC symbol}
#'   \item{\code{Protein}}{Protein name as in UniProt}
#'   \item{\code{Accession}}{UniProt id}
#'   \item{\code{Protein.Description}}{Detailed information on protein}
#'   \item{\code{GO.Cellular.Component}}{GO Ceullular component}
#'   \item{\code{GO.Function}}{GO function}
#'   \item{\code{GO.Process}}{GO process}
#'   \item{\code{ensGenes}}{Ensembl genes}
#'   \item{\code{chrom}}{chromosome}
#'   \item{\code{chr}}{chromosome}
#'   \item{\code{starts}}{start positions}
#'   \item{\code{ends}}{end positions}
#'   \item{\code{start}}{minimum start}
#'   \item{\code{end}}{maximum end}
#' }
#' @details See the Caprion repository involving its use. Efforts have been put to check against hg19Tables in this package though a modified version is not generated except the scripts (namely, scripts/caprion.R).

"caprion"
