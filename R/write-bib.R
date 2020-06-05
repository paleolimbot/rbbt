
#' Write a bibliography file from Zotero citation keys
#'
#' @description
#' Write a bibliography file to disk from a set of citation keys.
#' To automatically
#' generate a bibliography file from the items cited in your document when you
#' Knit, place a line like this one in your RMarkdown YAML header:
#'
#' ``bibliography: "`r rbbt::bbt_write_bib("bibliography.json", overwrite = TRUE)`"``
#'
#' @inheritParams bbt_bib_selected
#' @inheritParams bbt_guess_translator
#' @param ignore A character vector of keys to disregard (useful if
#'   [bbt_detect_citations()] gives spurious output).
#' @param overwrite Use `TRUE` to overwrite an existing file at `path`
#'
#' @inheritSection bbt_cite_cayw Note
#'
#' @return The value of `path` (so that this function
#'   can be used in the 'bibliography' RMarkdown YAML field)
#' @export
#'
#' @examples
#' \dontrun{
#' bbt_write_bib("bibliography.json") # For CSL-JSON output (recommended)
#' bbt_write_bib("bibliography.bib")  # For BibLaTeX output
#' }
#'
bbt_write_bib <- function(path,
                          keys = bbt_detect_citations(),
                          ignore = character(),
                          translator = bbt_guess_translator(path),
                          library_id = getOption("rbbt.default.library_id", 1),
                          overwrite = FALSE) {
  if (file.exists(path) && !overwrite) {
    stop("Use `overwrite = TRUE` to overwrite file at '", path, "'", call. = FALSE)
  }
  force(keys)

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
#' @note The default format for `.bib` files can be changed. For example:
#'   `getOption("rbbt.default.bib", "biblatex")`
#'
#' @examples
#' bbt_guess_translator("bibliography.json")
#' bbt_guess_translator("bibliography.bib")
#'
bbt_guess_translator <- function(path, .bib = getOption("rbbt.default.bib", "biblatex")) {
  if (grepl("\\.json$", path, ignore.case = TRUE)) {
    "csljson"
  } else if (grepl("\\.bib$", path, ignore.case = TRUE)) {
    .bib <- match.arg(.bib, choices = c("biblatex", "bibtex"))
    .bib
  } else if (grepl("\\.yaml$", path, ignore.case = TRUE)) {
    "cslyaml"
  } else {
    warning(
      "Expected translator could not be determined. `path` must end in '.json', '.bib', or '.yaml'.",
      call. = FALSE
    )
    getOption("rbbt.default.translator", "biblatex")
  }
}

#' @rdname bbt_guess_translator
#' @export
bbt_guess_format <- function(path) {
  if (grepl("tex$", path, ignore.case = TRUE)) {
    "cite"
  } else {
    "pandoc"
  }
}
