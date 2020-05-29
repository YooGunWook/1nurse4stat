library(readr)
library(dplyr)
library(lubridate)

###########
## dc 전처리
###########


setwd('.\\data\\dc_raw_data')
dir = getwd()
file_list = list.files(dir)

tb =tibble()

for (i in file_list) {
  print(i)
  temp = read_csv(paste(dir,'\\',i,sep=""))
  tb = rbind(tb,temp)
}

glimpse(tb)

write_csv(tb,"../dc_raw_data.csv")


n_tb = tb %>%
  filter(number!="공지") %>%  # 번호에 공지 지우기
  mutate(date=as.Date(date),number=as.numeric(number)) %>%  # 데이터 유형 알맞게 하기
  mutate(st_day=floor_date(date,unit='week')) %>%   # 몇주인지 변수만들기
  group_by(singer,st_day)%>%  #  그룹별 요약통계량 생성
  summarize(
    dc_total_numb = max(number)-min(number)+1,
    dc_mean_reccomend = mean(recommend),
    dc_mean_views = mean(views)
          ) %>%
  ungroup() %>%
  mutate(  # 가수 이름 변경
    artist=recode(singer,
                  '걸그룹 여자친구'='여자친구',
                  'FT 아일랜드'='FTISLAND',
                  'NCT'='NCT 127',
                  '김청하'='청하')
    ) %>%
  select(-singer)  # 중복 칼럼 삭제


glimpse(n_tb)
View(n_tb)


write_csv(n_tb,"../dc_data_0521.csv")




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
total_tb=read_csv("../data.csv") #전체데이터


glimpse(n_tb)

f_tb_data = merge(total_tb,n_tb,by=c('artist','st_day'),all.x = T)

write_csv(f_tb_data,'../new_merge_data.csv')



# 누락되었던 가수들
f_tb_data %>% filter(is.na(ndc_t_numb),dc_t_number ==0) %>% distinct(artist)


#dc 데이터 없는 가수가 72프로
nrow(f_tb_data %>% filter(is.na(ndc_t_numb))) / nrow(f_tb_data)
