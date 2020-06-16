library(shiny)
library(shinydashboard)

#Functions/Variables for Shiny server


shinyServer(function(input, output){

  #Functions/Variables for each session
  
  #Import Files
  source('server_est.R',local=TRUE)
  source('server_est2.R',local=TRUE)
  source('server_est1.R',local=TRUE)
})



#library(rsconnect)
#rsconnect::setAccountInfo(name='dw3624', token='42C691BD6682A5DB82E3FAA1A0866BA7', secret='M+VlhZdzSO6b/TCWoLZxrbkkxTWGQMby+1bc09ov')
#rsconnect::deployApp('C:/Users/user/github/1nurse4stat/shiny')
#rsconnect::showLogs()
