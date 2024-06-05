options(width=200)
suppressMessages(library(dplyr))
require(openxlsx)
url <- "https://www.biorxiv.org/content/biorxiv/early/2024/06/01/2024.05.27.596028/DC4/embed/media-4.xlsx?download=true"
seer1980 <- read.xlsx(url,sheet=2,colNames=TRUE,skipEmptyRows=TRUE,startRow=3) %>%
            select(-c(CHR,SNP,POS,EFF,N,BETA,STAT,P,LAMBDA,cis))
save(seer1980,file="seer1980.rda",compress="xz")
