
#' Write a bibliography file from citation keys
#'
#' @inheritParams bbt_bib_selected
#' @param path A path where the bibliography should be written
#' @param ignore A character vector of keys to disregard (useful if
#'   [bbt_detect_citations()] gives spurious output).
#' @param overwrite Use `TRUE` to overwrite an existing file at `path`
#'
#' @return `path` (so that this can be used in the 'biblio' RMarkdown YAML field)
#' @export
#'
bbt_write_bib <- function(path = "bibliography.json",
                          keys = bbt_detect_citations(),
                          ignore = character(),
                          translator = c("guess", "csljson", "biblatex", "bibtex", "cslyaml"),
                          overwrite = FALSE) {
  if (file.exists(path) && !overwrite) {
    stop("Use `overwrite = TRUE` to overwrite file at '", path, "'", call. = FALSE)
  }
  force(keys)
  translator <- match.arg(translator)
  if (tranlator == "guess") {
    translator <- bbt_guess_translator(path)
  }

  assert_bbt()
  readr::write_file(
    bbt_bib(setdiff(keys, ignore), translator, .action = bbt_return),
    path
  )

  path
}

#' Guess the BetterBibTeX translator format from the file extension
#'
#' This function guesses the expected bibliography format
#'
#' @param path The output path for the bibliography file. Must end with `.json`, `.bib`, or `.yaml`.
#' @param .bib Should `.bib` files be returned in `biblatex` (default) or `bibtex` format?
#'
#' @return
#' @export
#'
#' @examples
#' bbt_guess_translator("bibliography.json")
bbt_guess_translator <- function(path, .bib = c("biblatex", "bibtex")) {
  if (!grepl("\\.json$", path, ignore.case = TRUE)) {
    return("csljson")
  } else if (!grepl("\\.bib$", path, ignore.case = TRUE)) {
    .bib <- match.arg(.bib)
    return(.bib)
  } else if (!grepl("\\.bib$", path, ignore.case = TRUE)) {
    return("cslyaml")
  } else {
    stop("Expected translator could not be determined. `path` must end in '.json', '.bib', or '.yaml'.")
  }
}
