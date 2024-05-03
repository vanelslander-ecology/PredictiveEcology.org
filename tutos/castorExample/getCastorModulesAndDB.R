#' `setupModules` wrapper for castor
#'
#' @param modules vector of castor module names
#' @param name passed to [`setupModules()`]
#' @param paths passed to [`setupModules()`]
#' @param overwrite should modules be redownloaded and overwritten?
#' @param dbURL optional. A URL to a SQLite database to be used locally
#' @param dbPath optional. A folder path to place the downloaded SQLite database.
#'   Defaults to `./`.
#'
#' @return a named list of module folder paths and, if dbURL is provided,
#'   the SQLite database file path
#' @export
#'
#' @importsFrom reproducible prepInputs
getCastorModulesAndDB <- function(modules = c("dataCastor",
                                              "growingStockCastor",
                                              "blockingCastor",
                                              "forestryCastor",
                                              "roadCastor"),
                                  paths = NULL,
                                  overwrite = FALSE,
                                  dbURL, dbPath) {
  if (is.null(paths)) {
    stop("Provide 'paths'")
  }
  
  finalModPaths <- normalizePath(file.path(paths$modulePath, modules, paste0(modules, ".R")), winslash = "/",
                                 mustWork = FALSE)
  if (any(!file.exists(finalModPaths)) | overwrite) {
    message("Could not find all modules locally. Downloading from GitHub")
    out <- setupModules(modules = c("bcgov/castor@main/R/SpaDES-modules"),
                        paths = paths)
  } else {
    message("All module .R scripts were found locally.",
            "\n  If other module files are missing, set overwrite = TRUE")
  }
  
  modFiles <- normalizePath(list.files(file.path(paths$modulePath, "castor/R/SpaDES-modules", modules),
                                       recursive = TRUE, full.names = TRUE), winslash = "/", mustWork = FALSE)
  modFilesNew <- sub(normalizePath(file.path(paths$modulePath, "castor/R/SpaDES-modules"), winslash = "/", mustWork = FALSE),
                     normalizePath(paths$modulePath, winslash = "/", mustWork = FALSE),
                     modFiles, fixed =TRUE)
  
  invisible(lapply(unique(dirname(modFilesNew)), dir.create, recursive = TRUE, showWarnings = FALSE))
  invisible(reproducible::linkOrCopy(modFiles, modFilesNew, overwrite = overwrite))
  unlink(file.path(paths$modulePath, "castor"), recursive = TRUE)  ## delete unnecessary repo content
  
  out <- finalModPaths
  names(out) <- modules
  
  ## get db if
  if (!missing(dbURL)) {
    if (!requireNamespace("reproducible")) {
      stop("Install 'reproducible' package to download a SQLite database")
    }
    
    if (missing(dbPath)) {
      dbPath <- normalizePath(getwd(), winslash = "/")
    }
    
    repOut <- reproducible::prepInputs(url = dbURL,
                                       destinationPath = dbPath,
                                       fun = NA)
  }
  
  return(list(modules = out, dbFilePath = repOut$targetFilePath))
}
