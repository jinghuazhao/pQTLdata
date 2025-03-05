create_caprion <- function()
{
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
  caprion_ensembl <- left_join(caprion, filter(gene_ensembl,chromosome_name %in% c(paste(1:22),"X")),
                               by = c("Gene" = "hgnc_symbol")) %>%
                      group_by(Gene,Protein,Accession,Protein.Description,GO.Cellular.Component,GO.Function,GO.Process) %>%
                      summarize(ensGenes=paste(ensembl_gene_id,collapse=";"),
                                chrom=unique(chromosome_name),
                                starts=paste(start_position,collapse=";"),
                                ends=paste(end_position,collapse=";"),
                                start=min(start_position),end=max(end_position))
  caprion_ensembl[-c(1,4:7)] |> filter(ensGenes=="NA")
  ## A tibble: 12 × 8
  ## Groups:   Protein, Accession [12]
  #   Protein     Accession ensGenes chrom starts ends  start   end
  #   <chr>       <chr>     <chr>    <chr> <chr>  <chr> <int> <int>
  # 1 AMY1_HUMAN  P04745    NA       NA    NA     NA       NA    NA
  # 2 CT027_HUMAN Q9GZN8    NA       NA    NA     NA       NA    NA
  # 3 CO4B_HUMAN  P0C0L5    NA       NA    NA     NA       NA    NA
  # 4 CG026_HUMAN Q96N11    NA       NA    NA     NA       NA    NA
  # 5 CD97_HUMAN  P48960    NA       NA    NA     NA       NA    NA
  # 6 FA49B_HUMAN Q9NUQ9    NA       NA    NA     NA       NA    NA
  # 7 GLCM_HUMAN  P04062    NA       NA    NA     NA       NA    NA
  # 8 HBA_HUMAN   P69905    NA       NA    NA     NA       NA    NA
  # 9 H4_HUMAN    P62805    NA       NA    NA     NA       NA    NA
  #10 NHRF1_HUMAN O14745    NA       NA    NA     NA       NA    NA
  #11 SYWC_HUMAN  P23381    NA       NA    NA     NA       NA    NA
  #12 SYYC_HUMAN  P54577    NA       NA    NA     NA       NA    NA

  Sys.setlocale("LC_CTYPE", "en_US.UTF-8")
  library(httr)
  library(jsonlite)
  accession_list <- c("P04745", "Q9GZN8", "P0C0L5", "Q96N11", "P48960",
                      "Q9NUQ9", "P04062", "P69905", "P62805", "O14745",
                      "P23381", "P54577")
  base_url <- "https://www.uniprot.org/uniprot/"
  results <- list()
  for (accession in accession_list) {
      url <- paste0(base_url, accession, ".json")
      response <- GET(url)
      print(paste("Accessing:", url))
      print(paste("Status Code:", status_code(response)))
      if (status_code(response) == 200) {
          raw_content <- content(response, "text")
          utf8_content <- iconv(raw_content, from = "latin1", to = "UTF-8")
          data <- fromJSON(utf8_content)
          print(paste("Data for:", accession))
          print(data)
          if ("inactiveReason" %in% names(data)) {
              merged_ids <- data$inactiveReason$mergeDemergeTo
              if (length(merged_ids) > 0) {
                  results[[accession]] <- merged_ids
              } else {
                  results[[accession]] <- "No merged IDs"
              }
          } else {
              results[[accession]] <- "Active, no merged IDs"
          }
      } else {
          results[[accession]] <- paste("Error: Status code", status_code(response))
      }
  }
  print(results)
  library(httr)
  library(jsonlite)
  base_url <- "https://www.uniprot.org/uniprot/"
  all_ensembl_gene_ids <- list()
  for (accession in accession_list) {
      url <- paste0(base_url, accession, ".json")
      response <- GET(url)
      if (status_code(response) == 200) {
          raw_content <- content(response, "text")
          utf8_content <- iconv(raw_content, from = "latin1", to = "UTF-8")
          data <- fromJSON(utf8_content)  # Parse JSON
          ensembl_ids <- NULL
          if ("genes" %in% names(data)) {
              for (gene in data$genes) {
                  if ("identifier" %in% names(gene)) {
                      if (grepl("ENSEMBL", gene$identifier)) {
                          ensembl_ids <- c(ensembl_ids, gene$identifier)
                      }
                  }
              }
          }
          if (is.null(ensembl_ids) || length(ensembl_ids) == 0) {
              if ("secondaryAccessions" %in% names(data)) {
                  ensembl_ids <- data$secondaryAccessions
              }
          }
          if (is.null(ensembl_ids) || length(ensembl_ids) == 0) {
              all_ensembl_gene_ids[[accession]] <- "Ensembl gene ID not available"
          } else {
              all_ensembl_gene_ids[[accession]] <- ensembl_ids
          }
      } else {
          all_ensembl_gene_ids[[accession]] <- paste("Error: Status code", status_code(response))
      }
  }
  print(all_ensembl_gene_ids)
  all_ensembl_gene_ids$P04745 <- results$P04745

  uniprot_list <- list(
    P04745 = c("P0DTE7", "P0DUB6", "P0DTE8"),
    Q9GZN8 = c("A8K4J0", "D3DVX8", "Q5JX81", "Q9NWX3"),
    P0C0L5 = c("A2BHY4", "P01028", "P78445", "Q13160", "Q13906", "Q14033", "Q14835", "Q6U2E9",
               "Q6U2G1", "Q6U2I5", "Q6U2L1", "Q6U2L7", "Q6U2L9", "Q6U2M5", "Q6VCV8", "Q96SA7", "Q9NPK5", "Q9UIP5"),
    Q96N11 = c("Q9BQ43"),
    P48960 = c("A8K7Z4", "B2RBJ9", "O00718", "O76101", "Q8NG72", "Q8TBQ7"),
    Q9NUQ9 = c("Q96AZ5", "Q9NW21", "Q9NZE7"),
    P04062 = c("A8K796", "B7Z5G2", "B7Z6S1", "J3KQG4", "J3KQK9", "Q16545", "Q4VX22", "Q6I9R6", "Q9UMJ8"),
    P69905 = c("P01922", "Q1HDT5", "Q3MIF5", "Q53F97", "Q96KF1", "Q9NYR7", "Q9UCM0"),
    P62805 = c("A2VCL0", "P02304", "P02305", "Q6DRA9", "Q6FGB8", "Q6NWP7"),
    O14745 = c("B3KY21", "O43552", "Q86WQ5"),
    P23381 = c("A6NGN1", "A6NID3", "P78535", "Q502Y0", "Q53XB6", "Q9UDI5", "Q9UDL3"),
    P54577 = c("B3KWK4", "D3DPQ4", "O43276", "Q53EN1")
  )
  get_gene_positions <- function(uniprot_ids) {
    results <- getBM(attributes = c("uniprotswissprot", "ensembl_gene_id", 
                                    "hgnc_symbol", "chromosome_name", 
                                    "start_position", "end_position"),
                     filters = "uniprotswissprot",
                     values = uniprot_ids, 
                     mart = ensembl)
    return(results)
  }
  get_gene_positions_ensembl <- function(uniprot_ids) {
    ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
    results <- getBM(
      attributes = c("uniprotswissprot", "ensembl_gene_id", "hgnc_symbol", "chromosome_name", "start_position", "end_position"),
      filters = "uniprotswissprot",
      values = uniprot_ids,
      mart = ensembl
    )
    return(results)
  }
  all_gene_positions <- list()
  for (uniprot_id in accession_list) {
    gene_positions <- get_gene_positions_ensembl(uniprot_id)
    if (nrow(gene_positions) > 0) {
      all_gene_positions[[uniprot_id]] <- gene_positions
    } else {
      all_gene_positions[[uniprot_id]] <- "No data found"
    }
  }
  all_gene_positions$P04745 <- get_gene_positions(uniprot_list$P04745)
  print(all_gene_positions)
  do.call("rbind",all_gene_positions)
  all_gene_positions[[1]]$ uniprotswissprot <- "P04745"
  collapsed_data <- lapply(all_gene_positions, function(df) {
                           df %>%
                           mutate(chromosome_name = if_else(grepl("HS", chromosome_name), "6", as.character(chromosome_name))) %>%
                           group_by(uniprotswissprot) %>%
                           summarise(
                              ensembl_gene_id = paste(ensembl_gene_id, collapse = ";"),
                              hgnc_symbol = paste(hgnc_symbol, collapse = ";"),
                              chrs = paste(unique(chromosome_name), collapse = ";"),
                              starts = paste(start_position, collapse = ";"),
                              ends = paste(end_position, collapse = ";"),
                              start = min(as.numeric(start_position), na.rm = TRUE),
                              end = max(as.numeric(end_position), na.rm = TRUE)
                           )
                    })
  print(collapsed_data)
  caprion_modified <- left_join(caprion_ensembl, do.call("rbind", collapsed_data), by = c("Accession" = "uniprotswissprot")) %>%
                      mutate(ensGenes = na_if(ensGenes, "NA"),
                             starts = coalesce(starts.x, starts.y),
                             ends = coalesce(ends.x, ends.y),
                             ensGenes = coalesce(ensGenes, ensembl_gene_id),
                             Gene = coalesce(Gene, hgnc_symbol),
                             Gene.orig = coalesce(Gene, hgnc_symbol),
                             chr = coalesce(chrom, chrs),
                             start = coalesce(start.x, start.y),
                             end = coalesce(end.x, end.y)) %>%
                      select(-c(chrs, starts.x, ends.x, starts.y, ends.y, start.x, start.y, end.x, end.y, hgnc_symbol, ensembl_gene_id))
  caprion <- caprion_modified
  lines <- c(46,137,441,452)
  caprion[lines,"Gene"]
  caprion[lines,"Gene"] <- c("AMY1","C4B","HBA","HIST")
  save(caprion,file='caprion.rda',compress='xz')
}

caprion_legacy <- function()
{
  # Check the resulting data frame
  print(caprion_modified)
  # https://www.uniprot.org/
  # P04745 ->  P0DTE7, P0DTE8, and P0DUB6
  manual_check <- '
  P04745,AMY1A;AMY1B;AMY1C,
  Q9GZN8,ADISSP,
  P0C0L5,C4B;C4B_2,
  Q96N11,INTS15,
  P48960,ADGRE5, 
  Q9NUQ9,CYRIB,
  P04062,GBA1,
  P69905,HBA1;HBA2,
  P62805,H4C1;H4C2;H4C3;H4C4;H4C5;H4C6;H4C8;H4C9;H4C11;H4C12;H4C13;H4C14;H4C15;H4C16,
  O14745,NHERF1,
  P23381,WARS1,
  P54577,YARS1'

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
  u <- select(caprion_ensembl,-c(chrom,start,end)) %>%
       left_join(ucsc,by=c("Accession"="acc")) %>%
       mutate(chrom=nodup(chrom)) %>%
       filter(!is.na(Protein))
  # The following check shows merge by uniprot is more sensible
  filter(p,Accession!=acc)
  filter(p,Gene!=gene)
  filter(p,is.na(start))
  filter(u,Protein!=prot)
  umiss <- with(u,is.na(start))
  pull(u[umiss,],Accession)
  # "P04745" "P02655" "P55056" "P0C0L5" "P62805" "P69905"
  # confirmed form UniProt.org that Gene is more up-to-date
  # (obsolute), (APOC2), (APOC4), (C4B; C4B_2), (H4C1; H4C2; H4C3; H4C4; H4C5; H4C6; H4C8; H4C9; H4C11; H4C12; H4C13; H4C14; H4C15; H4C16), (HBA1; HBA2)
  # They are amended according to glist-hg19 in the function below.
  u[umiss,"Protein"] <- paste0(c("AMY1","APOC2","APOC4","CO4B","H4","HBA"),"_HUMAN")
  u[umiss,"Gene"] <- c("AMY1","APOC2","APOC4","CO4B","H4C","HBA")
  u[umiss,"chrom"] <- c("chr1","chr19","chr19","chr6","chr6","chr16")
  u[umiss,"start"] <- c(104198140,45449238,45445494,31949833,26021906,222845)
  u[umiss,"end"] <- c(104301311,45452822,45452822,32003195,27841289,227520)
  caprion_modified <- rename(u,chrom.u=chrom,start.u=start,end.u=end)
  a <- u[umiss,] %>%
       transmute(acc=Accession,prot=Protein,gene=Gene,chrom,start,end)
  ucsc2 <- ucsc %>%
           mutate(prot=nodup(prot),chrom=nodup(chrom),gene=nodup(gene)) %>%
           bind_rows(a)
  caprion_ucsc_modified <- left_join(caprion_modified,ucsc2) %>%
                           mutate(chrom=if_else(is.na(chrom),paste(unique(strsplit(chrom.u, ";")[[1]]), collapse = ";"),chrom),
                                  start=if_else(is.na(start),start.u,start),
                                  end=if_else(is.na(end),end.u,end)) %>%
                           select(-c(acc,prot,gene,chrom.u,start.u,end.u))
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
}
