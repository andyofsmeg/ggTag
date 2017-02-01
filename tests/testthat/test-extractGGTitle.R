context("Check that the framework is correctly generated")

library(ggplot2)

testGraph <- qplot(Day, Wind, data = airquality, geom = "line", 
                   colour = factor(Month))
testGraphWTitle <- testGraph + 
  ggtitle("Wind vs Day")

test_that("Can extract a title", {
  expect_equal(extractGGTitle(testGraphWTitle), "Wind vs Day")
})

test_that("Can delete a title", {
  expect_equal(deleteGGTitle(testGraphWTitle), testGraph)
})