library(tidyverse)
library(plotly)

data = read_csv("data/final_result_graph.csv")
data = data %>% select(-X1)
name = read.csv("data/paseng_final.csv")

data = data.frame(data, name = name %>% select(name))


library(lubridate)
data$week = ymd(data$week)

singer = DEAN

data %>% select(artist, name) %>% filter(artist == singer) %>% unique()

song = 'instagram'

data %>% select(artist, name, week ) %>% filter(artist == singer & name == song) %>% arrange(week)

myweek = '2018-07-01'


temp = data %>% filter(artist ==singer & name == song & week <= myweek & week >= (as.Date(myweek) - 7*4)) %>% select(artist, name, week, rank_g, rank_g_pred) %>% arrange(week)

plot_ly(temp, x = ~week, y = ~ rank_g,  type = "scatter", mode = "lines+markers", name = "실제 순위") %>% 
  layout(plot_bgcolor = 'black', title = paste0(singer, "-", song, "-", myweek), yaxis = list(range = c(10,0), title = "순위 그룹", dtick = 1)) %>%
  add_trace( x = temp$week[4:5], y = c(temp$rank_g[4],temp$rank_g_pred[5]), data = temp, name = "예측 순위", line=list(dash = "dot")) 

diff_data = data %>% mutate(diff_rank = rank_g - rank_g_pred)

diff_data %>% filter(diff_rank < -5) %>% select(artist,name,week,diff_rank)%>%View()


diff_data = data %>% mutate(diff_rank = rank_g - rank_g_pred)
temp2 = diff_data %>% filter(artist ==singer & name == song & week == (as.Date(myweek))) %>% select(artist, name, week, rank_g, rank_g_pred,diff_rank) %>% arrange(diff_rank)
temp2



h2('')
DT::dataTableOutput('diffrank')


output$diffrank<-DT::renderDatatable({
  diff_data %>% filter(diff_rank < -5) %>% select(artist,name,week,diff_rank)
})

install.packages('DT')
