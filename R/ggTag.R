#' Tag a ggplot2 graphic with meta information
#' 
#' Tag a ggplot2 or lattice (or any grid) object with meta information by nesting it within a grid framework
#' @param object A ggplot or lattice object
#' @param extractTitle Logical. Defaults to TRUE. Extract the title from the graph and use as plot title.
#' @param meta1 A line of meta information
#' @param meta2 A second line of meta information to appear below the first
#' @param date Logical. Defaults to TRUE. 
#' @param username Logical. Defaults to TRUE.
#' @param path Logical. Defaults to TRUE.
#' @import grid
#' @export
#' @examples{
#' library(grid)
#' library(ggplot2)
#' library(mangoTraining)
#' # Layout used:
#' grid.show.layout(
#'	grid.layout(nrow = 3, ncol = 3,
#'		heights = unit(c(4, 1, 3), c("lines", "null", "lines")),
#'		widths = unit(c(.25, 1, .25), c("inches", "null", "inches"))
#'	)
#' )
#' 
#' # Create ggplot2 graphic
#' myPlot <- qplot(Weight, Height, data = demoData, facets = Sex ~ Smokes,
#'   main = "Scatter Plot of Height against Weight\nby Sex and Smoking Status\n",
#'   xlab = "\nWeight",
#'   ylab = "Height\n"
#' )
#' myPlot <- myPlot + theme_bw() 
#' myPlot <- myPlot + 
#'   theme(strip.text.y = element_text(), 
#'         strip.background = element_rect(fill = NA, linetype = 0),
#'         panel.grid.minor = element_line(colour = NA),
#'         panel.grid.major = element_line(colour = NA)
#'   )
#' myPlot
#' 
#' 
#' ggTag(myPlot, meta1 = "Protocol: 123456", meta2 = "Study: 123456", 
#'       date = TRUE, username = TRUE, path = FALSE)
#' }
ggTag <- function(object, extractTitle = TRUE, title, meta1="", meta2="", 
                  date = TRUE, username = TRUE, path = TRUE){
  
	# Redefine text to print to plot
  if(extractTitle) {
    theTitle <- extractGGTitle(object)
    object <- deleteGGTitle(object)
  }
  else theTitle <- title
	userID <- ifelse(username, Sys.getenv("USERNAME"), "")
	projectPath <- ifelse(path, getwd(), "")
	idAndProjectPath <- paste(userID, projectPath, sep = ": ")
	theTime <- Sys.time()

	# Plot
	grid.newpage()
	pushViewport(viewport(
		layout = grid.layout(nrow = 3, ncol = 3,
			heights = unit(c(4, 1, 3), c("lines", "null", "lines")),
			widths = unit(c(.25, 1, .25), c("inches", "null", "inches"))
		)
	))
	# Top
	pushViewport(viewport(layout.pos.row = 1, layout.pos.col = 2))
	  grid.text(meta1, x = unit(0, "npc"), y = unit(3, "lines"), just = c(0, 1))
	  grid.text(meta2, x = unit(0, "npc"), y = unit(2, "lines"), just = c(0, 1))
	  if(!is.null(theTitle))
	  grid.text(theTitle, x = unit(0.5, "npc"), y = unit(1, "lines"), just = c(0.5, 1))
	popViewport()
	
	# Bottom
	pushViewport(viewport(layout.pos.row = 3, layout.pos.col = 2))
	  grid.text(idAndProjectPath, x = unit(0, "npc"), y = unit(1, "lines"), just = c(0, 0))
	  grid.text(theTime, x = unit(1, "npc"), y = unit(1, "lines"), just = c(1, 0))
	popViewport()
	
	# Main
	pushViewport(viewport(layout.pos.row = 2, layout.pos.col = 2))
	  print(object, newpage = F)
	popViewport()
}





