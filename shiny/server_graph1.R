library(tidyverse)
library(lubridate)
#library(knitr)
data = read_csv("data/finalresult_graph_final_5.csv")
data = data %>% select(-X1)
data$week = ymd(data$week)


singer = reactive({input$singer})
output$singer0<-renderPrint({
  data %>% select(artist, name) %>% filter(artist == singer()) %>% unique() %>% print(n=99)
})


song = reactive({input$song})
output$song0<-renderPrint({
  data %>% select(artist, name, week ) %>% filter(artist == singer() & name == song()) %>% arrange(week) %>% print(n=99)
})  


myweek = reactive({input$week})


output$plot<-renderPlotly({
  singer<-isolate({input$singer})
  song<-isolate({input$song})
  myweek<-input$week
  
  temp = data %>% filter(artist ==singer & name == song & week <= myweek & week >= (as.Date(myweek) - 7*4)) %>% select(artist, name, week, rank, rank_g_pred) %>% arrange(week)
  
  plot_ly(temp, x = ~week, y = ~ rank,  type = "scatter", mode = "lines+markers", name = "Real Rank") %>%  layout(yaxis=list(autorange='reversed'),plot_bgcolor = 'white', title = paste0(singer, "-", song, "-", myweek), title = "Rank Group", dtick = 1) %>%
    add_trace( x = ~week, y = ~rank_g_pred, data = temp, name = "Rank Estimate", line=list(dash = "dot"))
})



vcolor=function(x){
  ifelse(20>abs(x),'green',ifelse(70>abs(x),'yellow','red'))
}
vicon=function(x){
  icon(ifelse(20>abs(temp2$diff_rank),'smile-wink',ifelse(70>abs(temp2$diff_rank),'surprise','meh-rolling-eyes')))
}




output$diffbox1<-renderValueBox({
  singer<-isolate({input$singer})
  song<-isolate({input$song})
  myweek<-input$week  
  
  v1 = data %>% mutate(diff_rank = round(rank - rank_g_pred)) %>% filter(artist ==singer & name == song & week == (as.Date(myweek)-7*4)) %>% select(artist, name, week, rank, rank_g_pred,diff_rank) %>% arrange(diff_rank)
  
  valueBox(
    -round(v1$diff_rank),
    subtitle='1st Week',
    color=ifelse(20>abs(v1$diff_rank),'green',ifelse(70>abs(v1$diff_rank),'yellow','red')),
    icon=icon(ifelse(20>abs(v1$diff_rank),'smile-wink',ifelse(70>abs(v1$diff_rank),'surprise','meh-rolling-eyes')))
    )
})

output$diffbox2<-renderValueBox({
  singer<-isolate({input$singer})
  song<-isolate({input$song})
  myweek<-input$week
  
  v2 = data %>% mutate(diff_rank = round(rank - rank_g_pred)) %>% filter(artist ==singer & name == song & week == (as.Date(myweek)-7*3)) %>% select(artist, name, week, rank, rank_g_pred,diff_rank) %>% arrange(diff_rank)
  
  valueBox(
    -round(v2$diff_rank),
    subtitle='2nd Week',
    color=ifelse(20>abs(v2$diff_rank),'green',ifelse(70>abs(v2$diff_rank),'yellow','red')),
    icon=icon(ifelse(20>abs(v2$diff_rank),'smile-wink',ifelse(70>abs(v2$diff_rank),'surprise','meh-rolling-eyes'))) 
    )
})

output$diffbox3<-renderValueBox({
  singer<-isolate({input$singer})
  song<-isolate({input$song})
  myweek<-input$week
  
  v3 = data %>% mutate(diff_rank = round(rank - rank_g_pred)) %>% filter(artist ==singer & name == song & week == (as.Date(myweek)-7*2)) %>% select(artist, name, week, rank, rank_g_pred,diff_rank) %>% arrange(diff_rank)
  
  valueBox(
    -round(v3$diff_rank),
    subtitle='3rd Week',
    color=ifelse(20>abs(v3$diff_rank),'green',ifelse(70>abs(v3$diff_rank),'yellow','red')),
    icon=icon(ifelse(20>abs(v3$diff_rank),'smile-wink',ifelse(70>abs(v3$diff_rank),'surprise','meh-rolling-eyes')))
    )
})

output$diffbox4<-renderValueBox({
  singer<-isolate({input$singer})
  song<-isolate({input$song})
  myweek<-input$week
  
  v4 = data %>% mutate(diff_rank = round(rank - rank_g_pred)) %>% filter(artist ==singer & name == song & week == (as.Date(myweek)-7*1)) %>% select(artist, name, week, rank, rank_g_pred,diff_rank) %>% arrange(diff_rank)
  
  valueBox(
    -round(v4$diff_rank),
    subtitle='4th Week',
    color=ifelse(20>abs(v4$diff_rank),'green',ifelse(70>abs(v4$diff_rank),'yellow','red')),
    icon=icon(ifelse(20>abs(v4$diff_rank),'smile-wink',ifelse(70>abs(v4$diff_rank),'surprise','meh-rolling-eyes')))
  )
})

output$diffbox5<-renderValueBox({
  singer<-isolate({input$singer})
  song<-isolate({input$song})
  myweek<-input$week
  
  v5 = data %>% mutate(diff_rank = round(rank - rank_g_pred)) %>% filter(artist ==singer & name == song & week == (as.Date(myweek)-0)) %>% select(artist, name, week, rank, rank_g_pred,diff_rank) %>% arrange(diff_rank)
  
  valueBox(
    -round(v5$diff_rank),
    subtitle='5th Week',
    color=ifelse(20>abs(v5$diff_rank),'green',ifelse(70>abs(v5$diff_rank),'yellow','red')),
    icon=icon(ifelse(20>abs(v5$diff_rank),'smile-wink',ifelse(70>abs(v5$diff_rank),'surprise','meh-rolling-eyes')))
  )
})


output$explain_est2<-renderText({
  'This graph shows the Real Rank Fluctuation and Estimated Rank of selected song.'
})

output$diffrank<-DT::renderDataTable({
  diff_data = data %>% mutate(diff_rank=round(rank-rank_g_pred))
  diff_data %>% select(artist,name,week,diff_rank)
})
