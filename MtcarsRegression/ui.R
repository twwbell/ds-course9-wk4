#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Fit a prediction model on the mtcars dataset"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("dependent",p("Select dependent variable:"), 
                   choices = names(mtcars)),
      
      uiOutput("independent"),
      uiOutput("covariates")),
    
    # Show the chosen model
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Model",
                           verbatimTextOutput("model")
                           ),
                  tabPanel("Plots",
                           plotOutput("plotResiduals"),
                           plotOutput("plotQq")
                           ),
                  tabPanel("Documentation",
                           includeHTML("documentation.html")
                  )
      )
))))
