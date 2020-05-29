## EDA 2

## 0) Import Data
library(tidyverse)
library(plotly)
library(GGally)
library(tidymodels)

data = read_csv("first_model_glm.csv")

summary(data)

eda_data = data %>% select(sex, song_type,active_type, season, previous_song_rank, rank_g, runtime, top_freq, gg_score, nv_score, ndc_t_numb, ndc_t_rec, ndc_t_view, 순위, 조회수)


## 1) Scaleing

### 1-1) pairplot을 그려 전체적인 개요를 보자
numeric_data = data %>% select(runtime, top_freq, gg_score, nv_score, ndc_t_numb, ndc_t_rec, ndc_t_view, 순위, 조회수, season_genre_score)

ggpairs(numeric_data)

### top_freq, gg_score, nv_score, ndc들, 순위, 조회수 변수들을 변환할 필요성이 보인다. 또한 ndc들 사이와 순위와 조회수 사이에 Correalation이 높아 통합할 필요성도 보인다.

### 1-2) Transformation

numeric_data %>% select(top_freq) %>% ggplot(aes(x = top_freq)) + geom_density()

numeric_data %>% select(top_freq) %>% transmute(log_top_freq = log(top_freq)) %>% ggplot(aes(x = log_top_freq)) + geom_density()

log_trans_top_freq = numeric_data %>% select(top_freq) %>% transmute(log_top_freq = log(top_freq))
top_freq = numeric_data%>% select(top_freq)
qqnorm(top_freq[,1])
qqnorm(log_trans_top_freq[,1])
qqline(numeric_data%>% select(top_freq), col=2)
qqline(log_trans_top_freq[,1], col = 2)

## 2) 파생변수 생성

### 2-1) 장르와 계절간에 관계가 있는지 보고싶다.

season_genre_rank = data %>% select(genre,season, rank_g)

temp = season_genre_rank %>% select(genre) %>% unique() %>% as.vector()



genre_name = c()

for(i in 1:16){
  genre_name[i] <- as.character(temp[i,])
}


genre_name = genre_name[c(-9,-16)] # 정통, 캐럴은 특정 계절에만 있으므로 빼겠다.


sge = list()
for(i in 1:14){

sge <- cbind(genre = matrix(genre_name[i], 4, 1), season_genre_rank %>% filter(genre == genre_name[i]) %>% group_by(season)%>% summarise(seasonal_mean = mean(rank_g))) %>% merge(season_genre_rank %>% group_by(genre) %>% summarise(genre_mean = mean(rank_g)), by = "genre") %>% rbind(sge)
}

sge$season = factor(sge$season, level = c("spring", "summer", "fall", "winter"), order = T)

## 동적 그래프를 그려 확인해보겠다.(값이 낮을 수록 높은 평균 순위이다.)
     
plot_ly(sge, x = ~season, y = ~ seasonal_mean, color = ~genre, type = "scatter", mode = "lines+markers")

plot_ly(sge) %>%
  add_trace(x = ~season, y = ~seasonal_mean, color = ~genre, type = "scatter", mode = "line" )

## 장르별로 계절간  추이가 있는 것을 확인하였다. 

### 2-2) 장르별 계절간 추이를 데이터에 반영하고 싶다.


season_genre_score_df = sge %>% mutate(season_genre_score = (seasonal_mean - genre_mean) / genre_mean) %>% select(genre, season, season_genre_score)

data = merge(data, season_genre_score_df, by = c("genre", "season"))
View(data)
