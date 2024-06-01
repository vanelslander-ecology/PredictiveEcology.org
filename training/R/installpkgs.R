## -----------------------
## PRE-RENDER SCRIPT
## -----------------------

## installs packages necessary to render book, and alleviates installation
## steps from qmds (when theya re not part of example code)

options(repos = "http://cran.us.r-project.org")  ## set mirror first
repos <- c("predictiveecology.r-universe.dev", getOption("repos"))
options(repos = repos)

libpath <- "packages/"
dir.create(libpath, showWarnings = FALSE)
.libPaths(libpath)

if (!"Require" %in% installed.packages()) {
  install.packages("Require")
}

Require::Require(c("ggplot2",
                   "reproducible",
                   "SpaDES.core",
                   "terra"), require = FALSE)
