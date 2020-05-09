
#' Write a bibliography file from citation keys
#'
#' @inheritParams bbt_bib_selected
#' @param path A path where the bibliography should be written
#' @param ignore A character vector of keys to disregard (useful if
#'   [bbt_detect_citations()] gives spurious output).
#' @param overwrite Use `TRUE` to overwrite an existing file at `path`
#' @param translator Type of bibliography file to create. Options are CSL-JSON (default), BibLaTex, BibTeX, and CSL YAML. If you are using RMarkdown/CSL styles to format citations, CSL-JSON is recommended because it will produce the most accurate citations. If you are using natbib or biber to format citations, BibLaTex is recommended.
#'
#' @return `path` (so that this can be used in the 'biblio' RMarkdown YAML field)
#' @export
#'
bbt_write_bib <- function(path,
                          keys = bbt_detect_citations(),
                          ignore = character(),
                          translator = c("csljson", "biblatex", "bibtex", "cslyaml"),
                          overwrite = FALSE) {
  if (file.exists(path) && !overwrite) {
    stop("Use `overwrite = TRUE` to overwrite file at '", path, "'", call. = FALSE)
  }
  force(keys)
  translator <- match.arg(translator)

  assert_bbt()
  readr::write_file(
    bbt_bib(setdiff(keys, ignore), translator, .action = bbt_return),
    path
  )

  path
}
