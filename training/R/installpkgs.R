## -----------------------
## PRE-RENDER SCRIPT
## -----------------------

## installs packages necessary to render book, and alleviates installation
## steps from qmds (when theya re not part of example code)

# This repo doesn't work for Eliot for some reason
# options(repos = "http://cran.us.r-project.org")  ## set mirror first

if (!"Require" %in% installed.packages()) {
  install.packages("Require")
}

Require::getCRANrepos(ind = 1)
repos <- c("predictiveecology.r-universe.dev", getOption("repos"))
options(repos = repos)

libpath <- "packages/"
dir.create(libpath, showWarnings = FALSE)
.libPaths(libpath)

Require::Install(c("ggplot2",
                   "googledrive",
                   "httr",
                   "kableExtra",
                   "knitr",
                   "rmarkdown"
                   "reproducible",
                   "SpaDES.core",
                   "terra"))
