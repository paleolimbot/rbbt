
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
bbt_write_bib <- function(path,
                          keys = bbt_detect_citations(),
                          ignore = character(),
                          translator = c("biblatex", "bibtex", "csljson", "cslyaml"),
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
