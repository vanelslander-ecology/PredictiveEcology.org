## -----------------------
## PRE-RENDER SCRIPT
## -----------------------

## installs packages necessary to render book, and alleviates installation
## steps from qmds (when theya re not part of example code)
repos <- c("predictiveecology.r-universe.dev", getOption("repos"))
# install.packages(c("SpaDES.project"), repos = repos)
remotes::install_github("PredictiveEcology/SpaDES.project@development")

library(SpaDES.project)

currDir <- getwd()
tempDir <- tempdir()
out <- setupProject(
  options = list("repos" = repos),
  paths = list(projectPath = tempDir,
               packagePath = file.path(currDir, "packages/")),
  packages = "PredictiveEcology/PredictiveEcology.org@training-book/training/R/pkgList.R",
  modules = "PredictiveEcology/Biomass_core@main"
)

setwd(currDir)
