
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rbbt

<!-- badges: start -->

[![R build
status](https://github.com/paleolimbot/rbbt/workflows/R-CMD-check/badge.svg)](https://github.com/paleolimbot/rbbt/actions)
<!-- badges: end -->

The goal of rbbt is to connect R to the [Better Bibtex for Zotero
connector](https://retorque.re/zotero-better-bibtex/). This allows the
insertion of in-text citations (pandoc or LaTex style) and BibLaTex
bibliography items directly into the RStudio editor using the RStudio
addin, or to the console otherwise.

## Installation

You can install rbbt from GitHub with:

``` r
remotes::install_github("paleolimbot/rbbt")
```

``` r
library(rbbt)
```

You will also need [Zotero](https://www.zotero.org/) installed and
running, and the [Better BibTeX for
Zotero](https://retorque.re/zotero-better-bibtex/installation/) add-on
installed.

## RStudio Addin

This package is most useful for the RStudio addins that insert citations
and references into the editor. The “Insert Zotero Citation” will pop up
a zotero search where you can search for a reference to add to your
writing (Markdown, RMarkdown, or LaTeX). The “Insert Zotero
Bibliography” addin inserts the bibliographical information
corresponding to the selected item in the Zotero window. Finally,
“Update bibliography for current document” runs `bbt_update_bib()` to
update the bibliography based on the .Rmd file currently in the editor
window. You can bind either of these to keyboard shortcuts in RStudio.
The addins may behave differently depending on which file you have open
(e.g., if you have a .bib file open, it will use the biblatex
translator)…if you need more fine-grained control, try one of the
console functions (like `bbt_bib()`!).

## RStudio shortcuts

In RStudio, it is possible to assign a keyboard shortcut for **rbbt**
addins. Just go to *Tools –\> Modify Keyboard Shortcuts* and a small
window will open with all the available commands to assign a keyboard
shortcut. Then, using the **Scope** column, find the *Addin* type and
configure the shortcuts for **rbbt** commands. For example: to set a
shortcut for `bbt_update_bib()`, go to the row assigned for **“Update
bibliography for current document from Zotero”**, click on the
**Shortcut** column and press the desired key combination. It is
recommended to define shortcuts for **“Update bibliography for current
document from Zotero”** and **“Insert Zotero citation”** as they will be
the most used.

It should be noted that RStudio comes configured with some keyboard
shortcuts, so it should be avoided that the newly defined shortcuts
overlap (if this happens, a warning icon will be displayed in the
shortcut assignment window).

Also, for the commands to work correctly, they must be executed having
the Rmd or Qmd file in the active tab in RStudio. That is to say, both
addins mentioned above will detect the citations and the bibliography
file from the active tab (from the main .Rmd or .Qmd file) from where
the shortcut is executed, so you must make sure to have that document
active when executing the commands, otherwise you will receive the
following error message: **“Currently selected editor is not a .qmd,
.rmd or .Rmd file”**.

In RStudio, it is possible to assign a keyboard shortcut for rbbt
addins. Just go to Tools –\> Modify Keyboard Shortcuts and a small
window will open with all the available commands to assign a keyboard
shortcut. Then, using the **Scope** column, find the **Addin** type and
configure the shortcuts for **rbbt** commands. For example: to set a
shortcut for `bbt_update_bib()`, go to the row assigned for **“Update
bibliography for current document from Zotero”**, click on the
**Shortcut** column and press the desired key combination. It is
recommended to define shortcuts for **“Update bibliography for current
document from Zotero”** and **“Insert Zotero citation”** as they will be
the most used.

## knitr + rmarkdown integration

To make this work seamlessly with [knitr](https://yihui.org/knitr/) and
[rmarkdown](https://rmarkdown.rstudio.com/), use the “Update
bibliography for current document” addin to write your bibliography file
based on the citations in the currently selected document. You can use
`bbt_update_bib("some_file.Rmd")` to detect citations and write your
bibliography file from the console.

# Versions

## 0.0.1

- Add functionality for citing R packages. Now, if the user wants to
  cite a R package, must indicate this with the syntax
  `@rpkg_NameOfPackage` (e.g. `@rpkg_rbbt`).
- R native pipe is used in some functions so now it is necessary to run
  **rbbt** in **R \>= 4.1.0**.
- Subtle corrections and improvements in code and documentation.

## 0.0.0.9002

- Changes in `bbt_detect_citations` in order to avoid including
  citations that starts whether with *fig-* or *tbl-* (associtaed with
  Quarto syntaxis).
- Minor improvements in definiton of external functions and
  dependencies.
