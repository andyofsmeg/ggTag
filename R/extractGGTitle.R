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
  args <- object$labels[!names(object$labels) %in% c("title", "subtitle")]
  # args <- ggplot2:::rename_aes(args)
  object <- object + structure(args, class = "labels")
  object <- object + ggplot2::labs(title = NULL, subtitle = NULL)
  object
}
