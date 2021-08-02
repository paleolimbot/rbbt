
bbt_cite_addin <- function() {
  # get the likely citation type from the current document context
  context <- rstudioapi::getActiveDocumentContext()
  bbt_cite_cayw(
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

bbt_update_bib_addin <- function() {
  context <- bbt_rstudio_editor_filepath()
  if (!(tools::file_ext(context) %in% c("rmd", "Rmd"))) {
    stop("Currently selected editor is not a .rmd or .Rmd file", call. = FALSE)
  }

  message(sprintf('Running `bbt_update_bib("%s")`', context))
  bbt_update_bib(context, quiet = FALSE)
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
