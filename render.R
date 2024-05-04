## render book
quarto::quarto_render("training/", as_job = FALSE)

quarto::quarto_render(as_job = FALSE)

bookFiles <- list.files("training/_book/", recursive = TRUE, full.names = TRUE)
bookFilesCopy <- sub("training/_book", "docs/training/_book", bookFiles)
bookFilesDirs <- dirname(bookFilesCopy)

sapply(bookFilesDirs, dir.create, recursive = TRUE, showWarnings = FALSE)

file.copy(bookFiles, bookFilesCopy, overwrite = TRUE)
