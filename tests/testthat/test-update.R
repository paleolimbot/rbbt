
test_that("bbt_update_bib function works", {
  skip_if_not(has_bbt())
  bib_file <- tempfile(fileext = ".bib")
  mock_content <- sprintf('

---
bibliography: %s
---


This file contains a reference to @dunnington_etal18.

', bib_file)

  rmd_file <- tempfile(fileext = ".Rmd")
  readr::write_file(mock_content, rmd_file)

  bbt_update_bib(rmd_file, bib_file)

  expect_match(readr::read_file(bib_file), "dunnington_etal18")

  unlink(c(rmd_file, bib_file))
})

