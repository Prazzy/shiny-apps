library(shiny)
require(rCharts)
shinyUI(pageWithSidebar(
  headerPanel("rCharts: Highcharts"),
  sidebarPanel(
    selectInput(inputId = "val",
                label = "Choose X",
                choices = c(1, 2),
                selected = "2",
                multiple = FALSE),
    sliderInput("bins",
                "Number of bins:",
                min = 1,
                max = 50,
                value = 30)
  ),
  
  mainPanel(showOutput("myChart", "Highcharts"), 
            showOutput("myChart1", "Highcharts"),
            plotOutput("distPlot")
  )
))

# Define UI for application that draws a histogram
shinyUI(pageWithSidebar(
  headerPanel("rCharts: Highcharts"),
  # Sidebar with a slider input for the number of bins
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    # Show a plot of the generated distribution
    mainPanel(plotOutput("distPlot")
    )
))