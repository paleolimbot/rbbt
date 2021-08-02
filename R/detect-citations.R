
#' Detect pandoc-style citations
#'
#' By default, this omits any references within code chunks, inline R code,
#' or URLs. To force the inclusion of a reference in the output, include it
#' in an HTML comment or the
#' [nocite front matter field](https://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html#Unused_References_(nocite)).
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
  text <- readr::read_file(path, locale = locale)
  bbt_detect_citations_chr(text)
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

bbt_detect_citations_chr <- function(text) {
  text <- paste0(text, collapse = "\n")

  # regexes inspired from here:
  # https://github.com/benmarwick/wordcountaddin/blob/master/R/hello.R#L163-L199

  # don't include text in code chunks
  text <- gsub("\n```\\{.+?\\}.+?\n```", "", text)

  # don't include text in in-line R code
  text <- gsub("`r.+?`", "", text)

  # don't include inline markdown URLs
  text <- gsub("\\(http.+?\\)", "", text)
  text <- gsub("<http.+?>", "", text)

  refs <- stringr::str_match_all(
    text,
    stringr::regex("[^a-zA-Z0-9\\\\]@([a-zA-Z0-9_.-]+[a-zA-Z0-9])", multiline = TRUE, dotall = TRUE)
  )[[1]][, 2, drop = TRUE]

  unique(refs)
}
