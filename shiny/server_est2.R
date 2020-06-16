library(tidyverse)
library(lubridate)
data = read_csv("data/final_result_graph.csv")
data = data %>% select(-X1)
name = read.csv("data/paseng_final.csv")
data = data.frame(data, name = name %>% select(name))
data$week = ymd(data$week)



singer = reactive({input$singer})
output$singer0<-renderPrint({
  data %>% select(artist, name) %>% filter(artist == singer()) %>% unique()
})


song = reactive({input$song})
output$song0<-renderPrint({
  data %>% select(artist, name, week ) %>% filter(artist == singer() & name == song()) %>% arrange(week)
})  


myweek = reactive({input$week})


output$plot<-renderPlotly({
  singer<-isolate({input$singer})
  song<-isolate({input$song})
  myweek<-input$week
  
  temp = data %>% filter(artist ==singer & name == song & week <= myweek & week >= (as.Date(myweek) - 7*4)) %>% select(artist, name, week, rank_g, rank_g_pred) %>% arrange(week)
  
  plot_ly(temp, x = ~week, y = ~ rank_g,  type = "scatter", mode = "lines+markers", name = "Real Rank") %>%  layout(plot_bgcolor = 'white', title = paste0(singer, "-", song, "-", myweek), yaxis = list(range = c(10,0), title = "Rank Group", dtick = 1)) %>%
    add_trace( x = temp$week[4:5], y = c(temp$rank_g[4],temp$rank_g_pred[5]), data = temp, name = "Rank Estimate", line=list(dash = "dot"))
})



output$diffbox<-renderValueBox({
  singer<-isolate({input$singer})
  song<-isolate({input$song})
  myweek<-input$week
  
  diff_data = data %>% mutate(diff_rank = rank_g - rank_g_pred)
  
  temp2 = diff_data %>% filter(artist ==singer & name == song & week == as.Date(myweek)) %>% select(artist, name, week, rank_g, rank_g_pred,diff_rank) %>% arrange(diff_rank)
  
  valueBox(
  
  temp2$diff_rank,
  subtitle='Estimate Difference',
  
  color=ifelse(-3<temp2$diff_rank,'green',ifelse(-7<temp2$diff_rank,'yellow','red')),
  
  icon=icon(ifelse(-3<temp2$diff_rank,'smile-wink',ifelse(-7<temp2$diff_rank,'surprise','meh-rolling-eyes')))
)
})
  
output$explain_est2<-renderText({
  'This graph shows the Ranking Group Fluctuation of selected song.'
})

output$diffrank<-DT::renderDataTable({
  diff_data = data %>% mutate(diff_rank=rank_g-rank_g_pred)
  diff_data %>% filter(-5>diff_rank)%>%select(artist,name,week,diff_rank)
})
