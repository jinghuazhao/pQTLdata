# SomaScan 11K

HOME <- Sys.getenv("HOME")
SomaScan11k <-read.delim(file.path(HOME,"SomaLogic","doc","SomaScan11k.tsv"))
save(SomaScan11k,file='SomaScan11k.rda',compress='xz')
