tabItem_est<-tabItem('tab_est',
fluidPage(

  
titlePanel('Ranking Estimation'),
  

#----leftside----
column(6,

#----variable1----
         column(6,
               selectInput('you_rank_g','Youtube Ranking',list(1,2,3,4,5,6,7,8,9,10),selected=1),
                selectInput('previous_ranking','Previous Ranking',list(1,2,3,4,5,6,7,8,9,10),selected=1),
               selectInput('genre','Genre',list('Dance','Drama','R&B/Soul','Rock','Rap/Hiphop','Ballad','Blues/Folk','Ani/Game','Indi','Electronica','All','Jazz','carol','Trot','Pop','Foreign Movie'),selected='Dance'),
                selectInput('season','Season',list('spring','summer','fall','winter'),selected='spring'),
                selectInput('sex','Gender',list('Male'='male','Female'='female','Mixed'='mixed'),selected='Male'),
                selectInput('song_type','Song Type',list('K_POP','OST','POP','Others'),selected='K-POP'),
                selectInput('active_type','Active Type',list('Solo','Duet','Band','Group','Project'),selected='Solo'),
                selectInput('title_song','Title Song',list('Yes'=1,'No'='0'),selected='Yes'),
                numericInput('runtime','Runtime',0.5,min=0,max=1,step=0.01)
                ),

#----variable2----
         column(6,
                numericInput('top_freq','Top Frequency',0.5,min=0,max=1,step=0.01),
                numericInput('gg_score','Google Trend Score',0.5,min=0,max=1,step=0.01),
                numericInput('nv_score','Naver Trend Score',0.5,min=0,max=1,step=0.01),
                numericInput('total_view','Youtube Total Views',0,min=0,max=1,step=0.01),
                numericInput('pd_score','Production Score',0.5,min=0,max=1,step=0.01),
                numericInput('dc_total_numb','dc Total Number',0,min=0,max=1,step=0.01),
                numericInput('dc_mean_reccomend','dc Mean Recommend',0,min=0,max=1,step=0.01),
                numericInput('dc_mean_views','dc Mean Views',0,min=0,max=1,step=0.01),
                numericInput('drama_view','Drama Views',0,min=0,max=1,step=0.01)

                )
         ),


#----rightside----
column(6,
      fluidRow(
#----result----
         box(title='Result',width=12,solidHeader=T,status='primary',
             h3('The estimated ranking group of the song is...',align='center'),
             h3(textOutput('rankpredict'),align='center'),
             br(),
             h3(textOutput('test'),align='center'),
             br(),
             h4('You have selected...'),
             verbatimTextOutput('arraylist')
         )
         )
       )
)


)
