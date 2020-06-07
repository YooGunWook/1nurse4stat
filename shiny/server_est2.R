library(tidyverse)
data = read_csv("data/first_model_glm.csv")


data$year = data %>% transmute(year = paste0(20, year)) %>% unlist() %>% as.numeric()


data$Day = data %>% select(year, month, day)%>% unite(Day , c(year, month, day), sep = "-") %>% unlist() %>% as.Date()


singer = reactive({input$singer})
output$singer0<-renderPrint({
  data %>% select(artist, name) %>% filter(artist == singer()) %>% unique() %>% print(n = 30)
})

song = reactive({input$song})
output$song0<-renderPrint({
  data %>% select(artist, name, Day ) %>% filter(artist == singer() & name == song()) %>% print(n = 100)
})  
  
week = reactive({input$week})
    
output$plot<-renderPlotly({
  singer<-isolate({input$singer})
  song<-isolate({input$song})
  week<-input$week
  temp = data %>% filter(artist ==singer & name == song & Day <= week & Day >= (as.Date(week - 7*4))) %>% select(artist, name, Day, rank_g) %>% arrange(Day)
  
  plot_ly(temp, x = ~Day, y = ~ rank_g,  type = "scatter", mode = "lines+markers") %>% layout(plot_bgcolor = 'black', title = paste0(singer, "-", song, "-", week), yaxis = list(range = c(10,0), title = "Rank Group", dtick = 1))
})
