d<-reactive({
  vars<-switch(input$vars,
               dc_mean_recommend=dc_mean_recommend,
               dc_mean_views=dc_mean_views,
               pd_score=pd_score,
               nv_score=nv_score,
               drama_view=drama_view,
               total_view=total_view)
  
  
  
  
  })




