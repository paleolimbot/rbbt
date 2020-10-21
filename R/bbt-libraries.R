
#' Query Zotero Libraries
#'
#' Useful for specifying the `library_id` in [bbt_bib()] or [bbt_write_bib()]
#' when using a group library whose `id` may be different between users.
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
