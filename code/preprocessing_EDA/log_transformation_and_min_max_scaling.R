library(tidyverse)
library(tidymodels)
data = read.csv("C:/Users/dhxog/dsintro/1nurse4stat/data/model_data/파생변수_최종.csv")

summary(data)
skimr::skim(data)


data = data %>% select(artist, name, rank_g, 순위, previous_ranking, genre, season, sex, song_type, active_type, runtime, top_freq, gg_score, nv_score, 조회수, season_genre_score, pd_score, dc_total_numb, dc_mean_reccomend, dc_mean_views, view, title_song, 주차)


data = rename(data,  "you_rank" = "순위")
data = rename(data, "drama_view" = "view")
data = rename(data, "total_view" = "조회수")
data = rename(data, "week" = "주차")

data = data %>% mutate(you_rank_g=case_when(1<=you_rank&you_rank<=10~1,
                                           11<=you_rank&you_rank<=20~2,
                                           21<=you_rank&you_rank<=30~3,
                                           31<=you_rank&you_rank<=40~4,
                                           41<=you_rank&you_rank<=50~5,
                                           51<=you_rank&you_rank<=60~6,
                                           61<=you_rank&you_rank<=70~7,
                                           71<=you_rank&you_rank<=80~8,
                                           81<=you_rank&you_rank<=90~9,
                                           TRUE~10))



data = data %>% select(-you_rank)

write.csv(data, "NA_채우기_전.csv")
## Skwed data log transformation

### 1) nv_score
data%>% select(nv_score) %>% ggplot(aes(x = nv_score)) + geom_density()

data %>% select(nv_score) %>% transmute(nv_score = log(nv_score)) %>%ggplot(aes(x = nv_score)) + geom_density()


data$nv_score = data %>% select(nv_score) %>% transmute(nv_score = log(nv_score))

## 2) total_view drama_view

data%>% select(total_view) %>% ggplot(aes(x = total_view)) + geom_density()

data %>% select(total_view) %>% transmute(total_view = log(total_view)) %>%ggplot(aes(x = total_view)) + geom_density()


data$total_view = data %>% select(total_view) %>% transmute(total_view = log(total_view+1))


## 3) pd_score
data%>% select(pd_score) %>% ggplot(aes(x = pd_score)) + geom_density()

data %>% select(pd_score) %>% transmute(pd_score = log(pd_score)) %>%ggplot(aes(x = pd_score)) + geom_density()


data$pd_score = data %>% select(pd_score) %>% transmute(pd_score = log(pd_score+1))

## 4) dc_total_numb
data%>% select(dc_total_numb) %>% ggplot(aes(x = dc_total_numb)) + geom_density()

data %>% select(dc_total_numb) %>% transmute(dc_total_numb = log(dc_total_numb)) %>%ggplot(aes(x = dc_total_numb)) + geom_density()


data$dc_total_numb = data %>% select(dc_total_numb) %>% transmute(dc_total_numb = log(dc_total_numb+1))

## 5) dc_mean_reccomend

data%>% select(dc_mean_reccomend) %>% ggplot(aes(x = dc_mean_reccomend)) + geom_density()

data %>% select(dc_mean_reccomend) %>% transmute(dc_mean_reccomend = log(dc_mean_reccomend)) %>%ggplot(aes(x = dc_mean_reccomend)) + geom_density()


data$dc_total_numb = data %>% select(dc_mean_reccomend) %>% transmute(dc_mean_reccomend = log(dc_mean_reccomend+1))

## 6) dc_mean_views

data%>% select(dc_mean_views) %>% ggplot(aes(x = dc_mean_views)) + geom_density()

data %>% select(dc_mean_views) %>% transmute(dc_mean_views = log(dc_mean_views)) %>%ggplot(aes(x = dc_mean_views)) + geom_density()


data$ddc_mean_views = data %>% select(dc_mean_views) %>% transmute(dc_mean_views = log(dc_mean_views+1))

## 7) drama_view

data%>% select(drama_view) %>% ggplot(aes(x = drama_view)) + geom_density()

data %>% select(drama_view) %>% transmute(drama_view = log(drama_view)) %>%ggplot(aes(x = drama_view)) + geom_density()


data$drama_view = data %>% select(drama_view) %>% transmute(drama_view = log(drama_view+1))


## Min - Max Scaling

normalize <- function(x)
{
  return((x- min(x)) /(max(x)-min(x)))
}

numeric_data = data %>% select(runtime, top_freq, gg_score, nv_score, total_view, season_genre_score, pd_score, dc_total_numb, dc_mean_reccomend, dc_mean_views, drama_view)

cat_data = data %>% select(rank_g, you_rank_g, previous_ranking, genre, season, sex, song_type, active_type)

for(i in 1:(ncol(numeric_data))){
  numeric_data[,i] = normalize(numeric_data[,i])
}

scaled_data = data.frame(cat_data, numeric_data)

summary(scaled_data)


write_csv(scaled_data, "log_scaled_data.csv")

install.packages("data.table", 
                 repos = "https://Rdatatable.github.io/data.table", type = "source")

library(data.table)

fwrite(scaled_data, file = "log_scaled_data.csv")
