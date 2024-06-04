libpath <- file.path("packages", paste0(version$major, ".", sub("\\..*", "", version$minor)))
dir.create(libpath, showWarnings = FALSE)
.libPaths(libpath)

options(repos = list(CRAN = "http://cran.r-project.org"))  ## set mirror first
