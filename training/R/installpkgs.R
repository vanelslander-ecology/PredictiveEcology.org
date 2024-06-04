## -----------------------
## PRE-RENDER SCRIPT
## -----------------------

## installs packages necessary to render book, and alleviates installation
## steps from qmds (when theya re not part of example code)
if (!"Require" %in% installed.packages()) {
  install.packages("Require")
}

out <- setupProject(
  pkgList = "https://raw.githubusercontent.com/PredictiveEcology/PredictiveEcology.org/14-fix-webpage-build/training/R/pkgList.R"
  packages = c("ggplot2",
                 "googledrive",
                 "httr",
                 "kableExtra",
                 "knitr",
                 "rmarkdown",
                 "reproducible (HEAD)",
                 "SpaDES.core (HEAD)",
                 "testthat",
                 "terra",
    pkgList)
  options = list(repos = repos),
  name = "Introduction",
  modules = "PredictiveEcology/Biomass_core@main"
)

