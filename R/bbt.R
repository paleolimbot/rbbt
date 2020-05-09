
#' Insert references from Zotero
#'
#' Using BetterBibTex's
#' [cite-as-you-write tool](https://retorque.re/zotero-better-bibtex/cayw/).
#' Unfortunately, this doesn't work well on some platforms.
#' Citation text
#' is printed to the console by default (use the addin to insert directly
#' into the editor!).
#'
#' @param format The citation format to use (in-text citations)
#' @param translator The translator to use (bibliography files)
#' @param .action Use [bbt_return()] to return the value without printing.
#'
#' @return A character vector of length 1, the result of `.action`.
#' @export
#'
bbt_ref_cayw <- function(format = c("pandoc", "latex", "cite"), .action = bbt_print) {
  assert_bbt()
  format <- match.arg(format)
  bbt_cayw(format = format, .action = .action)
}

#' @rdname bbt_ref_cayw
#' @export
bbt_bib_cayw <- function(translator = c("biblatex", "bibtex", "csljson", "cslyaml"),
                         .action = bbt_print) {
  assert_bbt()
  translator <- match.arg(translator)
  bbt_cayw(format = "translate", translator = translator, .action = .action)
}

#' Insert selected bibliography items from Zotero
#'
#' Returns the bibliography version of the selected items in the
#' Zotero pane.
#'
#' @inheritParams bbt_ref_cayw
#' @param keys A character vector of citation keys.
#'
#' @return The result of `.action`.
#' @export
#'
bbt_bib_selected <- function(translator = c("biblatex", "bibtex", "csljson", "cslyaml"),
                             .action = bbt_print) {
  assert_bbt()
  translator <- match.arg(translator)
  .action(bbt_call(.endpoint = "select", translator))
}

#' @rdname bbt_bib_selected
#' @export
bbt_bib <- function(keys, translator = c("biblatex", "bibtex", "csljson", "cslyaml"),
                    .action = bbt_print) {
  if (length(keys) == 0)  {
    return()
  }

  assert_bbt()
  translator <- match.arg(translator)
  result <- bbt_call_json_rpc("item.export", as.list(unique(as.character(keys))), translator)

  if (!is.null(result$error)) {
    stop(result$error$message, call. = FALSE)
  } else {
    .action(result$result[[3]])
  }
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
