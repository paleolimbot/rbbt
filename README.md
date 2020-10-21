
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
corresponding to the selected item in the Zotero window. You can bind
either of these to keyboard shortcuts in RStudio. The addin behaves
differently depending on which file you have open (e.g., if you have a
.bib file open, it will use the biblatex translator)…if you need more
fine-grained control, try one of the console functions (like
`bbt_bib()`\!).

## knitr + rmarkdown integration

To make this work seamlessly with [knitr](https://yihui.org/knitr/) and
[rmarkdown](https://rmarkdown.rstudio.com/), you can use
`bbt_write_bib()` to detect citations in the current document and write
your bibliography file, all in one go\! One way to go about this is to
use something like this in your YAML front matter:

``` 

---
title: "Zotero + Better BibTeX + RMarkdown using rbbt"
output: html_document
bibliography: "`r rbbt::bbt_write_bib('biblio.json', overwrite = TRUE)`"
---
```

This is still experimental, so file an issue if it fails\! You can use
`bbt_write_bib("biblio.json", bbt_detect_citation("file.Rmd"))` to do
this manually.

## Programmatically fetch bibliography info

Fetch bibliography text using a list of Better BibTex citation keys:

``` r
# uses the citation keys you've defined with Better BibTeX
rbbt::bbt_bib("dunnington_etal18", translator = "biblatex", .action = bbt_print)

@article{dunnington_etal18,
  title = {Anthropogenic Activity in the {{Halifax}} Region, {{Nova Scotia}}, {{Canada}}, as Recorded by Bulk Geochemistry of Lake Sediments},
  author = {Dunnington, Dewey W. and Spooner, Ian S. and Krkošek, Wendy H. and Gagnon, Graham A. and Cornett, R. Jack and Kurek, Joshua and White, Chris E. and Misiuk, Ben and Tymstra, Drake},
  date = {2018-10-02},
  journaltitle = {Lake and Reservoir Management},
  volume = {34},
  pages = {334--348},
  publisher = {{Taylor \& Francis}},
  issn = {1040-2381},
  doi = {10.1080/10402381.2018.1461715},
  url = {https://doi.org/10.1080/10402381.2018.1461715},
  urldate = {2020-10-20},
  abstract = {Dunnington DW, Spooner IS, Krkošek WH, Gagnon GA, Cornett RJ, Kurek J, White CE, Misiuk B, Tymstra D. 2018. Anthropogenic activity in the Halifax region, Nova Scotia, Canada, as recorded by bulk geochemistry of lake sediments. Lake Reserv Manage. 34:334–348.Separating the timing and effects of multiple watershed disturbances is critical to a comprehensive understanding of lakes, which is required to effectively manage lacustrine systems that may be experiencing adverse water quality changes. Advances in X-ray fluorescence (XRF) technology has led to the availability of high-resolution, high-quality bulk geochemical data for aquatic sediments, which in combination with carbon, nitrogen, d13C, and d15N have the potential to identify watershed-scale disturbance in lake sediment cores. We integrated documented anthropogenic disturbances and changes in bulk geochemical parameters at 8 lakes within the Halifax Regional Municipality (HRM), Nova Scotia, Canada, 6 of which serve as drinking water sources. These data reflect more than 2 centuries of anthropogenic disturbance in the HRM that included deforestation, urbanization and related development, and water-level change. Deforestation activity was documented at Lake Major and Pockwock Lake by large increases in Ti, Zr, K, and Rb (50–300\%), and moderate increases in C/N ({$>$}10\%). Urbanization was resolved at Lake Fletcher, Lake Lemont, and First Lake by increases in Ti, Zr, K, and Rb (10–300\%), decreases in C/N ({$>$}10\%), and increases in d15N ({$>$}2.0‰). These data broadly agree with previous paleolimnological bioproxy data, in some cases identifying disturbances that were not previously identified. Collectively these data suggest that bulk geochemical parameters and lake sediment archives are a useful method for lake managers to identify causal mechanisms for possible water quality changes resulting from watershed-scale disturbance.},
  annotation = {\_eprint: https://doi.org/10.1080/10402381.2018.1461715},
  file = {C\:\\Users\\dunningtond\\Zotero\\storage\\IA5XVLSM\\10402381.2018.html},
  keywords = {C and N isotopes,C/N ratios; disturbance,land-use change,Nova Scotia,paleolimnology,X-ray fluorescence},
  number = {4}
}
```

Fetch bibliography text from selected items in Zotero:

``` r
# uses whatever is currently selected in the zotero window
rbbt::bbt_bib_selected(translator = "biblatex", .action = bbt_print)
Could not export bibliography: no selection
```
