
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
