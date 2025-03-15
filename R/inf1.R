#' @title Olink/INF1 panel
#' @description The panel is based on SCALLOP-INF as in \insertCite{zhao23;textual}{pQTLdata}.
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 92 rows and 9 variables:
#' \describe{
#'   \item{\code{uniprot}}{UniProt id}
#'   \item{\code{prot}}{Protein}
#'   \item{\code{target}}{Protein target name}
#'   \item{\code{target.short}}{Protein target short name}
#'   \item{\code{gene}}{HGNC symbol}
#'   \item{\code{chr}}{chromosome (1-13,16-17,19-22)}
#'   \item{\code{start}}{start}
#'   \item{\code{end}}{end}
#'   \item{\code{chromosome}}{updated chromosomes}
#'   \item{\code{start38}}{start position under build 38}
#'   \item{\code{end38}}{end position under build 38}
#'   \item{\code{ensGene}}{Ensembl gene name}
#'   \item{\code{ensembl_gene_id}}{ENSEMBL gene}
#'   \item{\code{alt_name}}{recent name from www.uniprot.org}
#' }
#' @details Assembled for SCALLOP-INF
#' @references
#' \insertAllCited{}

"inf1"
