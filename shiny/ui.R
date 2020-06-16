library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(plotly)
library(DT)
source('ui_est.R',local=TRUE) #rank estimate
source('ui_est2.R',local=TRUE) #rank fluctuation
source('ui_est1.R',local=TRUE) #datatable



dashboardPage(#skin='',
  dashboardHeader(title='1nurse4stat'),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem('Ranking Fluctuation',icon=icon('chart-line',lib='font-awesome'),tabName='tab_est2'),
      menuItem('Ranking Estimation',icon=icon('music',lib='font-awesome'),tabName='tab_est'),
      menuItem('DataTable',icon=icon('table',lib='font-awesome'),tabName='tab_est1')


            )
  ),

  dashboardBody(
    
    tabItems(
      tabItem_est2
      ,tabItem_est
      ,tabItem_est1
      )
  )
)

#콘솔창에서 shiny::runApp() 실행
