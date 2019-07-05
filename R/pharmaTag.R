#' Tag a ggplot2 graphic with meta information, specific to phara requirements
#'
#' A wrapper for `ggTag`, specific to the pharma industry
#' @param protocol What is the protocol number?
#' @param population What is the population?
#' @param page What is the page?
#' @param pages How many pages are there?
#' @param date Logical. Defaults to TRUE.
#' @param username Logical. Defaults to TRUE.
#' @param path Logical. Defaults to TRUE.
#' @param date_format Character.  R date format to use for the date.
#' @param ... Arguments to pass to `ggTag`
#' @import grid
#' @importFrom stringr str_split
#' @export
#' @rdname ggTag
pharmaTag <- function(object,
                      protocol = NA, 
                      population = NA,
                      page = 1,
                      pages = 1,
                      date = TRUE, 
                      username = TRUE, 
                      path = TRUE,
                      date_format = "%d%b%Y %H:%M",
                      ...){
  
  # Define Meta
  protocol <- paste("Protocol:", protocol)
  population <- paste("Population:", population)
  pageInfo <- paste("Page", page, "of", pages)
  
  # Deal with additional meta
  otherArgs <- list(...)
  otherArgsUsed <- names(otherArgs)
  if(!("meta" %in% otherArgsUsed)){
    meta <- NULL
  }

  # Top left
  top_left <- paste(protocol, population, sep = "\n")
  
  # Top right
  top_right <- paste(pageInfo, sep = "\n")

  
  ggTag(object, 
        meta = list(top_left = top_left, 
                    top_right = top_right,
                    bottom_left = createUserPath(username, path),
                    bottom_right = addDateTime(date_format = date_format)),
        ...) 
}