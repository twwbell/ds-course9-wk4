#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
data("mtcars")
mtcars$vs <- factor(mtcars$vs)
mtcars$am <- factor(mtcars$am,labels=c("Automatic","Manual"))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # independent variable
  output$independent <- renderUI({
    selectInput("independent", p("Select independent variable"), 
                choices = names(mtcars)[!names(mtcars) %in% input$dependent])
  })
  
  # covariates
  output$covariates <- renderUI({
    selectInput("covariates", p("Select covariates (optional)"), 
                choices = names(mtcars)[!names(mtcars) %in% 
                                          c(input$dependent, input$independent)],
                multiple = TRUE)
  })
  
  # model formula
  regressionFormula <- reactive({
    as.formula(paste0(input$dependent, "~", input$independent,
                      ifelse(is.null(input$covariates),"","+"), 
                      paste(input$covariates, collapse = "+ ")))
  })
  
  # fit model
  model <- reactive({
    lm(regressionFormula(), data = mtcars)
  })
  
  
  output$model <- renderPrint({
    print(regressionFormula())
    print(input$dependent)
    print(input$independent)
    summary(model())
  })
  
  output$plotResiduals <- renderPlot({
    plot(model(),1)
  })
  
  output$plotQq <- renderPlot({
    plot(model(),2)
  })
  
})
