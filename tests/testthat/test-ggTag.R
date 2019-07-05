context("Check that the framework is correctly generated")

library(ggplot2)
library(grid)

testGraph <- qplot(Day, Wind, data = airquality, geom = "line", 
                   colour = factor(Month), main = "Wind vs Day")

test_that("Can create an image", {
  expect_silent(ggTag(testGraph))
})