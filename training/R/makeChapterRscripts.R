## ------------------------------------------------------
## Barebones R scripts from Chapter qmds
## ------------------------------------------------------

## Note: to prevent a chunk from appearing in the Rscript (e.g. setup chunks)
## add
## #| purl: false to chunk knitr options

currwd <- getwd()

chapterQMDs <- list.files(pattern = ".qmd")

## take a few out
excludedQMDs <- c("index.qmd", "intro.qmd", "bestPractices.qmd", "bestPractices.qmd",
                  "settingUp.qmd", "TroubleshootingPackageInstallation.qmd", "references.qmd",
                  "installRandSpatialPkgs.qmd", "SpaDESbasics.qmd", "ContinuousWorkflows.qmd",
                  "PackagesForBook.qmd", "setupProject.qmd")
grepStr <- paste(paste0("^", excludedQMDs), collapse = "|")

chapterQMDs <- list.files(pattern = ".qmd") |>
  grep(grepStr, x = _,invert = TRUE, value = TRUE)

chapterQMDs <- file.path(currwd, chapterQMDs)

## as per `?knitr::purl` setwd to Rscript output dir
setwd("R/Chapter_scripts")

sapply(chapterQMDs, knitr::purl, documentation = 0)

## reset
setwd(currwd)




