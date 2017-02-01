#' Extract the title from a ggplot object
#' 
#' Extract the title from a ggplot object
#' @param object A ggplot or lattice object 
#' @return Character tile or NULL if it doesn't exist
#' @export
extractGGTitle <- function(object){
  ggTitle <- object$labels$title
  ggTitle
}



#' Remove the title from a ggplot object
#' 
#' Remove the title from a ggplot object
#' @param object A ggplot or lattice object 
#' @return The original object, minus the title
#' @export
deleteGGTitle <- function(object){
  object$labels$title <- NULL
  object
}
