#' Add time to plot
#'
#' @param dateFormat Character.  R date format to use for the date.
#' 
addDateTime <- function(dateFormat = "%d%b%Y %H:%M"){
  
  theTime <- Sys.time()
  theTime <- toupper(format(theTime, dateFormat))
  
  grid.text(theTime, x = unit(1, "npc"), y = unit(1, "lines"), just = c(1, 0))
  
}

#' Count meta lines
#' 
#' Function to count the number of lines of meta information
#' 
#' @param meta Lines of meta information for a single meta data item
#' @return numeric. The total number of lines of meta information.
#' 
countMeta <- function(meta){
  length(unlist(str_split(meta, "\\n")))
}

#' Count meta lines
#' 
#' Function to count the number of lines of meta information
#' 
#' @param ... \code{\link{countMeta}} Multiple metadata items to be counted by `countMeta`
#' @return numeric. The total number of lines of meta information.
#' 
countMetaMulti <- function(...){
  
  metaList <- list(...)
  metaCount <- lapply(metaList, countMeta)
  maxMetaCount <- max(unlist(metaCount))
  
}