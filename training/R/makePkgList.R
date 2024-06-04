## ------------------------------------------------------
## List of packages to pre-install for book
## ------------------------------------------------------

## run manually, add libs as need
pkgList <- Require::pkgSnapshot2(libPaths = c("training/packages/", "training/packages/4.3/",
                                              .libPaths(),
                                              SpaDES.project:::.libPathDefault("castorExample"),
                                              SpaDES.project:::.libPathDefault("integratingSpaDESmodules")))
pkgList <- c(pkgList, "disk.frame")

write.csv(pkgList, "training/R/pkgList.csv")

