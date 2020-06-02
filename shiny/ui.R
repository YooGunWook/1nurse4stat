library(shiny)
library(shinydashboard)
source('ui_est.R',local=TRUE) #rank estimate




dashboardPage(
  dashboardHeader(title='1nurse4stat'),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem('Ranking Estimation',icon=icon('info'),tabName='tab_est')
      )
  ),

  dashboardBody(
    tabItems(
      tabItem_est
      )
  )
)

#콘솔창에 shiny::runApp()입력
