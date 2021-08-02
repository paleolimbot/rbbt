
#' Update bibliography file
#'
#' This function takes an RMarkdown file location and a bibliography file
#' as inputs and updates the bibliography file.
#'
#' @param path_rmd The path to the RMarkdown file.
#' @param path_bib The path to the bibliography file.
#' @param encoding Passed to [rmarkdown::yaml_front_matter()]
#' @param quiet Use `TRUE` to suppress message on successful write.
#' @inheritParams bbt_write_bib
#'
#' @return `path_bib`, invisibly
#' @export
bbt_update_bib <- function(path_rmd,
                           path_bib = bbt_guess_bib_file(path_rmd),
                           translator = bbt_guess_translator(path_bib),
                           library_id = getOption("rbbt.default.library_id", 1),
                           overwrite = TRUE, filter = identity, quiet = FALSE) {
  keys <- bbt_detect_citations(path_rmd)
  bbt_write_bib(
    path = path_bib,
    keys = keys,
    translator = translator,
    overwrite = overwrite,
    filter = filter
  )

  if (!quiet) {
    references <- if (length(keys) != 1) "references" else "reference"
    message(sprintf("Wrote %d %s to '%s'", length(keys), references, path_bib))
  }

  invisible(path_bib)
}

#' @rdname bbt_update_bib
#' @export
bbt_guess_bib_file <- function(path_rmd, encoding = "UTF-8") {
  front_matter <- rmarkdown::yaml_front_matter(path_rmd, encoding = encoding)
  if (length(front_matter$bibliography) != 1) {
    stop(
      sprintf("Can't guess bibliography file from '%s' front matter", path_rmd),
      call. = FALSE
    )
  }

  bib_file <- front_matter$bibliography
  if (!fs::is_absolute_path(bib_file)) {
    file.path(dirname(path_rmd), bib_file)
  } else {
    bib_file
  }
}
