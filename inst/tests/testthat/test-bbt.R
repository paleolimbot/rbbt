
test_that("endpoints work", {
  skip_if_not(has_bbt())

  expect_true(has_bbt())
  expect_silent(assert_bbt())
  expect_identical(bbt_call("cayw", probe = TRUE), "ready")
  expect_identical(bbt_cayw(probe = TRUE, .action = bbt_return), "ready")
  expect_identical(
    bbt_call_json_rpc("item.search", "absolutelynowaytheresanything"),
    list(jsonrpc = "2.0", result = list(), id = NULL)
  )
})

test_that("bibliography generators work", {
  skip_if_not(has_bbt())

  expect_is(bbt_bib_selected(.action = bbt_return), "character")
  expect_length(bbt_bib_selected(.action = bbt_return), 1)

  expect_is(bbt_bib("dunnington_etal18", .action = bbt_return), "character")
  expect_length(bbt_bib("dunnington_etal18", .action = bbt_return), 1)

  expect_error(bbt_bib("notacitationkeyanywhere"), "not found")
  expect_silent(bbt_bib(character(0)))
})

test_that("actions work", {
  expect_identical(bbt_return("stuff"), "stuff")
  expect_output(bbt_print("stuff"), "stuff")

  if(clipr::clipr_available()) {
    prev_clip <- clipr::read_clip()
    expect_message(bbt_copy("stuff"), "copied")
    expect_identical(clipr::read_clip(), "stuff")
    clipr::write_clip(prev_clip)
  }
})
