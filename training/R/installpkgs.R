## -----------------------
## PRE-RENDER SCRIPT
## -----------------------

## installs packages necessary to render book, and alleviates installation
## steps from qmds (when theya re not part of example code)
repos <- c("predictiveecology.r-universe.dev", getOption("repos"))
if (tryCatch(packageVersion("SpaDES.project") < "0.1.1", error = function(x) TRUE))
  install.packages(c("Require", "SpaDES.project"), repos = repos)

# install.packages(c("remotes"), repos = repos)
# remotes::install_github("PredictiveEcology/SpaDES.project@development")

library(SpaDES.project)
PRINT("SDFSDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF")
currDir <- getwd()
tempDir <- tempdir()
print("Running installpkgs.R")
out <- setupProject(
  options = list("repos" = unique(repos)),
  paths = list(projectPath = tempDir,
               packagePath = file.path("packages", Require:::versionMajorMinor())),
  packages = "PredictiveEcology/PredictiveEcology.org@main/training/R/pkgList.R",
  modules = "PredictiveEcology/Biomass_core@main",
  # Restart = TRUE,
  setLinuxBinaryRepo = FALSE
)

setwd(currDir)
