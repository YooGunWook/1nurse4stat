tabItem_graph1<-tabItem('tab_graph1',

                      fluidPage(

                        titlePanel('Ranking Fluctuation'),

                        sidebarLayout(

                          sidebarPanel(
                            textInput("singer", label = h3("Singer Input"), value = "Enter singer..."),
                            hr(),
                            fluidRow(column(12,verbatimTextOutput("singer0"),
                                            tags$head(tags$style("#singer0{overflow-y:scroll;max-height:150px;background:transparent;}")))),
                            
                            textInput("song", label = h3("Title Input"), value = "Enter title..."),
                            hr(),
                            fluidRow(column(12, verbatimTextOutput("song0"),
                                            tags$head(tags$style("#song0{overflow-y:scroll;max-height:150px;background:transparent;}")))),
                            
                            dateInput("week", label = h3("Week Select"), value = "2018-01-01"),
                            hr()
                            
                            
                          ),

                          mainPanel(
                            tabBox(width=12,
                              tabPanel('Table',
                                       DT::dataTableOutput('diffrank'),style="overflow-y:scroll;",
                                       p('These are the datas that the difference between Real and Estimated rank group is bigger than -5')),
                              tabPanel('Graph',
                            fluidRow(
                              box(width=12,
                              solidHeader=T,
                              br(),
                            plotlyOutput('plot')
                            )),
                            fluidRow(
                              box(width=12,
                                  solidHeader=T,
                                 h4(textOutput('explain_est2')),align='center')
                            ),
                            fluidRow(
                              valueBoxOutput('diffbox1'),
                              valueBoxOutput('diffbox2'),
                              valueBoxOutput('diffbox3'),
                              valueBoxOutput('diffbox4'),
                              valueBoxOutput('diffbox5'),
                              )
                            )
                          )
                        )
  )
))