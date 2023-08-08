#!/usr/bin/bash

R --no-save -q <<END
  f <- file.path("..","Olink","assay-list-olink-explore-3072.xlsx")
  Olink_Explore_3072 <- openxlsx::read.xlsx(f, sheet=1, startRow = 3, colNames=TRUE, skipEmptyRows=TRUE)
  save(Olink_Explore_3072,file='../../data/Olink_Explore_3072.rda',compress='xz')
END
