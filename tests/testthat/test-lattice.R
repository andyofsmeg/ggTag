context("Handles lattice objects")

library(lattice)

testGraph <- xyplot(Wind~Day, data = airquality, main = "Test")

test_that("Defaults work with lattice objects", {
  expect_error(structure(ggTag(testGraph)), NA)
})
