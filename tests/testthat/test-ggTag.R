context("Check that the framework is correctly generated")

library(ggplot2)
library(grid)

testGraph <- qplot(Day, Wind, data = airquality, geom = "line", 
                   colour = factor(Month), main = "Wind vs Day")

test_that("Can create an image", {
  expect_silent(ggTag(testGraph))
})



library(png)
png_loc <- system.file(package = "ggTag", "extdata/r_logo.png")
a_png <- readPNG(png_loc)

pharmaTag(object = a_png, raster = TRUE,
          protocol = "ABC123456",
          population = "Intent-to-treat")

test_that("Can create an image from png", {
  expect_silent(ggTag(testGraph))
})