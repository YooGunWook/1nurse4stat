library(tidyverse)
library(plotly)

data = read_csv("https://raw.githubusercontent.com/YooGunWook/1nurse4stat/master/data/model_data/%EC%B5%9C%EC%A2%85%20%EA%B2%B0%EA%B3%BC_log_Scale_%EA%B7%B8%EB%9E%98%ED%94%84.csv")
data = data %>% select(-X1)



name = read.csv("C:/Users/dhxog/dsintro/1nurse4stat/data/model_data/파생변수_최종.csv")


data = data.frame(data, name = name %>% select(name))

library(lubridate)
data$week = ymd(data$week)

singer = readline("가수명을 입력하시오 : ")

data %>% select(artist, name) %>% filter(artist == singer) %>% unique()

song = readline("곡명을 입력하시오 : ")

data %>% select(artist, name, week ) %>% filter(artist == singer & name == song) %>% arrange(week)

myweek = readline(("주차를 입력하시오 : "))


temp = data %>% filter(artist ==singer & name == song & week <= myweek & week >= (as.Date(myweek) - 7*4)) %>% select(artist, name, week, rank_g, rank_g_pred) %>% arrange(week)

plot_ly(temp, x = ~week, y = ~ rank_g,  type = "scatter", mode = "lines+markers", name = "실제 순위") %>% 
  layout(plot_bgcolor = 'black', title = paste0(singer, "-", song, "-", myweek), yaxis = list(range = c(10,0), title = "순위 그룹", dtick = 1)) %>%
  add_trace( x = temp$week[4:5], y = c(temp$rank_g[4],temp$rank_g_pred[5]), data = temp, name = "예측 순위", line=list(dash = "dot")) 

diff_data = data %>% mutate(diff_rank = rank_g - rank_g_pred)

diff_data %>% filter(diff_rank < -5) %>% View()

