library(tidyverse)


data = read_csv("https://raw.githubusercontent.com/YooGunWook/1nurse4stat/master/data/model_data/%EC%B5%9C%EC%A2%85%20%EA%B2%B0%EA%B3%BC_log_Scale_%EA%B7%B8%EB%9E%98%ED%94%84.csv")
data = data %>% select(-X1)



name = read.csv("C:/Users/dhxog/dsintro/1nurse4stat/data/model_data/파생변수_최종.csv")


data = data.frame(data, name = name %>% select(name))

library(lubridate)
data$week = ymd(data$week)

data = data %>% filter(title_song == 1) %>% group_by(artist, name) %>% arrange(week) %>%
  mutate(top_rank = min(rank_g)) %>% select(artist, name, top_rank) %>% unique() %>%
  ungroup() %>% group_by(artist) %>% mutate(previous_top = lag(top_rank, 1)) %>%
  ungroup() %>%
  select(artist, name, previous_top) %>% right_join(data, by = c("artist", "name"))

data = data %>% group_by(artist, name) %>% arrange(week) %>% mutate(last_week_rank = lag(rank_g,1))

data = data %>% 
  group_by(artist, name) %>%
  mutate(previous_ranking = ifelse(week == min(week), previous_top, last_week_rank)) %>% ungroup()

data = data %>% select(-c(previous_top, last_week_rank))
data = data %>% select(-rank_g_pred)


data$previous_ranking[is.na(data$previous_ranking) == T] = 10
write.csv(data, "final_data.csv", row.names = FALSE)