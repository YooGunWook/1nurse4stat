tabItem_est<-tabItem('tab_est',
                     
                     fluidPage(
                       chooseSliderSkin('Nice'),
                       #setSliderColor(rep('Green',10),c(1:10)),
                       titlePanel('Ranking Estimation'),
                       
                       column(6,
                              
                              #----------------------------variables1----------------------------
                              box(title='Variables1',solidHeader=T,status='primary',
                                  column(12,sliderInput('runtime',h4('Runtime'),min=0.00,max=1.00,value=0.50)),#runtime
                                  column(12,sliderInput('top_freq',h4('Top Frequency'),min=0.00,max=1.00,value=0.50)),#top frequency
                                  column(12,sliderInput('gg_score',h4('Google Trend Score'),min=0.00,max=1.00,value=0.50)),#google score
                                  column(12,sliderInput('nv_score',h4('Naver Trend Score'),min=0.00,max=1.00,value=0.50)),#naver score
                                  column(12,sliderInput('pd_score',h4('Production Score'),min=0.00,max=1.00,value=0.50))#production score
                                  
                              ),
                              
                              
                              #----------------------------variables2----------------------------
                              box(title='Variables2',solidHeader=T,status='primary',
                                  column(12,sliderInput('total_view',h4('Youtube Total Views'),min=0.00,max=1.00,value=0.00)),#total view
                                  column(12,sliderInput('dc_total_numb',h4('dc Total Number'),min=0.00,max=1.00,value=0.00)),#dc_total_numb
                                  column(12,sliderInput('dc_mean_reccomend',h4('dc Mean Recommend'),min=0.00,max=1.00,value=0.00)),#dc_mean_recommend
                                  column(12,sliderInput('dc_mean_views',h4('dc Mean Views'),min=0.00,max=1.00,value=0.00)),#dc_mean_views
                                  column(12,sliderInput('drama_view',h4('Drama Views'),min=0.00,max=1.00,value=0.00))#drama_view
                              )
                       ),
                       
                       
                       column(6,
                              fluidRow(
                                
                                #----------------------------variables3----------------------------
                                box(title='Variables3',width=12,solidHeader=T,status='primary',
                                    
                                    fluidRow(
                                      column(3,selectInput('genre',h3('Genre'),list('Dance','Drama','R&B/Soul','Rock','Rap/Hip-Hop','Ballad','Blues/Fork','Anime/Game','Indie','Electronica','Others','Traditional','Carol','Trot','Pop','Movie'),selected='Dance')),#genre
                                      column(3,selectInput('song_type',h3('Song Type'),list('K-POP','OST','POP','Others'),selected='K-POP')),#song type
                                      column(3,selectInput('active_type',h3('Active Type'),list('Solo','Duet','Band','Group','Project'),selected='Solo')),#activetype
                                      column(3,selectInput('sex',h3('Gender'),list('Male','Female','Mixed'),selected='Male'))#sex
                                    ),
                                    
                                    fluidRow(
                                      column(3,selectInput('season',h3('Season'),list('Spring','Summer','Fall','Winter'),selected='Spring')),#season  
                                      column(4,selectInput('you_rank_g',h3('Youtube Ranking'),list(1,2,3,4,5,6,7,8,9,10),selected=1)),#youtube ranking
                                      column(4,selectInput('previous_ranking',h3('Previous Ranking'),list(1,2,3,4,5,6,7,8,9,10),selected=1))#previous ranking
                                    )
                                )
                                
                              ),
                              
                              #----------------------------results----------------------------
                              fluidRow(
                                box(title='Result',width=12,solidHeader=T,status='primary',
                                    
                                    h3("Let's estimate the ranking of the song",align='center'),
                                    h3('Enter variables and press Estimate button below',align='center'),
                                    br(),
                                    column(12,align='center',actionButton('est','Estimate')),
                                    br(),
                                    br(),
                                    br(),
                                    h3('The estimated ranking of the song is...',align='center'),
                                    
                                    
                                )
                              ))
                       
                     )
                     
)