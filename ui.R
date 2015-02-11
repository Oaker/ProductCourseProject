library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Explore simulation of Exponential and Poison Distribution!"),
  sidebarPanel(
    a(href="http://rpubs.com/oaker/59104", "HELP! (DOCUMENTATION)"),
    h3('Input parameters'),
    sliderInput('lambda', 'Lambda:', 0.1, min = 0.1, max = 5, step = 0.1),
    numericInput('n', 'Number of experiment:', 1000, min = 100, max = 10000, step = 100),
    numericInput('len', 'Length of sample:', 10, min = 1, max = 100, step = 1),
    selectInput("distrib", "Distribution:", 
                choices = c("Exponential", "Poison")),
    submitButton('Explore')
    
  ),
  mainPanel(
    h3('Explore Panel'),
    h4('Theoretical mean'),
    verbatimTextOutput("tmean"),
    h4('Theoretical var'),
    verbatimTextOutput("tvar"),
    h4('Sample mean'),
    verbatimTextOutput("smean"),
    h4('Sample variation'),
    verbatimTextOutput("svar"),
    
    
    plotOutput('pl')
  )
))