# Build script

# Docs
cat("Updating documentation...\n")
devtools::document()

# Version increment
cat("Incrementing version number...\n")
# Find version number
desc <- readLines("DESCRIPTION")
versL <- grepl("Version: ", desc)
versNum <- strsplit(desc[versL], "\\s")[[1]][2]
versNumPieces <- strsplit(versNum, "\\.")[[1]]
versNumPiecesNums <- as.numeric(versNumPieces)
cat("Old version number:", versNumPieces, "\n")
# Increment version number
versNumPiecesNums[length(versNumPiecesNums)] <- versNumPiecesNums[length(versNumPiecesNums)] + 1
versNum <- paste(versNumPiecesNums, collapse=".")
desc[versL] <- paste("Version:", versNum)
cat("New version number:", versNum, "\n")
writeLines(desc, "DESCRIPTION")

# R CMD check
cat("Running R CMD check...\n")
devtools::check()

cat("Building source...\n")
# Build
devtools::build()