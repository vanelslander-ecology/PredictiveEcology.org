## -----------------------
## PRE-RENDER SCRIPT
## -----------------------

## installs packages necessary to render book, and alleviates installation
## steps from qmds (when theya re not part of example code)
if (!"Require" %in% installed.packages()) {
  install.packages("Require")
}

Require::Install(c("ggplot2",
                   "googledrive",
                   "httr",
                   "kableExtra",
                   "knitr",
                   "rmarkdown",
                   "reproducible (HEAD)",
                   "SpaDES.core (HEAD)",
                   "testthat",
                   "terra"))
