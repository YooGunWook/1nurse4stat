library(shiny)
library(shinydashboard)

#Functions/Variables for Shiny server


shinyServer(function(input, output){

  #Functions/Variables for each session
  
  #Import Files
  source('server_info.R',local=TRUE)
  
  source('server_mv.R',local=TRUE)
  source('server_mcraw.R',local=TRUE)
  source('server_mstat.R',local=TRUE)
  
  
  
})
