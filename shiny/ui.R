library(shiny)
library(shinydashboard)
library(devtools)
library(plotly)
library(DT)
library(devtools)
library(htmltools)
library(dashboardthemes)
source('ui_rankest.R',local=TRUE) #rank estimate
source('ui_graph1.R',local=TRUE) #rank fluctuation
source('ui_data.R',local=TRUE) #datatable



dashboardPage(
  dashboardHeader(title='1nurse4stat'),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem('Ranking Fluctuation',icon=icon('chart-line',lib='font-awesome'),tabName='tab_graph1'),
      menuItem('Ranking Estimation',icon=icon('music',lib='font-awesome'),tabName='tab_rankest'),
      menuItem('DataTable',icon=icon('table',lib='font-awesome'),tabName='tab_data')


            )
  ),

  dashboardBody(
                    
    shinyDashboardThemes(
      theme='boe_website'),
    
    tabItems(
      tabItem_graph1
      ,tabItem_rankest
      ,tabItem_data
      )
  )
)

#콘솔창에서 shiny::runApp() 실행
