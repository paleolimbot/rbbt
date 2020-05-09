#' Write a Zotero bibliography file from citation keys
#'
#' @description Write a bibliography file to disk from a set of citation keys.
#' To automatically
#' generate a bibliography file from the items cited in your document when you
#' Knit, place a line like this one in your RMarkdown YAML header:
#'
#' ``bibliography: "`r rbbt::bbt_write_bib("bibliography.json", overwrite = TRUE)`"``
#'
#' @inheritParams bbt_bib_selected
#' @param path Filepath where the bibliography should be written
#' @param ignore A character vector of keys to disregard (useful if
#'   [bbt_detect_citations()] gives spurious output).
#' @param translator Type of bibliography file to create. Options are `csljson`
#'   (CSL-JSON), `biblatex` (BibLaTeX), `bibtex` (BibTeX), and `cslyaml`
#'   (CSL YAML). CSL-JSON is recommended for most users (see Notes). If
#'   `"guess"`, the translator will be guessed from the file extension of `path`.
#' @param overwrite Use `TRUE` to overwrite an existing file at `path`
#'
#' @inheritSection bbt_ref_cayw Note
#'
#' @return The value of `path` (so that this function can be used in the 'bibliography' RMarkdown YAML field)
#' @export
#'
#' @examples
#' \dontrun{
#' bbt_write_bib("bibliography.json") # For CSL-JSON output (recommended)
#' bbt_write_bib("bibliography.bib")  # For BibLaTeX output
#' }
bbt_write_bib <- function(path = NULL,
                          keys = bbt_detect_citations(),
                          ignore = character(),
                          translator = c("guess", "csljson", "biblatex", "bibtex", "cslyaml"),
                          overwrite = FALSE) {
  if (is.null(path)) {
    stop("`path` must be specified for the bibliography file.", call. = FALSE)
  }
  if (file.exists(path) && !overwrite) {
    stop("Use `overwrite = TRUE` to overwrite file at '", path, "'", call. = FALSE)
  }
  force(keys)
  translator <- match.arg(translator)
  if (translator == "guess") {
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
#' @param path The output path for the bibliography file. Must end with `.json`, `.bib`, or `.yaml`.
#' @param .bib Should `.bib` files be returned in `"biblatex"` (default) or `"bibtex"` format?
#'
#' @return Character vector of length 1 with the guessed translator format.
#' @export
#'
#' @note The default format for `.bib` can be changed. For example:
#'   `getOption("rbbt.default.bib", "biblatex")`
#'
#' @examples
#' bbt_guess_translator("bibliography.json")
bbt_guess_translator <- function(path, .bib = getOption("rbbt.default.translator", "biblatex")) {
  if (!grepl("\\.json$", path, ignore.case = TRUE)) {
    return("csljson")
  } else if (!grepl("\\.bib$", path, ignore.case = TRUE)) {
    .bib <- match.arg(.bib, choices = c("biblatex", "bibtex"))
    return(.bib)
  } else if (!grepl("\\.bib$", path, ignore.case = TRUE)) {
    return("cslyaml")
  } else {
    stop("Expected translator could not be determined. `path` must end in '.json', '.bib', or '.yaml'.")
  }
}
