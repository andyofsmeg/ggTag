context("Check that utilities behave as expected")

test_that("Date correctly returned", {
  
  now <- Sys.time()
  
  dt <- addDateTime("%d%b%Y")
  
  now <- toupper(format(now, "%d%b%Y"))
  
  expect_equal(dt, now)
  
})

test_that("Can count lines of meta information for a single meta item", {
  expect_equal(countMeta("abc\ndef"), 2)
  expect_equal(countMeta("abc\ndef\n"), 3)
})

test_that("Can find longest metadata item from many items", {
  expect_equal(countMetaMulti("abc\ndef", "abc\ndef\n"), 3)
})