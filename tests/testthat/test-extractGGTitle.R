context("Check that the framework is correctly generated")

library(ggplot2)

testGraph <- qplot(Day, Wind, data = airquality, geom = "line", 
                   colour = factor(Month))
testGraphWTitle <- testGraph + 
  ggtitle("Wind vs Day")
testGraphWSTitle <- testGraph + 
  ggtitle("Wind vs Day", subtitle="New York, 1973")

test_that("Can extract a title", {
  expect_equal(extractGGTitle(testGraphWTitle), "Wind vs Day")
  expect_equal(extractGGTitle(testGraphWSTitle), "Wind vs Day\nNew York, 1973")
})

test_that("Can delete a title", {
  expect_equal(deleteGGTitle(testGraphWTitle)$labels, testGraph$labels)
})