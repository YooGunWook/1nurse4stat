library(tidyverse)


data = read.csv("final_data.csv")

View(data)



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
data = data %>% filter(week > min(week))


write.csv(data, "final_data.csv", row.names = FALSE)
