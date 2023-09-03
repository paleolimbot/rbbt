#' .onLoad getOption package settings
#'
#' @param libname defunct
#' @param pkgname defunct
#'
#' @return
#'
#' @examples
#' getOption("rbbt.whitelist.quarto")
.onLoad <- function(libname, pkgname) {
  op <- options()
  op_rbbt <- list(
    rbbt.whitelist.quarto=c("^fig-", "^tbl-", "^eq-", "^sec-", "^lst-", "^thm-"),
    rbbt.whitelist.user=c()
    )
  toset <- !(names(op_rbbt) %in% names(op))
  if (any(toset)) options(op_rbbt[toset])

  invisible()
}
