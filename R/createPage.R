#' Create page layout
#'
#' 
#'
createPage <- function(){
  
  grid.newpage()
  
  pushViewport(viewport(
    layout = grid.layout(nrow = 3, ncol = 3, 
                         heights = unit(c(2, 1, 3), c("lines", "null", "lines")),
                         widths = unit(c(.25, 1, .25), c("inches", "null", "inches"))
    ), 
    name = "page"))
  
  ## Create viewports to split top row into 2 columns
  
  pushViewport(
    viewport(layout.pos.row = 1, 
             layout.pos.col = 2,
             layout = grid.layout(ncol = 2), 
             name = "topRow")
  )
  
  pushViewport(viewport(layout.pos.row = 1, 
                        layout.pos.col = 1,
                        name = "topLeft"))
  
  seekViewport("topRow")
  
  pushViewport(viewport(layout.pos.row = 1, 
                        layout.pos.col = 2,
                        name = "topRight"))
  
  seekViewport("page")
  
  ## Create viewports to split bottom row into 2 columns
  
  pushViewport(
    viewport(layout.pos.row = 3, 
             layout.pos.col = 2,
             layout = grid.layout(ncol = 2), 
             name = "bottomRow")
  )
  
  pushViewport(viewport(layout.pos.row = 1, 
                        layout.pos.col = 1,
                        name = "bottomLeft"))
  
  seekViewport("bottomRow")
  
  pushViewport(viewport(layout.pos.row = 1, 
                        layout.pos.col = 2,
                        name = "bottomRight"))

  seekViewport("page")
  
  ## Fill with graphic
  
  pushViewport(viewport(layout.pos.row = 2, 
                        layout.pos.col = 2,
                        name = "plotRegion"))
  
  upViewport(0)

}