## ------------------------------------------------------
## List of packages to pre-install for book
## ------------------------------------------------------

pkgList <- Require::pkgSnapshot2(libPaths = c("training/packages/", "training/packages/4.3/",
                                              .libPaths(),
                                              SpaDES.project:::.libPathDefault("castorExample"),
                                              SpaDES.project:::.libPathDefault("integratingSpaDESmodules")))
pkgList <- c(pkgList, "disk.frame")

cat(paste0("Require::Install(\n",
           "c('",
           paste(pkgList, collapse = "', \n'"),
           "')",
           ")"),
    file = "R/pkgList.R")
