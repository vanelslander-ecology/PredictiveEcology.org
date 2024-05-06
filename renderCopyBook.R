## render book
quarto::quarto_render("training/", as_job = FALSE)

## render website -- keep commented out for GHActions
quarto::quarto_render(as_job = FALSE)

## now copy book HTMLs to docs/ (always *after* rendering site)
bookFiles <- list.files("training/_book/", recursive = TRUE, full.names = TRUE)
bookFilesCopy <- sub("training/_book", "docs/training/_book", bookFiles)
bookFilesDirs <- dirname(bookFilesCopy)

sapply(bookFilesDirs, dir.create, recursive = TRUE, showWarnings = FALSE)

file.copy(bookFiles, bookFilesCopy, overwrite = TRUE)
