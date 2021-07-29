
#' Update bibliography file
#'
#' This function takes an RMarkdown file location and a bibliography file
#' as inputs and updates the bibliography file.
#'
#' @param path_rmd The path to the RMarkdown file.
#' @param path_bib The path to the bibliography file.
#'
#' @return The location of the bibliography file that has been updated
#' @export
bbt_update_bib <- function(path_rmd, path_bib) {
  bbt_write_bib(
    path = path_bib,
    keys = bbt_detect_citations(path_rmd),
    overwrite = TRUE)
}