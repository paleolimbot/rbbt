
test_that("regex for citations works", {
  expect_identical(
    bbt_detect_citations_chr("\n@citation1. \n@citation1991AlphaBetaGamma [@citation2] [@citation2020author]. but not \\@citation3 and not not \\@citation2019NotValid"),
    c("citation1","citation1991AlphaBetaGamma", "citation2", "citation2020author")
  )
})

test_that("detect_citations can operate on a character vector or file", {
  expect_identical(
    bbt_detect_citations("\n@citation1 \n@citation1991AlphaBetaGamma [@citation2] [@citation2020author] but not \\@citation3 and not not \\@citation2019NotValid"),
    c("citation1","citation1991AlphaBetaGamma", "citation2", "citation2020author")
  )

  file <- tempfile()
  write("\n@citation1 \n@citation1991AlphaBetaGamma [@citation2] [@citation2020author] but not \\@citation3 and not not \\@citation2019NotValid", file)
  expect_identical(
    bbt_detect_citations(file),
    c("citation1","citation1991AlphaBetaGamma", "citation2", "citation2020author")
  )
  unlink(file)
})

test_that("detect_citations can handle a vector of files", {
  f1 <- tempfile()
  f2 <- tempfile()
  write("\n@citation1\n", f1)
  write("\n@citation2\n", f2)
  expect_setequal(bbt_detect_citations(c(f1, f2)), c("citation1", "citation2"))
  unlink(c(f1, f2))
})

test_that("detect_citations ignores code chunks", {
  mock_content <- '


```{r}
@not_a_citation
```

`r @also_not_a_citation`


[Some link](https://something.com/@not_a_citation_too)

<https://something.com/@not_a_citation_too>


@actual_citation

'

  expect_identical(bbt_detect_citations_chr(mock_content), "actual_citation")


})
