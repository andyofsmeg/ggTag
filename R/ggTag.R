#' Tag a ggplot2 graphic with meta information
#'
#' Tag a ggplot2 or lattice (or any grid) object with meta information by nesting it within a grid framework
#' @param object A ggplot or lattice object
#' @param useGGTitle Logical. Defaults to TRUE. Extract the title from the graph and use as plot title.
#' @param title Character.You own title.  Overridden if extractTitle is TRUE.
#' @param meta List containing meta information to include in the 4 corners of the plot: top_left, top_right, bottom_left, bottom_right
#' @param fontsize The font size in pt.
#' @param theme An optional ggplot2 theme to use.  Only applies to the current plot, i.e. the main theme is not updated.
#' @param inherit_size Logical.  If `TRUE` the value of fontsize is passed through to the selected ggplot2 theme.
#' @param raster Logical. Defaults to FALSE. Set to TRUE if input is a matrix to raster.
#' @import grid
#' @importFrom stringr str_split
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
#' ggTag(myPlot, 
#'       meta = "Protocol: 123456\nPopulation: Intent-to-Treat",
#'       metaRight = "Page 1 of 1",    
#'       date = TRUE, username = TRUE, path = FALSE)
#'       
#' # Reduce font size
#' ggTag(myPlot, 
#'       meta = list(top_left = "Protocol: 123456\nPopulation: Intent-to-Treat",
#'                       top_right = "Page 1 of 1",    
#'       bottom_left = paste(username(), path()), bottom_right = date(), fontsize = 8)
#' }
ggTag <- function(object, raster = FALSE, useGGTitle = TRUE, 
                  title, meta=list(),
                  fontsize = 12, theme = NULL, inherit_size = FALSE){

  # If theme is specified update the object
  if(!is.null(theme)){
    if(!inherit_size){
      object <- object + theme()
    }
    else{
      object <- object + theme(base_size = fontsize)
    }
  }
  
  # Redefine text to print to plot
  # Ensure appropriate title then count title lines
  if(useGGTitle) {
    theTitle <- extractGGTitle(object)
    object <- deleteGGTitle(object)
  }
  else theTitle <- title
  
  # Title and meta lines
  titleLines <- countMeta(theTitle)
  metaLinesTop <- countMetaMulti(meta$top_left, meta$top_right)
  totalLinesTop <- metaLinesTop + titleLines + 1.5
  
	# Plot
	grid.newpage()
	pushViewport(viewport(
		layout = grid.layout(nrow = 3, ncol = 3,
			heights = unit(c(totalLinesTop, 1, 3), c("lines", "null", "lines")),
			widths = unit(c(.25, 1, .25), c("inches", "null", "inches"))
		),
		gp = gpar(fontsize=fontsize)
	))
	# Top
	totalLinesTop <- totalLinesTop - 1
	pushViewport(viewport(layout.pos.row = 1, layout.pos.col = 2))
	  grid.text(meta$top_left, 
	            x = unit(0, "npc"), 
	            y = unit(totalLinesTop, "lines"), 
	            gp=gpar(fontsize=fontsize), just = c(0, 1))
	  grid.text(meta$top_right, 
	            x = unit(1, "npc"), 
	            y = unit(totalLinesTop, "lines"), 
	            gp=gpar(fontsize=fontsize), just = c(1, 1))
	  if(!is.null(theTitle))
	  grid.text(theTitle, 
	            x = unit(0.5, "npc"), 
	            y = unit(totalLinesTop-metaLinesTop, "lines"), 
	            gp=gpar(fontsize=fontsize), just = c(0.5, 1))
	popViewport()

	# Bottom
	#TODO add footnote functionality
	footLines <- 0
	metaLinesBottom <- countMetaMulti(meta$bottom_left, meta$bottom_right)
	totalLinesBottom <- metaLinesBottom + footLines + 0.5
	
	pushViewport(viewport(layout.pos.row = 3, layout.pos.col = 2))
	grid.text(meta$bottom_left, 
	          x = unit(0, "npc"), 
	          y = unit(totalLinesBottom, "lines"), 
	          gp=gpar(fontsize=fontsize), just = c(0, 0))
	grid.text(meta$bottom_right, 
	          x = unit(1, "npc"), 
	          y = unit(totalLinesBottom, "lines"), 
	          gp=gpar(fontsize=fontsize), just = c(1, 0))
	popViewport()

	# Main
	pushViewport(viewport(layout.pos.row = 2, layout.pos.col = 2))
	if(!raster){
	  print(object, newpage = F)
	}
	else{
	  grid.raster(object)
	}
	popViewport()
}





