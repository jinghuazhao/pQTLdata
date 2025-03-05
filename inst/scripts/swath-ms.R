create_swath_ms <- function()
{
  HOME <- Sys.getenv("HOME")
  load(paste(HOME,"SWATH-MS","pilot","swath-ms.rda",sep="/"))
  swath_ms <- annotated_protein_matrix
  save(swath_ms,file='swath_ms.rda',compress='xz')
}
