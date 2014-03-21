library(shiny)
library(rCharts)
library(DBI)
library(RMySQL)

shinyServer(function(input, output) {
  drv = dbDriver('MySQL')
  con = dbConnect(drv, dbname='mydb',user='dbuser',pass='dbuser')
  res = dbGetQuery(con, statement="select * from polls_choice")
  choice <- c(res['choice_text'])
  votes <- c(res['votes'])
  dbDisconnect(con)
  output$myChart <- renderChart2({
    #h1 <- Highcharts$new()
    #h1$chart(type = "column")
    #h1$series(data = vals$votes, name="Browser Share")
    #h1$legend(symbolWidth = 80)
    #return(h1)
    x <- data.frame(key = choice$choice_text, value = votes$votes)
    h2 <- hPlot(x = "key", y = "value", data = x, type = "pie")
    #h2 <- Highcharts$new()
    #h2$chart(type = "pie")
    #h2$series(data = c(x)$value, name="Browser Share")
    h2$title(text = "Browser market shares at a specific website, 2010")
    h2$tooltip(pointFormat = '<b>{point.percentage:.1f}%</b>')
    h2$plotOptions(pie=list(
        allowPointSelect = TRUE,
        cursor = 'pointer',
        dataLabels =  list(
          enabled = TRUE,
          color = '#000000',
          connectorColor = '#000000',
          format=  '<b>{point.name}</b>: {point.percentage:.1f} %'
        )
    )
    )
    return(h2)
  })
})
