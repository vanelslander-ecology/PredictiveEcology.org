#' `setupModules` wrapper for castor
#'
#' @param modules vector of castor module names
#' @param name passed to [`setupModules()`]
#' @param paths passed to [`setupModules()`]
#' @param overwrite should modules be redownloaded and overwritten?
#'
#' @return a named vector of module folder paths
#' @export
#'
#' @examples
getCastorModules <- function(modules = c("dataCastor", 
                                         "growingStockCastor", 
                                         "blockingCastor", 
                                         "forestryCastor", 
                                         "roadCastor"), 
                             paths = NULL, 
                             overwrite = FALSE) {
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
  return(out)
}