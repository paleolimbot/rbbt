
#' Query Zotero Libraries
#'
#' Useful for specifying the `library_id` in [bbt_bib()] or [bbt_write_bib()]
#' when using a group library whose `id` may be different between users.
#' Use [bbt_library_id()] to look up this ID by name.
#'
#' @param x A name of a Zotero library (e.g., "My Library")
#'
#' @return A data.frame with columns `id` and `name`.
#' @export
#'
#' @examples
#' if (has_bbt()) bbt_libraries()
#'
bbt_libraries <- function() {
  groups <- rbbt::bbt_call_json_rpc("user.groups")
  data.frame(
    id = vapply(groups$result, function(x) x$id, integer(1)),
    name = vapply(groups$result, function(x) x$name, character(1)),
    stringsAsFactors = FALSE
  )
}

#' @rdname bbt_libraries
#' @export
bbt_library_id <- function(x) {
  x_is_na <- is.na(x)
  if (all(x_is_na)) {
    return(rep(NA_integer_, length(x)))
  }

  libs <- bbt_libraries()
  result <- libs$id[match(x, libs$name)]

  if (any(is.na(result) & !x_is_na)) {
    bad_x <- x[is.na(result) & !x_is_na]
    stop(paste0("Can't find Zotero library: ", paste0("'", bad_x, "'", collapse = ", ")))
  }

  result
}
