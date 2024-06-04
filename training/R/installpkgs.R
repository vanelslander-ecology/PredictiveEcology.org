## -----------------------
## PRE-RENDER SCRIPT
## -----------------------

## installs packages necessary to render book, and alleviates installation
## steps from qmds (when theya re not part of example code)

repos <- c("predictiveecology.r-universe.dev", getOption("repos"))
if (!"SpaDES.project" %in% installed.packages()) {
  install.packages("SpaDES.project", repos = repos)
}
library(SpaDES.project)
out <- setupProject(
  sideEffects = "PredictiveEcology/PredictiveEcology.org@14-fix-webpage-build/training/R/pkgList.R",
  options = list(repos = repos),
  name = "Introduction",
  modules = "PredictiveEcology/Biomass_core@main"
)

