library(shiny)
library(shinydashboard)
source('ui_info.R',local=TRUE)
source('ui_mv.R',local=TRUE)
source('ui_mcraw.R',local=TRUE)
source('ui_mstat.R',local=TRUE)
source('ui_res.R',local=TRUE)
#source('ui_feat.R',local=TRUE)
#source('ui_cat.R',local=TRUE)
#source('ui_xg.R',local=TRUE)
#source('ui_logi.R',local=TRUE)
#source('ui_forest.R',local=TRUE)


dashboardPage(
  dashboardHeader(title='1nurse4stat'),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Information',icon=icon('info'),tabName='tab_info'),
      menuItem('Method',
               menuSubItem('Variable',tabName='tab_mv'),
               menuSubItem('Data Crawling',tabName='tab_mcraw'),
               menuSubItem('Statistical Method',tabName='tab_mstat'))#,
#      menuItem('Results-EDA',tabName='tab_res')
#      menuItem('Results-Models',icon=icon('line-chart'),
#               menuSubItem('Feature Importance',tabName='tab_feat'),
#               menuSubItem('Cat Boost',tabName='tab_cat'),
#               menuSubItem('Xg Boost',tabName='tab_xg'),
#               menuSubItem('Logistic Regression',tabName='tab_logi'),
#               menuSubItem('Random Forest',tabName='tab_forest'))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem_info,
      
      tabItem_mv,
      tabItem_mcraw,
      tabItem_mstat#,
      
#      tabItem_res
#      tabItem_feat,
#      tabItem_cat,
#      tabItem_xg,
#      tabItem_logi,
#      tabItem_forest
    )
  )
)


#shiny::runApp()
