#' Find the x, y and justification values
#'
#' Based on the viewport that the element is being pushed into define the x, y and 
#' justification values. 
#'
#' @param topLines The number of lines of meta-data at the top of the plot
#'
position <- function(topLines = 2){
  
  p <- current.viewport()
  p <- gsub("viewport\\[(.*)\\]", "\\1", p)
  
  # Create the return object based on topLeft
  out <- list(x = unit(0, "npc"), 
              y = unit(topLines, "lines"), 
              just = c(0, 1))
  
  if(p == "topRight"){
    
    out$x <- unit(1, "npc")
    out$just[1] <- 1
    
  }else if(p == "bottomLeft"){
    
    out$y <- unit(1, "lines")
    out$just[2] <- 0
    
  }else if(p == "bottomRight"){
  
    out$x <- unit(1, "npc")
    out$y <- unit(1, "lines")
    out$just[1] <- 1
    
  }
  
  out
}