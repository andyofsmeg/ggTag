#' Tag a ggplot2 graphic with meta information, specific to phara requirements
#'
#' A wrapper for `ggTag`, specific to the pharma industry
#' @param object A ggplot or lattice object
#' @param protocol What is the protocol number?
#' @param population What is the population?
#' @param page What is the page?
#' @param pages How many pages are there?
#' @param ... Arguments to pass to `ggTag`
#' @import grid
#' @importFrom stringr str_split
#' @export
pharmaTag <- function(object,
                      protocol = NA, 
                      population = NA,
                      page = 1,
                      pages = 1,
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
  if(!("metaRight" %in% otherArgsUsed)){
    metaRight <- NULL
  }

  # Top left
  if(!is.null(meta)){
    metaLeft <- paste(protocol, population, meta, sep = "\n")
  }
  else{
    metaLeft <- paste(protocol, population, sep = "\n")
  }
  
  # Top right
  if(!is.null(metaRight)){
    metaRight <- paste(pageInfo, metaRight, sep = "\n")
  }
  else{
    metaRight <- paste(pageInfo, sep = "\n")
  }
  
  ggTag(object, 
        meta = metaLeft, 
        metaRight = metaRight) 
}