#' Add time to plot
#'
#' @param date_format Character.  R date format to use for the date.
#' 
addDateTime <- function(date_format = "%d%b%Y %H:%M"){
  
  theTime <- Sys.time()
  theTime <- toupper(format(theTime, date_format))
  
  theTime
  
} 


#' Count string lines 
#' 
#' Count string lines based on character returns
#' @param string a character vector of length 1.
count_lines <- function(string){
  length(unlist(str_split(string, "\\n")))
}

#' Count meta lines
#' 
#' Function to count the number of lines of meta information
#' 
#' @param meta Lines of meta information for a single meta data item.  The function counts lines based on character returns, \code{"\n"} and the number of elements in the vector.  
#' @return numeric. The total number of lines of meta information.
countMeta <- function(meta){
  # lines_in_each_element <- lapply(meta, count_lines)
  # sum(unlist(lines_in_each_element))
  count_lines(meta)
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
  
    path <- paste(Sys.info()["user"], path, sep = ":")
      
  } else if(userID & path == ""){
  
    path <- Sys.info()["user"]
    
  } else if(!userID & path == ""){
  
    path <- ""  
    
  }
  
  path
}
