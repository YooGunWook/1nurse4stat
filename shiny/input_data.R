library(tidyverse)
library(plotly)

data = read_csv("first_model_glm.csv")

data$year = data %>% transmute(year = paste0(20, year)) %>% unlist() %>% as.numeric()


data$주차 = data %>% select(year, month, day)%>% unite(주차 , c(year, month, day), sep = "-") %>% unlist() %>% as.Date()


singer = readline("가수명을 입력하시오 : ")

data %>% select(artist, name) %>% filter(artist == singer) %>% unique() %>% print(n = 30)

song = readline("곡명을 입력하시오 : ")

data %>% select(artist, name, 주차 ) %>% filter(artist == singer & name == song) %>% print(n = 100)

week = readline(("주차를 입력하시오 : "))


temp = data %>% filter(artist ==singer & name == song & 주차 <= week & 주차 >= (as.Date(week) - 7*4)) %>% select(artist, name, 주차, rank_g) %>% arrange(주차)

plot_ly(temp, x = ~주차, y = ~ rank_g,  type = "scatter", mode = "lines+markers") %>% layout(plot_bgcolor = 'black', title = paste0(singer, "-", song, "-", week), yaxis = list(range = c(10,0), title = "순위 그룹", dtick = 1))
