
test_that("bib writer works", {
  skip_if_not(has_bbt())

  file <- tempfile()
  expect_identical(
    bbt_write_bib(file, "dunnington_etal18"),
    file
  )
  expect_error(
    bbt_write_bib(file, "dunnington_etal18"),
    "overwrite"
  )
  expect_identical(
    bbt_write_bib(file, "dunnington_etal18", overwrite = TRUE),
    file
  )

  unlink(file)
})

test_that("bib guessers work", {
  expect_identical(bbt_guess_translator("thing.bib"), "biblatex")
  expect_identical(bbt_guess_translator("thing.json"), "csljson")
  expect_identical(bbt_guess_translator("thing.yaml"), "cslyaml")

  expect_identical(bbt_guess_format("thing.tex"), "cite")
  expect_identical(bbt_guess_format("thing.Rmd"), "pandoc")
})

