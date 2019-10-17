
#' Interactively insert references from Zotero
#'
#' Using BetterBibTex's cite-as-you-write tool (
#' \url{https://retorque.re/zotero-better-bibtex/cayw/}). Citation text
#' is printed to the console by default (use the addin to insert directly
#' into the editor!). Use \code{bbt_bib_zotero} to use the current
#' selection in Zotero to generate a bibliography.
#'
#' @param format The citation format to use (in-text citations)
#' @param translator The translator to use (bibliography files)
#' @param .action Use \link{bbt_return} to return the value without printing.
#' @param ... Pass anything to the cite-as-you-write endpoint (see link above)
#'
#' @return A character vector of length 1, the result of \code{.action}.
#' @export
#'
#' @examples
#' if(interactive()) bbt_cite()
#' if(interactive()) bbt_bib()
#' if(interactive()) bbt_cayw(format = "mmd")
#' if(interactive()) bbt_bib_zotero()
#'
bbt_cite <- function(format = c("pandoc", "latex", "cite"), .action = bbt_print) {
  format <- match.arg(format)
  bbt_cayw(format = format, .action = .action)
}

#' @rdname bbt_cite
#' @export
bbt_bib <- function(translator = c("biblatex", "bibtex", "csljson", "cslyaml"), .action = bbt_print) {
  translator <- match.arg(translator)
  bbt_cayw(format = "translate", translator = translator, .action = .action)
}

#' @rdname bbt_cite
#' @export
bbt_cayw <- function(..., .action = bbt_print) {
  .action(bbt_call("cayw", ...))
}

#' @rdname bbt_cite
#' @export
bbt_bib_zotero <- function(translator = c("biblatex", "bibtex", "csljson", "cslyaml"), .action = bbt_print) {
  translator <- match.arg(translator)
  .action(bbt_call(.endpoint = "select", translator))
}

bbt_cite_addin <- function() {
  # get the likely citation type from the current document context
  context <- rstudioapi::getActiveDocumentContext()
  if(is.character(context$path) && (grepl("tex$", context$path[1]))) {
    bbt_cite("cite", .action = bbt_insert)
  } else {
    bbt_cite("pandoc", .action = bbt_insert)
  }
}

bbt_bib_zotero_addin <- function() {
  bbt_bib_zotero(translator = "biblatex", .action = bbt_insert)
}

#' Do something with a value from the API
#'
#' Note that insert uses the RStudio API, but will print values if the API is unavailable.
#'
#' @param text A character vector as lines
#'
#' @return the input
#' @export
#'
bbt_insert <- function(text) {
  text <- paste(text, collapse = "\n")
  if(rstudioapi::isAvailable()) {
    rstudioapi::insertText(text = text)
  } else {
    cat(text)
  }
  invisible(text)
}

#' @rdname bbt_insert
#' @export
bbt_print <- function(text) {
  text <- paste(text, collapse = "\n")
  cat(text)
  invisible(text)
}

#' @rdname bbt_insert
#' @export
bbt_return <- function(text) {
  text <- paste(text, collapse = "\n")
  text
}

#' @rdname bbt_insert
#' @export
bbt_copy <- function(text) {
  text <- paste(text, collapse = "\n")
  message("Text copied to clipboard")
  clipr::write_clip(text)
  invisible(text)
}

# TODO implement this:
# https://github.com/retorquere/zotero-better-bibtex/blob/master/content/json-rpc.ts
# the /better-bibtex/json-rpc endpoint

bbt_url <- function(.endpoint, ...) {
  .endpoint <- paste0("http://127.0.0.1:23119/better-bibtex/", .endpoint)
  args <- c(...)
  if(is.null(names(args))) {
    url <- paste0(
      .endpoint, "?", paste0(
        vapply(args, utils::URLencode, reserved=TRUE, FUN.VALUE = character(1)),
        collapse = "&"
      )
    )
  } else {
    stopifnot(all(names(args) != ""))
    url <- httr::parse_url(.endpoint)
    url$query <- as.list(args)
    url <- httr::build_url(url)
  }

  url
}

bbt_call <- function(.endpoint, ...) {
  ping <- bbt_call_http(.endpoint = "cayw", probe = TRUE)
  if(inherits(ping, "try-error") && !(ping == "ready")) {
    message("Can't connect to Better BibTex for Zotero!")
    bbt_call_test(.endpoint, ...)
  } else {
    bbt_call_http(.endpoint, ...)
  }
}

bbt_call_test <- function(.endpoint, ...) {
  # TODO: invoke some sort of dictionary mapping test URLs to responses based on
  # real responses from my Zotero
  # bbt_url(.endpoint = .endpoint, ...)
  ""
}

bbt_call_http <- function(.endpoint, ..., .payload = NULL) {
  try({
    url <- bbt_url(.endpoint = .endpoint, ...)
    httr::content(httr::GET(url), as = "text", encoding = "UTF-8")
  })
}
