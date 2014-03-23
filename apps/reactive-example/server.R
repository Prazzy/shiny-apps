library(shiny)
library(rCharts)
library(DBI)
library(RMySQL)

newval <- function(n) {
  drv = dbDriver('MySQL')
  con = dbConnect(drv, dbname='mydb',user='dbuser',pass='dbuser')
  res = dbGetQuery(con, statement="select * from polls_choice where poll_id=1")
  choice <- c(res['choice_text'])
  votes <- c(res['votes'])
  dbDisconnect(con)
}

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]  # Old Faithful Geyser data
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  
  drv = dbDriver('MySQL')
  # Bar chart
  myval <- reactive({ input$val })
  shiny:::flushReact()
  observe({
      query <- "select * from polls_choice where poll_id=%s"
      query <- sprintf(query, myval())
      print(query)
      con = dbConnect(drv, dbname='mydb',user='dbuser',pass='dbuser')
      res = dbGetQuery(con, statement=query)
      v1 <- c(res['votes'])
      print(v1)
      dbDisconnect(con)
    
      output$myChart1 <- renderChart2({
        h1 <- Highcharts$new()
        h1$chart(type = "column")
        h1$series(data = c(res['votes'])$votes, name="Browser Share1")
        h1$legend(symbolWidth = 80)
        h1$plotOptions(column = list(cursor = 'pointer', point = list(events = '')))
        return(h1)
    })  
  })
  
  # Pie chart
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
