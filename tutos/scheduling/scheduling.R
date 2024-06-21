## Everything in this file and any files in the R directory are sourced during `simInit()`;
## all functions and objects are put into the `simList`.
## To use objects, use `sim$xxx` (they are globally available to all modules).
## Functions can be used inside any function that was sourced in this module;
## they are namespaced to the module, just like functions in R packages.
## If exact location is required, functions will be: `sim$.mods$<moduleName>$FunctionName`.
defineModule(sim, list(
  name = "scheduling",
  description = "",
  keywords = "",
  authors = structure(list(list(given = c("First", "Middle"), family = "Last", role = c("aut", "cre"), email = "email@example.com", comment = NULL)), class = "person"),
  childModules = character(0),
  version = list(scheduling = "0.0.0.9000"),
  timeframe = as.POSIXlt(c(NA, NA)),
  timeunit = "year",
  citation = list("citation.bib"),
  documentation = list("NEWS.md", "README.md", "scheduling.Rmd"),
  reqdPkgs = list("SpaDES.core (>= 2.1.5.9000)", "ggplot2"),
  parameters = bindrows(
    #defineParameter("paramName", "paramClass", value, min, max, "parameter description"),
    defineParameter(".plots", "character", "screen", NA, NA,
                    "Used by Plots function, which can be optionally used here"),
    defineParameter(".plotInitialTime", "numeric", start(sim), NA, NA,
                    "Describes the simulation time at which the first plot event should occur."),
    defineParameter(".plotInterval", "numeric", NA, NA, NA,
                    "Describes the simulation time interval between plot events."),
    defineParameter(".saveInitialTime", "numeric", NA, NA, NA,
                    "Describes the simulation time at which the first save event should occur."),
    defineParameter(".saveInterval", "numeric", NA, NA, NA,
                    "This describes the simulation time interval between save events."),
    defineParameter(".studyAreaName", "character", NA, NA, NA,
                    "Human-readable name for the study area used - e.g., a hash of the study",
                          "area obtained using `reproducible::studyAreaName()`"),
    ## .seed is optional: `list('init' = 123)` will `set.seed(123)` for the `init` event only.
    defineParameter(".seed", "list", list(), NA, NA,
                    "Named list of seeds to use for each event (names)."),
    defineParameter(".useCache", "logical", FALSE, NA, NA,
                    "Should caching of events or module be used?")
  ),
  inputObjects = bindrows(
    #expectsInput("objectName", "objectClass", "input object description", sourceURL, ...),
    expectsInput(objectName = "x", objectClass = NA, desc = NA, sourceURL = NA)
  ),
  outputObjects = bindrows(
    createsOutput(objectName = "predictions", objectClass = "data.frame",
                  desc = "Table of predictions and years"),
    createsOutput(objectName = "out", objectClass = NA, desc = NA),
    createsOutput(objectName = "pred", objectClass = NA, desc = NA),
    createsOutput(objectName = "gg", objectClass = NA, desc = NA),
    createsOutput(objectName = "years", objectClass = NA, desc = NA)
  )
))

doEvent.scheduling = function(sim, eventTime, eventType) {
  switch(
    eventType,
    init = {
      sim <- Init(sim)

      # schedule future event(s)
      sim <- scheduleEvent(sim, end(sim), "scheduling", "plot")

      # here we create a new event type == "predictions" and we schedule it for `start(sim)`
      sim <- scheduleEvent(sim, start(sim), "scheduling", "predictions")
    },
    predictions = {
      # do the Prediction
      sim <- Prediction(sim)

      # schedule the next Prediction
      sim <- scheduleEvent(sim, time(sim) + 1, "scheduling", "predictions")
    },
    plot = {
      # do the plot
      sim <- plotFun(sim)
    },
    warning(noEventWarning(sim))
  )
  return(invisible(sim))
}

Init <- function(sim) {
  y <- sim$x + rnorm(10)
  # fit a linear model
  sim$out <- lm(y ~ sim$x)
  sim$pred <- list()

  return(invisible(sim))
}

Prediction <- function(sim) {
  startYear <- 2023
  sim$years <- startYear:(startYear + 10) + 1
  for (year in sim$years - startYear) {
    sim$pred[[year]] <- predict(sim$out, newdata = data.frame(y = rnorm(10) + year))
  }
  return(invisible(sim))
}

plotFun <- function(sim) {
  sim$predictions <- data.frame(year = rep(sim$years, each = 10), prediction = unlist(sim$pred))
  # plot the predictions
  sim$gg <- ggplot(sim$predictions, aes(x = year, y = prediction, colour = year)) + geom_point() + geom_smooth()
  print(sim$gg)

  return(invisible(sim))
}

.inputObjects <- function(sim) {
  sim$x <- rnorm(10)

  return(invisible(sim))
}
