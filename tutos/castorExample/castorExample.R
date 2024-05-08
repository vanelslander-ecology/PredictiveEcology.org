## ----------------------------------------------------
## Example of a Castor workflow using SpaDES.project
## ----------------------------------------------------

## adapted from https://github.com/bcgov/castor/blob/main/R/scenarios/comparison_stsm/base_case_harvest_flow_20230628.Rmd

## install/load necessary packages
repos <- c("predictiveecology.r-universe.dev", getOption("repos"))
install.packages(c("remotes", "reproducible", "googledrive"), repos = repos)
remotes::install_github("PredictiveEcology/SpaDES.project@transition")   ## to deal with modules in nested GH folders.
library(SpaDES.project)

## get Castor modules and functions
setupFunctions(paths = list("projectPath" = "~/"),
               functions = c("PredictiveEcology/PredictiveEcology.org@training-book/tutos/castorExample/getCastorModulesAndDB.R",
                             "PredictiveEcology/PredictiveEcology.org@training-book/tutos/castorExample/params.R"),
               overwrite = TRUE)
outMod <- getCastorModulesAndDB(paths = list("modulePath" = "~/tutos/castorExample/modules/",
                                             "projectPath" = "~/tutos/castorExample"),
                                modules = c("dataCastor",
                                            "growingStockCastor",
                                            "forestryCastor",
                                            "blockingCastor"),
                                dbURL = "https://drive.google.com/file/d/1-2POunzC7aFbkKK5LeBJNsFYMBBY8dNx/view?usp=sharing",
                                dbPath = "~/tutos/castorExample/R/scenarios/comparison_stsm")

## set up the workflow paths, dependencies and modules
## as well as simulation parameters, (some) inputs and outputs
out <- setupProject(
  paths = list("inputPath" = "modules/forestryCastor/inputs",
               "outputPath" = "R/scenarios/comparison_stsm/outputs",
               "modulePath" = "modules/",
               "cachePath" = "modules/forestryCastor",
               "projectPath" = "~/tutos/castorExample"),
  modules = names(outMod$modules),
  functions = "bcgov/castor@main/R/functions/R_Postgres.R",
  ## install and load
  require = "dplyr",
  ## install but don't load these:
  packages = c(
    "DBI",
    "DiagrammeR",
    "keyring",
    "rgdal",
    "RPostgreSQL",
    "sp",
    "terra"
  ),
  params = "params.R",
  times = list(start = 0, end = 20),
  outputs = {
    data.frame(objectName = c("harvestReport",
                              "growingStockReport"))
  },
  scenario = {
    data.table(name = "stsm_base_case",
               description = paste("Priority queue = oldest first. Adjacency constraint",
                                   "= None. Includes roads (mst) and blocks (pre).",
                                   "Harvest flow = 147,300 m3/year in decade 1, 133,500",
                                   "m3/year in decade 2, 132,300 m3/year in decades 3 to",
                                   "14 and 135,400 m3/year in decades 15 to 25.",
                                   "Minimum harvest age = 80 and minimum harvest volume = 150"))
  },
  harvestFlow = {
    rbindlist(list(data.table(compartment = "tsa99",
                              partition = ' age > 79 AND vol > 149 ',
                              period = rep( seq (from = 1,
                                                 to = 1,
                                                 by = 1),
                                            1),
                              flow = 1473000,
                              partition_type = 'live'),
                   data.table(compartment = "tsa99",
                              partition = ' age > 79 AND vol > 149 ',
                              period = rep( seq (from = 2,
                                                 to = 2,
                                                 by = 1),
                                            1),
                              flow = 1335000,
                              partition_type = 'live'),
                   data.table(compartment = "tsa99",
                              partition = ' age > 79 AND vol > 149 ',
                              period = rep( seq (from = 3,
                                                 to = 14,
                                                 by = 1),
                                            1),
                              flow = 1323000,
                              partition_type = 'live'),
                   data.table(compartment = "tsa99",
                              partition = ' age > 79 AND vol > 149 ',
                              period = rep( seq (from = 15,
                                                 to = 25,
                                                 by = 1),
                                            1),
                              flow = 1354000,
                              partition_type = 'live')
    ))
  },
  Restart = TRUE
)

## initialize simulation
castorInit <- do.call(SpaDES.core::simInit, out)

## inspect the `simList`
SpaDES.core::params(castorInit)
SpaDES.core::inputs(castorInit)
SpaDES.core::outputs(castorInit)
SpaDES.core::moduleDiagram(castorInit)
SpaDES.core::objectDiagram(castorInit)
SpaDES.core::times(castorInit)

## scheduled events - only init events have been scheduled by simInit
SpaDES.core::events(castorInit)

## run simulation
castorSim <- SpaDES.core::spades(castorInit)

## we now have outputs
SpaDES.core::outputs(castorSim)

## completed events -- or the full (emergent) workflow
SpaDES.core::completed(castorSim)
