% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write-bib.R
\name{bbt_guess_translator}
\alias{bbt_guess_translator}
\alias{bbt_guess_format}
\title{Guess the BetterBibTeX translator format from the file extension}
\usage{
bbt_guess_translator(path, .bib = getOption("rbbt.default.bib", "biblatex"))

bbt_guess_format(path)
}
\arguments{
\item{path}{The output path for the bibliography file. Must end with \code{.json}, \code{.bib}, or \code{.yaml}.}

\item{.bib}{Should \code{.bib} files be returned in \code{"biblatex"} (default) or \code{"bibtex"} format?}
}
\value{
Character vector of length 1 with the guessed translator format.
}
\description{
Guess the BetterBibTeX translator format from the file extension
}
\note{
The default format for \code{.bib} files can be changed. For example:
\code{getOption("rbbt.default.bib", "biblatex")}
}
\examples{
bbt_guess_translator("bibliography.json")
bbt_guess_translator("bibliography.bib")

}
