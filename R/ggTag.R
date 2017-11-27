#' #' Tag a ggplot2 graphic with meta information
#'
#' Tag a ggplot2 or lattice (or any grid) object with meta information by 
#' nesting it within a grid framework
#' @param object A ggplot or lattice object
#' @param topLeft Grid object  
#' @param topRight Grid object
#' @param bottomLeft Grid object
#' @param bottomRight Grid object
#' @import grid
#' @importFrom stringr str_split
#' @examples{
#' library(mangoTraining)
#' library(ggplot2)
#' myPlot <- qplot(Weight, Height, data = demoData, facets = Sex ~ Smokes,
#'   main = "Scatter Plot of Height against Weight\nby Sex and Smoking Status\n",
#'   xlab = "\nWeight",
#'   ylab = "Height\n"
#' )
#'
#' ggTag(myPlot, 
#'   bottomLeft = addUserPath(),
#'   bottomRight = addDateTime(),
#'   topLeft = addText("Project ABC")
#'  )
#' 
#' }
#' @export
ggTag <- function(object, topLeft = NULL, topRight = NULL,
                       bottomLeft = NULL, bottomRight = NULL){
  
  createPage()
  
  downViewport("topLeft")
  topLeft
  seekViewport("topRight")
  topRight
  seekViewport("bottomLeft")
  bottomLeft
  seekViewport("bottomRight")
  bottomRight
  seekViewport("plotRegion")
  print(object, newpage = FALSE)
  upViewport(0)
  
}