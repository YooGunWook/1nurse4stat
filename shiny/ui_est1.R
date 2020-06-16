tabItem_est1<-tabItem('tab_est1',
                      fluidPage(
                      titlePanel('DataTable'),
                      
#                      sidebarLayout(
#                      sidebarPanel(
#                        conditionalPanel(
#                          'input.dataset === "datatab"',
#                          checkboxGroupInput('colvars','Columns in Data to show:',
#                            choices=names(datatab),selected=names(datatab)[1:10])
#                            )),
                      
                      mainPanel(
                        fluidRow(
                          id='datatab',
                          DT::dataTableOutput('mytable')
))))
#)