# SCALLOP/INF results

xlsx <- 'https://static-content.springer.com/esm/art%3A10.1038%2Fs41590-023-01588-w/MediaObjects/41590_2023_1588_MOESM5_ESM.xlsx'
scallop_inf1 <- openxlsx::read.xlsx(xlsx, sheet=5, colNames=TRUE, skipEmptyRows=TRUE, startRow=2)
save(scallop_inf1,file='scallop_inf1.rda',compress='xz')
