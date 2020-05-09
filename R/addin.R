
bbt_cite_addin <- function() {
  # get the likely citation type from the current document context
  context <- rstudioapi::getActiveDocumentContext()
  bbt_ref_cayw(
    format = bbt_guess_format(bbt_rstudio_editor_filepath()),
    .action = bbt_insert
  )
}

bbt_bib_addin <- function() {
  bbt_bib_selected(
    translator = bbt_guess_translator(bbt_rstudio_editor_filepath()),
    .action = bbt_insert
  )
}

bbt_rstudio_editor_filepath <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  if (is.character(context$path)) {
    context$path
  } else {
    stop(
      "Can't find the current RStudio editor. Do you have an editing window open?",
      call. = FALSE
    )
  }
}
