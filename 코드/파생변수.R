## EDA

library(tidyverse)

## 0. Data importing

data = read_csv("new_merge_data.csv")
summary(data)

## 1. 파생변수 만들기

### a. 이전 곡 순위
previous_song = data %>% select(artist, name) %>%
  unique() %>% group_by(artist) %>% mutate(previous_song = lag(name,1)) %>% ungroup()


data = previous_song %>% merge(data, by = c("name", "artist"))

View(data)

data = data %>% select(artist, name, previous_song, rank) %>% group_by(name) %>% mutate(top_rank = min(rank)) %>% ungroup() %>% select(-rank) %>% unique() %>% group_by(artist) %>% mutate(previous_song_rank = lag(top_rank, 1)) %>% ungroup() %>% merge(data, by = c("artist", "name", "previous_song")) %>% 
  select(-c("top_rank", "previous_song"))

### b. 계절

for(i in 1:nrow(data)) {
  data$month[i] = as.integer(data$month[i])
}



season = function(x){
  if(any(x == c("3", "4", "5"))){
    return("spring")
  }
  if(any(x == c("6", "7", "8"))){
    return("summer")
  }
  if(any(x == c("9", "10", "11"))){
    return("fall")
  }
  else{
    return("winter")
  }
}

season("5")

for(i in 1:nrow(data)){
  data$season[i] = season(data$month[i])
}

write.csv(data, "firstmodeldata.csv")
