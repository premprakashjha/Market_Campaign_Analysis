library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Marketing Campaign Analysis"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("ageRange", "Select Age Range:", min = 20, max = 80, value = c(30, 50))
    ),
    mainPanel(
      plotOutput("agePlot"),
      tableOutput("summaryTable")
    )
  )
)

server <- function(input, output) {
  data <- read.csv("C:/Users/Mohit Kumar/Downloads/marketing_campaign.csv", sep = ";")
  data$Age <- 2024 - data$Year_Birth
  
  output$agePlot <- renderPlot({
    ggplot(data[data$Age >= input$ageRange[1] & data$Age <= input$ageRange[2], ], 
           aes(x = Age)) + 
      geom_histogram(bins = 20, fill = "blue", color = "white")
  })
  
  output$summaryTable <- renderTable({
    summary(data)
  })
}

shinyApp(ui = ui, server = server)
