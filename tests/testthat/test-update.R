
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

  bbt_update_bib(rmd_file)

  expect_match(readr::read_file(bib_file), "dunnington_etal18")

  unlink(c(rmd_file, bib_file))
})

test_that("bbt_guess_bib_file() fails with ambiguous bibliography field", {
  mock_content <- '
---
bibliography: [file1.bib, file2.bib]
---

'

  rmd_file <- tempfile(fileext = ".Rmd")
  readr::write_file(mock_content, rmd_file)
  expect_error(bbt_guess_bib_file(rmd_file), "Can't guess")

  mock_content <- '
---
not_bibliography: file1.bib
---

'

  rmd_file <- tempfile(fileext = ".Rmd")
  readr::write_file(mock_content, rmd_file)
  expect_error(bbt_guess_bib_file(rmd_file), "Can't guess")

  unlink(rmd_file)
})
