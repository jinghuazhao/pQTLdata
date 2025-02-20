library(openxlsx)
fp <- file.path("..","Olink","Olink-Target-96-Assay-List.xlsx")
sn <- getSheetNames(fp)[1]
as <- lapply(sn, function(s) {read.xlsx(fp, sheet = s, startRow = 2)}) |>
             setNames(sn)
lapply(as,tail,1)
d <-  as[[1]] |>
      as.data.frame()
Olink_Target_96 <- d[-nrow(d), ] |>
                   setNames(c("UniProt","Protein","Panel"))
save(Olink_Target_96, file=file.path("..","..","data","Olink_Target_96.rda"),compress="xz")
