#' Add time to plot
#'
#' @param dateFormat Character.  R date format to use for the date.
#' 
addDateTime <- function(dateFormat = "%d%b%Y %H:%M"){
  
  theTime <- Sys.time()
  theTime <- toupper(format(theTime, dateFormat))
  
  grid.text(theTime, x = unit(1, "npc"), y = unit(1, "lines"), just = c(1, 0))
  
}