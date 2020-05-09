
test_that("regex for citations works", {
  expect_identical(
    bbt_detect_citations_chr("\n@citation1 [@citation2] but not \\@citation3"),
    c("citation1", "citation2")
  )
})

test_that("detect_citations can operate on a character vector or file", {
  expect_identical(
    bbt_detect_citations("\n@citation1 [@citation2] but not \\@citation3"),
    c("citation1", "citation2")
  )

  file <- tempfile()
  write("\n@citation1 [@citation2] but not \\@citation3", file)
  expect_identical(
    bbt_detect_citations(file),
    c("citation1", "citation2")
  )
  unlink(file)
})
