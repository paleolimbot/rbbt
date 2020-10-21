
test_that("bbt_libraries() works", {
  expect_true(nrow(bbt_libraries()) >= 1)
  expect_identical(names(bbt_libraries()), c("id", "name"))
})
