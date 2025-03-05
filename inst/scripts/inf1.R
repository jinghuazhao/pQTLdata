create_inf1 <- function()
{
  library(gap)
  load("biomaRt.rda")
  v <- c("ensembl_gene_id","chromosome_name","start_position","end_position","hgnc_symbol","uniprotswissprot")
  FGF5_CD6 <- unique(subset(biomaRt[v],hgnc_symbol%in%c("FGF5","CD6")))
  FGF5_CD6["uniprotswissprot"] <- with(subset(inf1,gene%in%c("FGF5","CD6")),uniprot)
  s <- unique(subset(biomaRt[v],uniprotswissprot%in%inf1$uniprot))
  t <- merge(inf1,rbind(s,FGF5_CD6)[c("ensembl_gene_id","uniprotswissprot")],by.x="uniprot",by.y="uniprotswissprot")
  t[with(t,uniprot)%in%c("Q8NF90","Q8WWJ7"),"uniprot"] <- c("P12034","P30203")

# The following reflects recent changes at www.uniprot.org
  g <- c("CCL2", "CCL7", "CCL8", "CCL11", "CCL13", "CXCL6")
  p <- c("MCP.1", "MCP.3", "MCP.2", "CCL11", "MCP.4", "CXCL6")
  pg <- data.frame(prot=p,alt_name=g)
  inf1 <- merge(t,pg,by="prot",all.x=TRUE)
# The following reflects recent changes at https://www.ensembl.org/
  sevens <- "
  ENSG00000131142 CCL25 19 8052318 8062660
  ENSG00000125735 TNFSF14 19 6661253 6670588
  ENSG00000275302 CCL4 17 36103827 36105621
  ENSG00000274736 CCL23 17 36013056 36017972
  ENSG00000013725 CD6 11 60971680 61020377
  ENSG00000138675 FGF5 4 80266639 80336680
  ENSG00000277632 CCL3 17 36088256 36090169
  "
  updates <- as.data.frame(scan(file=textConnection(sevens),what=list("","",0,0,0)))
  names(updates) <- c("ensGene","gene","chromosome","start38","end38")
  inf1 <- merge(inf1,updates,by="gene",all.x=TRUE)

  save(inf1,file="inf1.rda",compress='xz')
}
