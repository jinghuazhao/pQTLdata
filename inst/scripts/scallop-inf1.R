# INTERVAL SomaLogic results
dir <- 'https://static-content.springer.com/esm/art%3A10.1038%2Fs41586-018-0175-2/MediaObjects/'
file <- '41586_2018_175_MOESM4_ESM.xlsx'

# SCALLOP/INF results
dir <- "https://jhz22.user.srcf.net/SCALLOP-INF/"
file <- "Supplementary-Tables.xlsx"
xlsx <- paste0(dir,file)
scallop_inf1 <- openxlsx::read.xlsx(xlsx, sheet=5, colNames=TRUE, skipEmptyRows=TRUE, startRow=2)
save(scallop_inf1,file='scallop_inf1.rda',compress='xz')
