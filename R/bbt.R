
#' Fetch citations from Zotero
#'
#' Use Better BibTex's
#' [cite-as-you-write tool](https://retorque.re/zotero-better-bibtex/cayw/)
#' to search your Zotero libraries and insert citations or a bibliography.
#' Unfortunately, this doesn't work well on some platforms. Citation text is
#' printed to the console by default. Use the RStudio addin to insert directly
#' into the editor!
#'
#' @param format The citation format to use for in-text citations.
#' @param translator Type of bibliography file to create. Options are `json`
#'   (CSL-JSON), `biblatex` (BibLaTeX), `bibtex` (BibTeX), and `yaml`
#'   (CSL YAML). CSL-JSON is recommended if users are not specifically using
#'   a LaTeX citation processor.
#' @param .action Use [bbt_return()] to return the value without printing.
#'
#' @section Note: Most users should use CSL-JSON format (`.json`) for their bibliographies.
#'
#' RMarkdown's citation formatting uses
#' [CSL styles](https://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html#citation_styles).
#' These styles require CSL-JSON data. RMarkdown converts other data formats
#' (e.g., BibLaTeX) to CSL-JSON. This is not lossless, and references other than
#' journal articles may be inaccurate. This is the case even if outputting to
#' PDF or TeX format.
#'
#' Only use BibLaTeX or BibTeX if you are using
#' [pandoc arguments to specify an alternative citation engine for raw TeX output](https://pandoc.org/MANUAL.html#citation-rendering).
#'
#' The default translator can be changed. For example:
#'   `options(rbbt.default.translator = "json")`
#'
#' @return A character vector of length 1, the result of `.action`.
#' @export
#'
bbt_cite_cayw <- function(format = c("pandoc", "latex", "cite"), .action = bbt_print) {
  assert_bbt()
  format <- match.arg(format)
  bbt_cayw(format = format, .action = .action)
}

#' @rdname bbt_cite_cayw
#' @export
bbt_bib_cayw <- function(translator = getOption("rbbt.default.translator", "biblatex"),
                         .action = bbt_print) {
  assert_bbt()
  translator <- match.arg(translator, choices = c("json", "biblatex", "bibtex", "yaml"))
  bbt_cayw(format = "translate", translator = translator, .action = .action)
}

#' Fetch bibliographical information from Zotero
#'
#' Fetch bibliographical information from your Zotero library. `bbt_bib()` fetches
#' information for a vector of citation keys; `bb_bib_selected()` fetches information
#' for the currently selected items in the Zotero pane.
#'
#' @inheritParams bbt_cite_cayw
#' @param keys A character vector of citation keys.
#' @param library_id You may have to pass a specific library ID
#'   if your options are not set to use globally unique keys.
#'   Set the rbbt.default.library_id to ensure this value is
#'   used by the addin. You can use [bbt_library_id()] to look
#'   up this value by name.
#'
#' @inheritSection bbt_cite_cayw Note
#'
#' @return The result of `.action`.
#' @export
#'
bbt_bib_selected <- function(translator = getOption("rbbt.default.translator", "biblatex"),
                             .action = bbt_print) {
  assert_bbt()
  translator <- match.arg(translator, choices = c("json", "biblatex", "bibtex", "yaml"))
  .action(bbt_call(.endpoint = "select", translator))
}

#' @rdname bbt_bib_selected
#' @export
bbt_bib <- function(keys, translator = getOption("rbbt.default.translator", "biblatex"),
                    library_id = getOption("rbbt.default.library_id", 1),
                    .action = bbt_print) {
  if (length(keys) == 0)  {
    return(.action(""))
  }

  assert_bbt()
  translator <- match.arg(translator, choices = c("json", "biblatex", "bibtex", "yaml"))
  result <- bbt_call_json_rpc(
    "item.export",
    as.list(unique(as.character(keys))),
    translator,
    library_id
  )

  if (!is.null(result$error)) {
    stop(result$error$message, call. = FALSE)
  } else {
    .action(result$result)
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
