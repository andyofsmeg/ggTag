# ggTag

> Tag ggplot2 graphics with standard meta-information

[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)
[![Travis-CI Build Status](https://travis-ci.org/andyofsmeg/ggTag.svg?branch=master)](https://travis-ci.org/andyofsmeg/ggTag)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/aimeegott/ggTag?branch=master&svg=true)](https://ci.appveyor.com/project/aimeegott/ggTag)
[![](http://www.r-pkg.org/badges/version/ggTag)](http://www.r-pkg.org/pkg/ggTag)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/ggTag)](http://www.r-pkg.org/pkg/ggTag)

## Overview

The primary `ggTag` function embeds a ggplot object within a grid framework.  The function allows a user to add titles and meta information to the outer border of a plot along with file path and date-time stamps (which are automatically added upon execution).  An existing ggplot title can be moved from the original graphic to the outer framework.

## Installation

```r
devtools::install_github("andyofsmeg/ggTag")
```

## Usage

The main package function `ggTag` can simply take a ggplot2 object and will automatically add the appropriate meta-information. Additional information can be supplied as arguments to the function.

```{r}
library(ggplot2)
library(ggTag)

library(mangoTraining)

myPlot <- qplot(Weight, Height, data = demoData, 
  facets = Sex ~ Smokes,
  main = "Scatter Plot of Height against Weight\nby Sex and Smoking Status\n",
  xlab = "Weight",
  ylab = "Height"
)

myPlot <- myPlot + theme_bw()
myPlot <- myPlot +
  theme(strip.text.y = element_text(),
        strip.background = element_rect(fill = NA, linetype = 0),
        panel.grid.minor = element_line(colour = NA),
        panel.grid.major = element_line(colour = NA)
  )
myPlot


ggTag(myPlot, 
      meta = "Protocol: 123456\nPopulation: Intent-to-Treat",
      metaRight = "Page 1 of 1",    
      date = FALSE, username = TRUE, path = TRUE)
```