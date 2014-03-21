library(rCharts)
h1 <- hPlot(Pulse ~ Height, data = MASS::survey, type = "scatter", group = "Exer")
h1$set(tooltip = list(formatter = 
                        "#! function(){
  return '<b>X</b>:' + this.x + '<br/>' + 
    '<b>Y</b>:' + this.y
  } !#"
))
h1