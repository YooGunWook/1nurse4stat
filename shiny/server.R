library(shiny)
library(shinydashboard)

#Functions/Variables for Shiny server


shinyServer(function(input, output){

  #Functions/Variables for each session
  
  #Import Files
  source('server_est.R',local=TRUE)
  source('server_est2.R',local=TRUE)
  
  
})
