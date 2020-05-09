
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rbbt

The goal of **rbbt** is to connect R to the [Better Bibtex for Zotero
connector](https://retorque.re/zotero-better-bibtex/). This allows the
insertion of in-text citations (pandoc or LaTex style) and BibLaTex
bibliography items directly into the RStudio editor using the RStudio
addin, or to the console otherwise.

## Installation

You can install rbbt from GitHub with:

``` r
remotes::install_github("paleolimbot/rbbt")
```

You will also need [Zotero](https://www.zotero.org/) installed and
running, and the [Better BibTeX for
Zotero](https://retorque.re/zotero-better-bibtex/installation/) add-on
installed.

## Example

Insert bibliography text using your Better BibTex citation keys:

``` r
# uses the citation keys you've defined with BetterBibTex
rbbt::bbt_bib("dunnington_etal18")

@article{dunnington_etal18,
  title = {Anthropogenic Activity in the {{Halifax}} Region, {{Nova Scotia}}, {{Canada}}, as Recorded by Bulk Geochemistry of Lake Sediments},
  author = {Dunnington, Dewey W. and Spooner, I. S. and Krkošek, Wendy H. and Gagnon, Graham A. and Cornett, R. Jack and White, Chris E. and Misiuk, Benjamin and Tymstra, Drake},
  date = {2018-06-18},
  journaltitle = {Lake and Reservoir Management},
  volume = {34},
  pages = {334--348},
  doi = {10.1080/10402381.2018.1461715},
  abstract = {Separating the timing and effects of multiple watershed disturbances is critical to a comprehensive understanding of lakes, which is required to effectively manage lacustrine systems that may be experiencing adverse water quality changes. Advances in X-ray fluorescence (XRF) technology has led to the availability of high-resolution, high-quality bulk geochemical data for aquatic sediments, which in combination with carbon, nitrogen, δ13C, and δ15N have the potential to identify watershed-scale disturbance in lake sediment cores. We integrated documented anthropogenic disturbances and changes in bulk geochemical parameters at 8 lakes within the Halifax Regional Municipality (HRM), Nova Scotia, Canada, 6 of which serve as drinking water sources. These data reflect more than 2 centuries of anthropogenic disturbance in the HRM that included deforestation, urbanization and related development, and water-level change. Deforestation activity was documented at Lake Major and Pockwock Lake by large increases in Ti, Zr, K, and Rb (50–300\%), and moderate increases in C/N ({$>$}10\%). Urbanization was resolved at Lake Fletcher, Lake Lemont, and First Lake by increases in Ti, Zr, K, and Rb (10–300\%), decreases in C/N ({$>$}10\%), and increases in δ15N ({$>$}2.0‰). These data broadly agree with previous paleolimnological bioproxy data, in some cases identifying disturbances that were not previously identified. Collectively these data suggest that bulk geochemical parameters and lake sediment archives are a useful method for lake managers to identify causal mechanisms for possible water quality changes resulting from watershed-scale disturbance.},
  number = {4}
}
```

Insert bibliography text from selected items in Zotero using the RStudio
Addin, or print to the console using `bbt_bib_selected()`:

``` r
# uses whatever is currently selected in the zotero window
rbbt::bbt_bib_selected()

@article{dunnington_etal18,
  title = {Anthropogenic Activity in the {{Halifax}} Region, {{Nova Scotia}}, {{Canada}}, as Recorded by Bulk Geochemistry of Lake Sediments},
  author = {Dunnington, Dewey W. and Spooner, I. S. and Krkošek, Wendy H. and Gagnon, Graham A. and Cornett, R. Jack and White, Chris E. and Misiuk, Benjamin and Tymstra, Drake},
  date = {2018-06-18},
  journaltitle = {Lake and Reservoir Management},
  volume = {34},
  pages = {334--348},
  doi = {10.1080/10402381.2018.1461715},
  abstract = {Separating the timing and effects of multiple watershed disturbances is critical to a comprehensive understanding of lakes, which is required to effectively manage lacustrine systems that may be experiencing adverse water quality changes. Advances in X-ray fluorescence (XRF) technology has led to the availability of high-resolution, high-quality bulk geochemical data for aquatic sediments, which in combination with carbon, nitrogen, δ13C, and δ15N have the potential to identify watershed-scale disturbance in lake sediment cores. We integrated documented anthropogenic disturbances and changes in bulk geochemical parameters at 8 lakes within the Halifax Regional Municipality (HRM), Nova Scotia, Canada, 6 of which serve as drinking water sources. These data reflect more than 2 centuries of anthropogenic disturbance in the HRM that included deforestation, urbanization and related development, and water-level change. Deforestation activity was documented at Lake Major and Pockwock Lake by large increases in Ti, Zr, K, and Rb (50–300\%), and moderate increases in C/N ({$>$}10\%). Urbanization was resolved at Lake Fletcher, Lake Lemont, and First Lake by increases in Ti, Zr, K, and Rb (10–300\%), decreases in C/N ({$>$}10\%), and increases in δ15N ({$>$}2.0‰). These data broadly agree with previous paleolimnological bioproxy data, in some cases identifying disturbances that were not previously identified. Collectively these data suggest that bulk geochemical parameters and lake sediment archives are a useful method for lake managers to identify causal mechanisms for possible water quality changes resulting from watershed-scale disturbance.},
  number = {4}
}
```

To make this work seamlessly with [knitr]() and [rmarkdown](), you can
use `bbt_write_bib()` to detect citations in the current document and
write your bibliography file, all in one go\! One way to go about this
is to use something like this in your YAML front matter:

``` 

---
title: "Zotero + Better BibTeX + RMarkdown using rbbt"
output: html_document
bibliography: "`r rbbt::bbt_write_bib('biblio.bib', overwrite = TRUE)`"
---
```

This is still experimental, so file an issue if it fails\!
