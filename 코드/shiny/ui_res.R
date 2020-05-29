library(shiny)
tabItem_info<-tabItem('tab_res')

fluidPage(
  titlePanel('Results: EDA'),
  sidebarLayout(
    sidebarPanel(
      radioButtons('vars', 'Variables to Transform: ',
                   c('dc Mean Recommend'='dc_mean_recommend',
                     'dc Total'='dc_mean_views',
                     'Production Score'='pd_score',
                     'NAVER Trend Score'='nv_score',
                     'Drama Viewing Rate'='drama_view',
                     'Total View'='total_view'
                     ))),

    mainPanel(
      fluidRow(
        column(6,
               plotOutput('plot1')),
        column(6,
               plotOutput('plot2'))
        )
      )
    )
  )