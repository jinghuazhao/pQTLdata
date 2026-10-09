rda <- path.expand("~/pQTLdata/data/caprion.rda")
out <- path.expand("~/Caprion/analysis/ZWK/caprion_updated.rda")

e <- new.env()
load(rda, envir = e)
caprion <- as.data.frame(e$caprion)

stopifnot(nrow(caprion) == 987L)
caprion$Accession.original <- as.character(caprion$Accession)
caprion$Accession.current <- caprion$Accession.original
caprion$Accession.status <- "unchanged"

amy1 <- caprion$Accession.original == "P04745"
stopifnot(sum(amy1) == 1L)

caprion$Accession.current[amy1] <- NA_character_
caprion$Accession.status[amy1] <- "demerged"

# Embed candidate mappings directly; no external CSV required.
caprion$Accession.candidates <- I(
    lapply(seq_len(nrow(caprion)), function(i) {
        if (amy1[i]) c("P0DUB6", "P0DTE7", "P0DTE8")
        else character(0)
    })
)

save(caprion, file = out, version = 3)

# Verify the saved object.
check <- new.env()
load(out, envir = check)
updated <- check$caprion

stopifnot(
    nrow(updated) == 987L,
    length(unique(updated$Protein)) == 987L,
    sum(updated$Accession.status == "demerged") == 1L,
    identical(
        updated$Accession.candidates[[which(amy1)]],
        c("P0DUB6", "P0DTE7", "P0DTE8")
    )
)

cat("Rows:", nrow(updated), "\n")
cat("Status counts:\n")
print(table(updated$Accession.status))
cat("AMY1 candidates:",
    paste(updated$Accession.candidates[[which(amy1)]], collapse = ", "),
    "\n")
cat("Saved:", out, "\n")
