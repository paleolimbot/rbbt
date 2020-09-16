
#' Detect pandoc-style citations
#'
#' @param path A character vector, file or URL whose contents may contain citation keys.
#' @param locale See [readr::default_locale()]. Use if encoding might
#'   be a problem.
#'
#' @return A character vector of unique citation keys.
#' @export
#'
#' @examples
#' bbt_detect_citations("\n@citation1 and [@citation2] but not \\@citation3")
#'
bbt_detect_citations <- function(path = bbt_guess_citation_context(), locale = readr::default_locale()) {
  bbt_detect_citations_chr(readr::read_file(path, locale = locale))
}

#' @rdname bbt_detect_citations
#' @export
bbt_guess_citation_context <- function() {
  knitr_doc <- knitr::current_input()
  if (!is.null(knitr_doc)) {
    knitr_doc
  } else {
    stop("Can't detect context (tried current knitr doc)", call. = FALSE)
  }
}

bbt_detect_citations_chr <- function(content) {
  content <- paste0(content, collapse = "\n")
  refs <- stringr::str_match_all(
    content,
    stringr::regex("[^a-zA-Z0-9\\\\]@([a-zA-Z0-9_.-]+[a-zA-Z0-9])", multiline = TRUE, dotall = TRUE)
  )[[1]][, 2, drop =  TRUE]

  unique(refs)
}
