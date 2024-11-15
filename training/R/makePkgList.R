## ------------------------------------------------------
## List of packages to pre-install for book
## ------------------------------------------------------

pkgList <- Require::pkgSnapshot2(libPaths = c("training/packages/", file.path("training/packages", Require:::versionMajorMinor()),
                                              .libPaths(),
                                              SpaDES.project:::.libPathDefault("castorExample"),
                                              SpaDES.project:::.libPathDefault("integratingSpaDESmodules")))
pkgList <- c(pkgList, "disk.frame")

pkgList2 <- Require::extractPkgName(pkgList)
keepersFromGH <- grep("climr|LandR.CS", pkgList2)
pkgList2[keepersFromGH] <- pkgList[keepersFromGH]
pkgList <- pkgList2
cat(paste0("c('",
           paste(pkgList, collapse = "', \n'"),
           "')"),
    file = "R/pkgList.R")
