## -----------------------
## PRE-RENDER SCRIPT
## -----------------------

## installs packages necessary to render book, and alleviates installation
## steps from qmds (when theya re not part of example code)

# This repo doesn't work for Eliot for some reason
# options(repos = "http://cran.us.r-project.org")  ## set mirror first
# Require::getCRANrepos(ind = 1)
options(repos = "https://cran.r-project.org")
repos <- c("predictiveecology.r-universe.dev", getOption("repos"))
options(repos = repos)

libpath <- if (dir.exists("packages")) "packages/" else "training/packages/"
dir.create(libpath, showWarnings = FALSE)
.libPaths(libpath)

if (!"Require" %in% installed.packages()) {
  install.packages("Require")
}

Require::Install(c("ggplot2", "testthat",
                   "reproducible (HEAD)",
                   "SpaDES.core (HEAD)",
                   "terra"))
