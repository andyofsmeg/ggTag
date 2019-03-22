context("Adding user name and path")

test_that("path is correctly generated", {

  currentPath <- getwd()
  pathTRUE <- createUserPath(userID = FALSE, path = TRUE)  
  pathFALSE <- createUserPath(userID = FALSE, path = FALSE)
  pathString <- createUserPath(userID = FALSE, path = "ABC/DEF")
  
  expect_equal(pathTRUE, currentPath)
  expect_equal(pathFALSE, "")
  expect_equal(pathString, "ABC/DEF")
})

test_that("User ID is correctly generated", {
  
  user <- Sys.info()["user"]
  
  expect_equal(createUserPath(userID = TRUE, path = FALSE), user)
  
})

test_that("Combined User & path generate as expected", {

  user <- Sys.info()["user"]
  currentPath <- getwd()
  
  idPath <- createUserPath(userID = TRUE, path = TRUE)
  
  expect_equal(idPath, paste(user, currentPath, sep = ":"))
  
})