
test_that("bbt_libraries() works", {
  skip_if_not(has_bbt())

  expect_true(nrow(bbt_libraries()) >= 1)
  expect_identical(names(bbt_libraries()), c("id", "name"))
})

test_that("bbt_library_id() works", {
  expect_identical(bbt_library_id(character()), integer())
  expect_identical(bbt_library_id(NA_character_), NA_integer_)

  skip_if_not(has_bbt())
  expect_identical(bbt_library_id("My Library"), 1L)
  expect_error(bbt_library_id("Not A Library"), "Can't find Zotero library")
})
