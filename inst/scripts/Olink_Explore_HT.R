create_Olink_Explore_HT <- function()
{
  f <- file.path("..","Olink","olink-explore-ht-assay-list-2023-07-12.xlsx")
  Olink_Explore_HT <- openxlsx::read.xlsx(f, sheet=1, startRow = 5, colNames=TRUE, skipEmptyRows=TRUE)
  f <- file.path("..","Olink","olink-explore-ht-assay-list.xlsx")
  Olink_Explore_HT <- openxlsx::read.xlsx(f, sheet=1, startRow = 6, colNames=TRUE, skipEmptyRows=TRUE)
  names(Olink_Explore_HT)[1] <- "Olink.ID"
  save(Olink_Explore_HT,file='../../data/Olink_Explore_HT.rda',compress='xz')
}
