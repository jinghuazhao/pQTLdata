#!/usr/bin/bash

export npx=${HOME}/COVID-19/Olink-NGS/tmp_raw_data/20200292_Danesh_NPX_2020-06-03.csv
(
  cut -d';' -f4,5,7 ${npx} | \
  head -1
  join -t$';' <(cut -d';' -f4 ${npx} | sed '1d' | sort | uniq) \
              <(cut -d';' -f4,5,7 ${npx} | sed '1d' | sort | uniq)
) > NPX.csv

R --no-save -q <<END
  Olink_Explore_1536 <- read.csv("NPX.csv",sep=';')
  save(Olink_Explore_1536,file='Olink_Explore_1536.rda',compress='xz')
END

rm NPX.csv
