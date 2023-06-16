library(fs)
library(stringr)
rmd_names <- dir_ls(path = ".", glob = "*.md")
qmd_names <- str_replace(string = rmd_names,
                         pattern = "md",
                         replacement = "qmd")
file_move(path = rmd_names,
          new_path = qmd_names)

# file_move(path = "_bookdown.yml",
#           new_path = "_quarto.yml")


qmdfiles <- list.files(".", pattern = "qmd$", full.names = TRUE)

for (f in qmdfiles) {
  fileLines <- readLines(f)

  headerLinesNos <- grep("^---$", fileLines)
  headerLines <- fileLines[seq(min(headerLinesNos), max(headerLinesNos))]

  keepLines <- grep("^layout:", headerLines, invert = TRUE)
  headerLines <- headerLines[keepLines]

  tagsLine <- grep("^tags:", headerLines)
  headerLines[tagsLine] <- sub("tags:", "categories:", headerLines[tagsLine])

  ## if no comments are activated, explicitly de-activate
  ## otherwise remove if true ("comments: true" errors on build)
  if (!any(grepl("^comments:", headerLines))) {
    commentLine <- "comments: false"
    headerLines <- c(headerLines[1:length(headerLines)-1], commentLine, headerLines[length(headerLines)])
  } else {
    keepLines <- grep("^comments: true", headerLines, invert = TRUE)
    headerLines <- headerLines[keepLines]
  }

  ## re-format title line
  titleLineNo <- grep("^title:", headerLines)
  titleLine <- headerLines[titleLineNo]
  titleLine <- sub("^title: '?", "title: '", titleLine)
  titleLine <- sub("'?$", "'", titleLine)

  headerLines[titleLineNo] <- titleLine

  notHeaderLineNos <- seq(length(headerLines) + 1, length(fileLines))
  notHeaderLines <- fileLines[notHeaderLineNos]
  fileLines2 <- c(headerLines, notHeaderLines)

  writeLines(fileLines2, f)
}
