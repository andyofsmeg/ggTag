#' Add time to plot
#' 
#' Utility function for adding date and time as meta-information
#'
#' @param dateFormat Character.  R date format to use for the date.
#' 
#' @export
addDateTime <- function(dateFormat = "%d%b%Y %H:%M"){
  
  pos <- position()
  
  theTime <- Sys.time()
  theTime <- toupper(format(theTime, dateFormat))
  
  grid.text(theTime, x = pos$x, y = pos$y, just = pos$just)
  
}

#' Add path to plot
#' 
#' Utility function for adding username and system path
#' 
#' @param userID Logical. Should the username be included
#' @param path Logical or character. If logical, should the working directory be
#' added to the system path. If character, the system path to be added.
#' 
#' @export
addUserPath <- function(userID = TRUE, path = TRUE){
  
  pos <- position()
  
  idAndProjectPath <- createUserPath(userID, path)
  
  if(idAndProjectPath != "")
    grid.text(idAndProjectPath, x = pos$x, y = pos$y, just = pos$just)
  
}


#' Add text to plot
#' 
#' Utility function for adding general text as meta-information
#'
#' @param text Character.  Text to be added to the plot.
#' 
#' @export
addText <- function(text){
  
  pos <- position()
  
  grid.text(text, x = pos$x, y = pos$y, just = pos$just)
  
}
