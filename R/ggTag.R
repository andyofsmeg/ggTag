#' Tag a ggplot2 graphic with meta information
#'
#' Tag a ggplot2 or lattice (or any grid) object with meta information by nesting it within a grid framework
#' @param object A ggplot or lattice object
#' @param extractTitle Logical. Defaults to FALSE. Extract the title from the graph and use as plot title.  
#' @param title Character.You own title.  Overridden if extractTitle is TRUE.
#' @param meta List containing meta information to include in the 4 corners of the plot: top_left, top_right, bottom_left, bottom_right
#' @param fontsize The font size in pt. Defaults to 12.
#' @param theme An optional ggplot2 theme to use.  Only applies to the current plot, i.e. the main theme is not updated.
#' @param inherit_size Logical.  If `TRUE` the value of fontsize is passed through to the selected ggplot2 theme.
#' @import grid
#' @importFrom stringr str_split
#' @export
#' @examples
#' library(grid)
#' library(ggplot2)
#' # Layout used:
#' grid.show.layout(
#'	grid.layout(nrow = 3, ncol = 3,
#'		heights = unit(c(4, 1, 3), c("lines", "null", "lines")),
#'		widths = unit(c(.25, 1, .25), c("inches", "null", "inches"))
#'	)
#' )
#'
#' # Create ggplot2 graphic
#' my_plot <- ggplot(data = airquality,
#'                  aes(x = Wind, y = Temp)) +
#'   geom_point() +
#'   theme_bw() +
#'   theme(strip.text.y = element_text(),
#'         strip.background = element_rect(fill = NA, linetype = 0),
#'         panel.grid.minor = element_line(colour = NA),
#'         panel.grid.major = element_line(colour = NA)
#'   )
#' my_plot
#'
#' #ggTag generic use
#' ggTag(my_plot, 
#'       meta = list(top_left = "Protocol: 123456\nPopulation: Intent-to-Treat",
#'                   top_right = "Page 1 of 1",    
#'                   bottom_left = paste(Sys.getenv("USERNAME"), getwd()), 
#'                   bottom_right = date()))
#'                   
#' # Using pharmaTag
#' pharmaTag(my_plot)
#'       
#' # Reduce font size
#' pharmaTag(my_plot,
#'           protocol = "ABC123456",
#'           population = "Intent-to-treat", 
#'           fontsize = 8)
#'                   
#' # Change theme          
#' pharmaTag(my_plot,
#'           protocol = "ABC123456",
#'           population = "Intent-to-treat", 
#'           theme = theme_grey())     
#'                   
#' # Reading in a pdf as a raster
#' library(png)
#' png_loc <- system.file(package = "ggTag", "extdata/r_logo.png")
#' a_png <- readPNG(png_loc)
#' 
#' pharmaTag(object = a_png, 
#'           protocol = "ABC123456",
#'           population = "Intent-to-treat")
ggTag <- function(object, extractTitle = FALSE, 
                  title = NULL, meta=list(),
                  fontsize = 12, theme = NULL, inherit_size = FALSE){

  if(extractTitle && !is.null(title)) {
    warning("You have provided a title but set extractTitle to TRUE. Original title will be overwritten")
  }
  
  # What type of object is it
  type <- class(object)[1]
  
  # If theme is specified update the object
  if(!is.null(theme)){
      object <- object + theme()
  }
  if(inherit_size){
    object <- object + ggplot2::theme(text = element_text(size = fontsize))
  }
  
  # Redefine text to print to plot
  # Ensure appropriate title then count title lines
  theTitle <- title
  if(extractTitle) {
    if(type == "trellis") {
      if(is.null(theTitle)){
        theTitle <- object$main
      }
      object$main <- NULL
    }
    if(type == "gg"){
      if(is.null(theTitle)){
        theTitle <- extractGGTitle(object)
      }
      object <- deleteGGTitle(object)
    }
  }
  
  
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
	if(!"array" %in% class(object)){
	  print(object, newpage = F)
	}
	else{
	  grid.raster(object)
	}
	popViewport()
}





