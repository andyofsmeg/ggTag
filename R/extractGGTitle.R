#' Extract the title from a ggplot object
#' 
#' Extract the title from a ggplot object
#' @param object A ggplot or lattice object 
#' @return Character tile or NULL if it doesn't exist
#' @export
extractGGTitle <- function(object){
  ggTitle <- object$labels$title
  ggSubtitle <- object$labels$subtitle
  if(!is.null(ggSubtitle)){
    paste(ggTitle, ggSubtitle, sep = "\n")
  }
  else{
    ggTitle
  }
}



#' Remove the title from a ggplot object
#' 
#' Remove the title from a ggplot object
#' @param object A ggplot or lattice object 
#' @return The original object, minus the title
#' @import ggplot2
#' @export
deleteGGTitle <- function(object){
  plotLabels <- object$labels
  if(!is.null(plotLabels$title)) {
    plotLabels$title <- NULL
    plotLabels$subtitle <- NULL
  }
  # Return ggplot object without titles
  object$labels <- plotLabels
  object
}
