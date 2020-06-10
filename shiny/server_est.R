library('reticulate')
use_python('C:/Users/user/Anaconda3/python')
use_condaenv('catboost')

#py_install('pandas','catboost')
#py_install('numpy','catboost')
#py_install('joblib','catboost')
#py_install('catboost','catboost')

pd = import('pandas')
np = import('numpy')
joblib = import('joblib')
catboost = import('catboost')

model = joblib$load('C:/Users/user/Desktop/cpu_version2.pkl')


arraylist<-reactive(

  c(
   input$you_rank_g
  ,input$previous_ranking
  ,input$genre
  ,input$season
  ,input$sex
  ,input$song_type
  ,input$active_type
  ,input$title_song
  ,input$runtime
  ,input$top_freq
  ,input$gg_score
  ,input$nv_score
  ,input$total_view
  ,0 #season_genre_score
  ,input$pd_score
  ,input$dc_total_numb
  ,input$dc_mean_reccomend
  ,input$dc_mean_views
  ,input$drama_view
    )
)

output$arraylist<-renderText({arraylist()})
  
output$test<-renderPrint({
  model$predict(np$array(object = arraylist()))
})
