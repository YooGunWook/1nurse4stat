library(tidyverse)

setwd(.\\data)
getwd()

###########
## 누락된 것 찾기
###########

tb=read_csv("data.csv") #전체데이터

glimpse(tb)

vtb = tb%>%
  group_by(artist)%>%
  summarise(total = sum(dc_t_number,dc_t_views,dc_t_recommend),
            rank=mean(rank))%>%
  filter(total==0)%>%
  arrange(artist)%>%
  select(artist)

View(vtb)

dc_tb=read_csv("dc_data.csv") #dc 데이터


vdc_tb =glimpse(dc_tb)%>%
  distinct(singer)


intersect(as.vector(vtb$artist),
          as.vector(vdc_tb$singer)
)



##################
##데이터 합치기
##################

library(lubridate)

glimpse(tb)
glimpse(dc_tb)
View(dc_tb)


# 이름 잘 바뀌는지 확인
dc_tb %>%
  mutate(artist=recode(singer,'걸그룹 여자친구'='여자친구','FT 아일랜드'='FTISLAND','NCT'='NCT 127','김청하'='청하'))%>%
  filter(singer!=artist) %>%
  distinct(artist)

# 이름 변경 dc
n_dc_tb = dc_tb %>%
  mutate(artist=recode(singer,'걸그룹 여자친구'='여자친구','FT 아일랜드'='FTISLAND','NCT'='NCT 127','김청하'='청하'))%>%
  select(-singer)

#여기서 부터는 주간으로 바꾸는 과정
fn_dc_tb = n_dc_tb %>%
  mutate(st_day=floor_date(date,unit='week')) %>% 
  group_by(artist,st_day) %>%
  summarise(ndc_t_numb = sum(total_number),
            ndc_t_rec = sum(total_reccomend),
            ndc_t_view = sum(total_views)
            ) %>%
  ungroup()

glimpse(fn_dc_tb)

f_tb_data = merge(tb,fn_dc_tb,by=c('artist','st_day'),all.x = T)

write_csv(f_tb_data,'new_merge_data.csv')


# 누락되었던 가수들
f_tb_data %>% filter(is.na(ndc_t_numb),dc_t_number ==0) %>% distinct(artist)



#dc 데이터 없는 가수가 72프로
nrow(f_tb_data %>% filter(is.na(ndc_t_numb))) / nrow(f_tb_data)
