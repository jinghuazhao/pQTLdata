#!/usr/bin/bash

R --no-save -q <<END
  f <- file.path("..","Olink","olink-explore-ht-assay-list-2023-07-12.xlsx")
  Olink_Explore_HT <- openxlsx::read.xlsx(f, sheet=1, startRow = 5, colNames=TRUE, skipEmptyRows=TRUE)
  save(Olink_Explore_HT,file='../../data/Olink_Explore_HT.rda',compress='xz')
END
