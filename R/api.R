
#' Test for the Better BibTeX HTTP Endpoint
#'
#' @return `TRUE` if the endpoint exists, `FALSE` otherwise
#' @export
#'
#' @examples
#' has_bbt()
#'
has_bbt <- function() {
  ping <- try(bbt_call(.endpoint = "cayw", probe = TRUE), silent = TRUE)
  identical(ping, "ready")
}

#' @rdname has_bbt
#' @export
assert_bbt <- function() {
  if (!has_bbt()) {
    stop("Can't connect to the Better BibTeX endpoint. Is Zotero running?", call. = FALSE)
  }
}

#' Call the Better BibTex HTTP endpoints
#'
#' See the
#' [JSON-RPC documentation](https://retorque.re/zotero-better-bibtex/exporting/json-rpc/),
#' the [JSON-RPC source code](https://github.com/retorquere/zotero-better-bibtex/blob/master/content/json-rpc.ts),
#' and the [source code for the various endpoints](https://github.com/retorquere/zotero-better-bibtex/blob/master/content/pull-export.ts).
#'
#' @inheritParams bbt_cite_cayw
#' @param .endpoint A supported endpoint.
#' @param .method A supported JSON-RPC method
#' @param ... Arguments as key-value pairs. For JSON-RPC,
#'   these are encoded as JSON, and for the GET API, these
#'   are converted to query-string parameters.
#'
#' @export
#'
bbt_call <- function(.endpoint, ...) {
  url <- bbt_url(.endpoint = .endpoint, ...)
  httr::content(httr::GET(url), as = "text", encoding = "UTF-8")
}

#' @rdname bbt_call
#' @export
bbt_cayw <- function(..., .action = bbt_print) {
  .action(bbt_call("cayw", ...))
}

#' @rdname bbt_call
#' @export
bbt_call_json_rpc <- function(.method, ...) {
  httr::content(
    httr::POST(
      bbt_url("json-rpc"),
      body = list(
        jsonrpc = "2.0",
        method = .method,
        params = list(...)
      ),
      encode = "json"
    ),
    as = "parsed",
    encoding = "UTF-8"
  )
}

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
