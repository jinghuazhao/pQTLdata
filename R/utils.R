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

#' @title Olink/INF1 panel
#' @description The panel is based on SCALLOP-INF
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

"inf1"

#' @title Olink/qPCR panel
#' @description Information based on pilot studies
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 1472 rows and 3 variables:
#' \describe{
#'   \item{\code{UniProt}}{UniProt id}
#'   \item{\code{Assay}}{Experimental assay}
#'   \item{\code{Panel}}{Olink panel}
#' }
#' @details Curated from R.

"Olink_Explore_1536"

#' @title Olink/Explore 3072 panels
#' @description Information on all qPCR panels
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 2945 rows and 4 variables:
#' \describe{
#'   \item{\code{UniProt.ID}}{UniProt id}
#'   \item{\code{Protein.name}}{Protein name}
#'   \item{\code{Gene.name}}{Gene name}
#'   \item{\code{Explore.384.panel}}{Explore 384 panel}
#' }
#' @details Curated from Excel.

"Olink_Explore_3072"

#' @title Olink/Explore HT panels
#' @description Information on all qPCR panels
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 5343 rows and 3 variables:
#' \describe{
#'   \item{\code{UniProt.ID}}{UniProt id}
#'   \item{\code{Protein.name}}{Protein name}
#'   \item{\code{Gene.name}}{Gene name}
#' }
#' @details Curated from Excel.

"Olink_Explore_HT"

#' @title Olink/NGS panels
#' @description Information on all qPCR panels
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 1112 rows and 7 variables:
#' \describe{
#'   \item{\code{UniProt}}{UniProt id}
#'   \item{\code{Panel}}{Panels}
#'   \item{\code{Target}}{Protein}
#'   \item{\code{gene}}{HGNC symbol}
#'   \item{\code{chr}}{Chromosome}
#'   \item{\code{start}}{start}
#'   \item{\code{end}}{end}
#' }
#' @details Curated from Excel.

"Olink_qPCR"

#' @title Seer 1980 panel
#' @description ST1 from Suhre et al. (2024) bioRxiv
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 1980 rows:
#' \describe{
#'   \item{\code{PID.NP}}{PID.NP}
#'   \item{\code{protein_ids}}{protein_ids}
#'   \item{\code{protein_names}}{protein_names}
#'   \item{\code{mapped.UniProtID}}{mapped.UniProtID}
#'   \item{\code{mapped_gene_id}}{mapped_gene_id}
#'   \item{\code{gene_name}}{gene_name}
#'   \item{\code{description}}{description}
#'   \item{\code{chr}}{chr}
#'   \item{\code{start}}{start}
#'   \item{\code{end}}{end}
#' }
#' @details As above.

"seer1980"

#' @title Somascan panel
#' @description This is based on panel used in Sun et al. (2018) Nature.
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 5178 rows and 10 variables:
#' \describe{
#'   \item{\code{SOMAMER_ID}}{Somamer id}
#'   \item{\code{UniProt}}{UniProt id}
#'   \item{\code{Target}}{Protein target}
#'   \item{\code{TargetFullName}}{Protein target full name}
#'   \item{\code{chr}}{chromosome (1-22,X,Y)}
#'   \item{\code{start}}{start}
#'   \item{\code{end}}{end}
#'   \item{\code{entGene}}{entrez gene}
#'   \item{\code{ensGene}}{ENSEMBL gene}
#'   \item{\code{extGene}}{external gene}
#' }
#' @details from the INTERVAL study.

"SomaScan160410"

#' @title SomaScan v4.1
#' @description This is the 7k panel
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 7288 rows and 6 variables:
#' \describe{
#'   \item{\code{#}}{A serial number}
#'   \item{\code{SeqID}}{SeqID}
#'   \item{\code{Human.Target.or.Analyte}}{Human target/analyte}
#'   \item{\code{UniProt.ID}}{UniProt id}
#'   \item{\code{GeneID}}{HGNC symbol}
#'   \item{\code{Type}}{"Protein"}
#' }
#' @details obtained directly from SomaLogic.

"SomaScanV4.1"

#' @title SomaScan 11k
#' @description This is also the latest panel
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 10,776 rows and 5 variables:
#' \describe{
#'   \item{\code{Sequence.ID}}{Sequence ID}
#'   \item{\code{Full.Name}}{Full name}
#'   \item{\code{Target.Name}}{Target name}
#'   \item{\code{UniProt.ID}}{UniProt ID}
#'   \item{\code{Entrez.Gene.Name}}{Entrez gene name}
#' }
#' @source https://somalogic.com/somascan-11k-assay/
#' @details curated from SomaLogic website.

"SomaScan11k"

#' @title SWATH-MS panel
#' @description Curated during INTERVAL pilot study.
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 684 rows and 5 variables:
#' \describe{
#'   \item{\code{Accession}}{UniProt id}
#'   \item{\code{accList}}{List of UniProt ids}
#'   \item{\code{uniprotName}}{Protein}
#'   \item{\code{ensGene}}{ENSEMBL gene}
#'   \item{\code{geneName}}{HGNC symbol}
#' }
#' @details As above.

"swath_ms"

#' @title Supplementary table 3
#' @description Supplementary information for Zhao et al. (2023) Nature Immunnology
#' @docType data
#' @keywords datasets internal
#' @format A data frame with 180 rows and 19 variables:
#'   \describe{
#'   \item{UniProt}{UnitProt ID}
#'   \item{Protein}{Protein name}
#'   \item{Protein_gene_symbol}{Gene symbol}
#'   \item{Chromosome}{Chromosome}
#'   \item{Position}{Position}
#'   \item{cistrans}{cis/trans}
#'   \item{rsid}{reference sequence ID}
#'   \item{Effect_allele}{Effect allele}
#'   \item{Other_allele}{Eeference allele}
#'   \item{EAF}{Effect allele frequency}
#'   \item{b}{b}
#'   \item{SE}{SE}
#'   \item{log10P}{log10(P)}
#'   \item{Direction}{Direction field in METAL output}
#'   \item{HetISq}{I^2}
#'   \item{HetChiSq}{Heterogeneity chi-square}
#'   \item{HetDf}{I^2}
#'   \item{logHetP}{Heterogeneity log10(P)}
#'   \item{N}{N}
#' }

"scallop_inf1"
