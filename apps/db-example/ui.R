require(rCharts)
shinyUI(pageWithSidebar(
  headerPanel("rCharts: Highcharts"),
  sidebarPanel(
    selectInput(inputId = "x",
                label = "Choose X",
                choices = c('SepalLength', 'SepalWidth', 'PetalLength', 'PetalWidth'),
                selected = "SepalLength")
  ),
  mainPanel(showOutput("myChart", "Highcharts")
  )
))