tabItem_est2<-tabItem('tab_est2',

                      fluidPage(

                        titlePanel('Ranking Fluctuation'),

                        sidebarLayout(

                          sidebarPanel(
                            textInput("singer", label = h3("Singer Input"), value = "Enter singer..."),
                            hr(),
                            fluidRow(column(12,verbatimTextOutput("singer0"))),
                            
                            textInput("song", label = h3("Title Input"), value = "Enter title..."),
                            hr(),
                            fluidRow(column(12, verbatimTextOutput("song0"))),
                            
                            dateInput("week", label = h3("Week Select"), value = "2018-01-01"),
                            
                            
                          ),

                          mainPanel(
                            tabsetPanel(
                              tabPanel('Table',
                                       DT::dataTableOutput('diffrank'),
                                       p('These are the datas that the difference between Real and Estimated rank group is bigger than -5')),
                              tabPanel('Graph',
                            fluidRow(
                              box(width=12,
                              solidHeader=F,status='primary',
                            plotlyOutput('plot')
                            )),
                            fluidRow(
                              box(width=12,
                                  solidHeader=F,status='primary',
                                 h4(textOutput('explain_est2')),align='center')
                            ),
                            fluidRow(
                              valueBoxOutput('diffbox'))
                            )
                          )
                        )
  )
))