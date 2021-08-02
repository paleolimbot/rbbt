
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

## knitr + rmarkdown integration

To make this work seamlessly with [knitr](https://yihui.org/knitr/) and
[rmarkdown](https://rmarkdown.rstudio.com/), use the “Update
bibliography for current document” addin to write your bibliography file
based on the citations in the currently selected document. You can use
`bbt_update_bib("some_file.Rmd")` to detect citations and write your
bibliography file from the console.

## Programmatically fetch bibliography info

Fetch bibliography text using a list of Better BibTex citation keys:

``` r
# uses the citation keys you've defined with Better BibTeX
rbbt::bbt_bib("dunnington_etal18", translator = "biblatex", .action = bbt_print)

@article{dunnington_etal18,
  title = {Anthropogenic Activity in the {{Halifax}} Region, {{Nova Scotia}}, {{Canada}}, as Recorded by Bulk Geochemistry of Lake Sediments},
  author = {Dunnington, Dewey W. and Spooner, I. S. and Krkošek, Wendy H. and Gagnon, Graham A. and Cornett, R. Jack and White, Chris E. and Misiuk, Benjamin and Tymstra, Drake},
  date = {2018-06-18},
  journaltitle = {Lake and Reservoir Management},
  volume = {34},
  number = {4},
  pages = {334--348},
  doi = {10.1080/10402381.2018.1461715},
  abstract = {Separating the timing and effects of multiple watershed disturbances is critical to a comprehensive understanding of lakes, which is required to effectively manage lacustrine systems that may be experiencing adverse water quality changes. Advances in X-ray fluorescence (XRF) technology has led to the availability of high-resolution, high-quality bulk geochemical data for aquatic sediments, which in combination with carbon, nitrogen, δ13C, and δ15N have the potential to identify watershed-scale disturbance in lake sediment cores. We integrated documented anthropogenic disturbances and changes in bulk geochemical parameters at 8 lakes within the Halifax Regional Municipality (HRM), Nova Scotia, Canada, 6 of which serve as drinking water sources. These data reflect more than 2 centuries of anthropogenic disturbance in the HRM that included deforestation, urbanization and related development, and water-level change. Deforestation activity was documented at Lake Major and Pockwock Lake by large increases in Ti, Zr, K, and Rb (50–300\%), and moderate increases in C/N ({$>$}10\%). Urbanization was resolved at Lake Fletcher, Lake Lemont, and First Lake by increases in Ti, Zr, K, and Rb (10–300\%), decreases in C/N ({$>$}10\%), and increases in δ15N ({$>$}2.0‰). These data broadly agree with previous paleolimnological bioproxy data, in some cases identifying disturbances that were not previously identified. Collectively these data suggest that bulk geochemical parameters and lake sediment archives are a useful method for lake managers to identify causal mechanisms for possible water quality changes resulting from watershed-scale disturbance.}
}
```

Fetch bibliography text from selected items in Zotero:

``` r
# uses whatever is currently selected in the zotero window
rbbt::bbt_bib_selected(translator = "biblatex", .action = bbt_print)

@article{dunnington_spooner18,
  title = {Using a Linked Table-Based Structure to Encode Self-Describing Multiparameter Spatiotemporal Data},
  author = {Dunnington, Dewey W. and Spooner, Ian S.},
  date = {2018-03-18},
  journaltitle = {FACETS},
  volume = {3},
  number = {1},
  pages = {326--337},
  doi = {10.1139/facets-2017-0026},
  abstract = {Multiparameter data with both spatial and temporal components are critical to advancing the state of environmental science. These data and data collected in the future are most useful when compared with each other and analyzed together, which is often inhibited by inconsistent data formats and a lack of structured documentation provided by researchers and (or) data repositories. In this paper we describe a linked table-based structure that encodes multiparameter spatiotemporal data and their documentation that is both flexible (able to store a wide variety of data sets) and usable (can easily be viewed, edited, and converted to plottable formats). The format is a collection of five tables (Data, Locations, Params, Data Sets, and Columns), on which restrictions are placed to ensure data are represented consistently from multiple sources. These tables can be stored in a variety of ways including spreadsheet files, comma-separated value (CSV) files, JavaScript object notation (JSON) files, databases, or objects in a software environment such as R or Python. A toolkit for users of R statistical software was also developed to facilitate converting data to and from the data format. We have used this format to combine data from multiple sources with minimal metadata loss and to effectively archive and communicate the results of spatiotemporal studies. We believe that this format and associated discussion of data and data storage will facilitate increased synergies between past, present, and future data sets in the environmental science community.}
}
```

<!-- lazy way to test the bbt_update_bib() addon: @dunnington_etal18 -->
