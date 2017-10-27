#' Add time to plot
#'
#' @param dateFormat Character.  R date format to use for the date.
#' @param fontsize The font size in pt
#' 
addDateTime <- function(dateFormat = "%d%b%Y %H:%M", fontsize = 12){
  
  theTime <- Sys.time()
  theTime <- toupper(format(theTime, dateFormat))
  
  grid.text(theTime, x = unit(1, "npc"), y = unit(1, "lines"), 
            gp=gpar(fontsize=fontsize), just = c(1, 0))
  
}

#' Add path to plot
#' 
#' @param userID
#' @param path
#' @param fontsize The font size in pt
#' 
addUserPath <- function(userID = TRUE, path = TRUE, fontsize = 12){
  
  idAndProjectPath <- createUserPath(userID, path)
  
  if(idAndProjectPath != "")
    grid.text(idAndProjectPath, x = unit(0, "npc"), y = unit(1, "lines"), 
              gp=gpar(fontsize=fontsize), just = c(0, 0))
  
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


#' Create User & Path String
#'
#' @param userID logical. Should the user ID be included with the path
#' @param path logical or character. If logical, should current working directory 
#' be added as the path. If character, the path to be included.
#'
createUserPath <- function(userID = TRUE, path = TRUE){

  # Convert logical to correct path
  path <- switch(as.character(path), 
                 "TRUE" = getwd(),
                 "FALSE" = "",
                 path)
  
  # Combinations of path & userID
  if(userID & path != ""){
  
    path <- paste(Sys.getenv("USERNAME"), path, sep = ":")
      
  } else if(userID & path == ""){
  
    path <- Sys.getenv("USERNAME") 
    
  } else if(!userID & path == ""){
  
    path <- ""  
    
  }
  
  path
}