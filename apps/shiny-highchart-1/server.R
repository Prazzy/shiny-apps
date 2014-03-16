library(rCharts)
shinyServer(function(input, output) {
  output$myChart <- renderChart({
    h1 <- Highcharts$new()
    h1$chart(type = "spline")
    h1$series(data = c(1, 3, 2, 4, 5), dashStyle = "longdash")
    h1$series(data = c(NA, 4, 1, 3, 4), dashStyle = "shortdot")
    h1$legend(symbolWidth = 80)
    return(h1)
  })
})