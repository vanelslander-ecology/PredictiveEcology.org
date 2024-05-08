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
  reqdPkgs = list("SpaDES.core (>= 2.0.5)", "ggplot2"),
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
    expectsInput(objectName = NA, objectClass = NA, desc = NA, sourceURL = NA)
  ),
  outputObjects = bindrows(
    #createsOutput("objectName", "objectClass", "output object description", ...),
    createsOutput(objectName = NA, objectClass = NA, desc = NA)
  )
))

## event types
#   - type `init` is required for initialization

doEvent.scheduling = function(sim, eventTime, eventType) {
  switch(
    eventType,
    init = {
      sim <- Init(sim)

      # schedule future event(s)
      sim <- scheduleEvent(sim, end(sim), "scheduling", "plot")
      # sim <- scheduleEvent(sim, P(sim)$.saveInitialTime, "scheduling", "save")

      # here we create a new event type == "predictions" and we schedule it for `start(sim)`
      sim <- scheduleEvent(sim, start(sim), "scheduling", "predictions")
    },
    plot = {
      # ! ----- EDIT BELOW ----- ! #
      # do stuff for this event

      plotFun(sim) # example of a plotting function
      # schedule future event(s)

      # e.g.,
      #sim <- scheduleEvent(sim, time(sim) + P(sim)$.plotInterval, "scheduling", "plot")

      # ! ----- STOP EDITING ----- ! #
    },
    save = {
      # ! ----- EDIT BELOW ----- ! #
      # do stuff for this event

      # e.g., call your custom functions/methods here
      # you can define your own methods below this `doEvent` function

      # schedule future event(s)

      # e.g.,
      # sim <- scheduleEvent(sim, time(sim) + P(sim)$.saveInterval, "scheduling", "save")

      # ! ----- STOP EDITING ----- ! #
    },
    predictions = {
      # do the Prediction
      sim <- Prediction(sim)

      # schedule the next Prediction
      sim <- scheduleEvent(sim, time(sim) + 1, "scheduling", "predictions")
    },
    warning(paste("Undefined event type: \'", current(sim)[1, "eventType", with = FALSE],
                  "\' in module \'", current(sim)[1, "moduleName", with = FALSE], "\'", sep = ""))
  )
  return(invisible(sim))
}

## event functions
#   - keep event functions short and clean, modularize by calling subroutines from section below.

Init <- function(sim) {
  sim$N <- length(sim$y)
  y <- sim$x + rnorm(sim$N)
  # fit a linear model
  x <- sim$x
  sim$out <- lm(y ~ x)
  sim$pred <- list()

  startYear <- start(sim)
  sim$years <- startYear:(startYear + 9)

  return(invisible(sim))
}

plotFun <- function(sim) {
  sim$predictions <- data.frame(year = rep(sim$years, each = sim$N), prediction = unlist(sim$pred))
  # plot the predictions
  sim$gg <- ggplot(sim$predictions, aes(x = year, y = prediction, colour = year)) +
    geom_point() + geom_smooth()
  print(sim$gg)
  return(invisible(sim))
}

.inputObjects <- function(sim) {
  if (!SpaDES.core::suppliedElsewhere("x", sim))
    sim$x <- rnorm(10)
  return(invisible(sim))
}

Prediction <- function(sim) {

  year <- time(sim) - start(sim) + 1 # rescale to 1:10 instaed of 2024:2033 -- for simplicity here
  sim$pred[[year]] <- predict(sim$out, newdata = data.frame(y = rnorm(sim$N) + year))

  return(invisible(sim))
}


### template for save events
Save <- function(sim) {
  # ! ----- EDIT BELOW ----- ! #
  # do stuff for this event
  sim <- saveFiles(sim)

  # ! ----- STOP EDITING ----- ! #
  return(invisible(sim))
}

### template for your event1
