
bbt_cite_addin <- function() {
  # get the likely citation type from the current document context
  context <- rstudioapi::getActiveDocumentContext()
  if(is.character(context$path) && (grepl("tex$", context$path[1]))) {
    bbt_cayw_bib("cite", .action = bbt_insert)
  } else {
    bbt_cayw_bib("pandoc", .action = bbt_insert)
  }
}

bbt_biblatex_zotero_addin <- function() {
  bbt_bib_selected(translator = "biblatex", .action = bbt_insert)
}

bbt_bibtex_zotero_addin <- function() {
  bbt_bib_selected(translator = "bibtex", .action = bbt_insert)
}
