library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(plotly)
source('ui_est.R',local=TRUE) #rank estimate
source('ui_est2.R',local=TRUE) #rank fluctuation

dashboardPage(#skin='green',
  dashboardHeader(title='1nurse4stat'),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem('Ranking Estimation',icon=icon('info'),tabName='tab_est'),
      menuItem('Ranking Fluctuation',tabName='tab_est2')
      )
  ),

  dashboardBody(
#    tags$style(HTML("
#.box.box-solid.box-primary>.box-header{color:#fff#;background:#666666}
#
#.box.box-solid.box-primary{
#border-bottom-color:#666666;
#border-left-color:#666666;
#border-right-color:#666666;
#border-top-color:#666666;
#}")),
    
    
    tabItems(
      tabItem_est,
      tabItem_est2
      )
  )
)

#콘솔창에서 shiny::runApp() 실행
