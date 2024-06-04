## -----------------------
## PRE-RENDER SCRIPT
## -----------------------

## installs packages necessary to render book, and alleviates installation
## steps from qmds (when theya re not part of example code)
if (!"Require" %in% installed.packages()) {
  install.packages("Require")
}

# Require::getCRANrepos(ind = 1)   ## this was screwing this up
repos <- c("predictiveecology.r-universe.dev", getOption("repos"))
options(repos = repos)

Require::Install(c("ggplot2",
                   "googledrive",
                   "httr",
                   "kableExtra",
                   "knitr",
                   "rmarkdown",
                   "reproducible",
                   "SpaDES.core",
                   "terra"))
