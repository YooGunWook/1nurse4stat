# library -----------------------------------------------------------------
library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(forcats)
library(car)
library(ggplot2)


# GAON & JINI by yoogunwook -----------------------------------------------
### data import ###
data<-read_csv("~/Desktop/dsproject/data/최종.csv")

data$X1<-data$X1+1 # 0부터 시작되서 1더하기 
names(data)[1]<-"id" #기본의 id만드
names(data)

#data의 song의 id 만들기
table(duplicated(data[,c("name","artist")]))  

only1<-data[which(!duplicated(data[,c("name","artist")])),] #duplicated_none
only1$song_id<-"song_id"
only1$song_id<-c(1:1447)

only1<-subset(only1,select=c("name","artist","song_id"))
data<-left_join(data,only1,by=c("name","artist"))

### rank ###
data$rank_g<-ifelse(data$rank==c(1:10),1,
                    ifelse(data$rank==c(11:20),2,
                           ifelse(data$rank==c(21:30),3,
                                  ifelse(data$rank==c(31:40),4,
                                         ifelse(data$rank==c(41:50),5,
                                                ifelse(data$rank==c(51:60),6,
                                                       ifelse(data$rank==c(61:70),7,
                                                              ifelse(data$rank==c(71:80),8,
                                                                     ifelse(data$rank==c(81:90),9,10)))))))))





### change to weeks variable ###
data<-data %>% separate(time,c("st_day","ed_day"),"~") 

data$st_day<-ymd(data$st_day)
data$ed_day<-ymd(data$ed_day)

data<- data %>% group_by(year(st_day)) %>% group_by(month(st_day)) %>% group_by(day(st_day))
names(data)
names(data)[17]<-"year"
names(data)[18]<-"month"
names(data)[19]<-"day"
data$year<-substr(data$year,3,4)
data$month<-ifelse(str_count(data$month)==1,paste0(0,data$month),data$month)

data$wks<-week(data$st_day)#그해에 몇째주 인ᄌ?
data$week<-paste0(data$year,"_",data$wks) #In what weeks of the month?

### sex ###
data$sex<- fct_recode(data$성별,male="남성",female="여성",mixed="혼성")

### production ### 정리안
dim(addmargins(table(data$production)))

### distributor ### 정리안함
dim(addmargins(table(data$distributor)))

### genre ###
table(data$장르)
A<-str_split_fixed(data$장르,"/ ",n=2)
A<-data.frame(A)
names(A)[1]<-"song_type"
names(A)[2]<-"genre"
data<-bind_cols(data,A)

mode(data$song_type)
table(data$song_type)

data$song_type<-fct_recode(data$song_type,K_POP="가요 ",POP="POP ",POP="J-POP ",OST="OST ",Others="그외장르 ",Others="재 ") 
data$song_type<-fct_relevel(data$song_type,c("K_POP","POP","OST","Others"))
addmargins(table(data$song_type))

addmargins(table(data$genre))


data$genre<-recode(data$genre,"'댄스'='Dance_etc';'락'='Dance_etc';'랩/힙ᄒ'='Dance_etc';'일렉트로니카'='Dance_etc';'캐롤'='Dance_etc';'트로트'='Dance_etc';
                              '발라드'='Balad_etc';'블루스/포크'='Balad_etc';'R&B/'='Balad_etc';'인디'='Balad_etc';'정통'='Balad_etc';
                              '드라마'='Others';'애니메이션/게임'='Others';'팝'='Others';'해외영화'='Others';'전체'='Others'")

str(data)

### runtime ###
data$runtime<-data$런타임
data$runtime<-substr(data$runtime,1,5)
data$runtime<-as.numeric(substr(data$runtime,1,2))*60+as.numeric(substr(data$runtime,4,5))

summary(data$runtime)
data$runtime_g<-as.factor(ifelse(data$runtime<201,"Short",
                          ifelse(data$runtime>=242,"Long","Middle")))


### active_type ###
data$active<-factor(data$활동유형,levels=c("솔로","그룹","","프로젝트","듀엣"),
                         labels=c("Solo","Group","Band","Project","Duet"))
table(data$active)

data$active_g<-as.factor(ifelse(data$active=="Solo","Solo","Non_solo"))

### 100위안에 6개 몇주동안 진입? ###
data$song_id<-factor(data$song_id)
a<-table(data$song_id)
A<-data.frame(a)
names(A)[1]<-"song_id"
names(A)[2]<-"top_freq"

ggplot(A,aes(x=top_freq))+
  geom_histogram(fill="#F8766D",color="black",binwidth = 1)

summary(A$top_freq)

A$top_freq_g<-factor(ifelse(A$top_freq<4,"Low",
                      ifelse(A$top_freq>=14,"High","Middle")))
A$top_freq_g<-fct_relevel(A$top_freq_g,"High","Middle","Low")

data<-left_join(data,A,by="song_id")

basic<-data
save(basic, file="basic.RData")


# DC 갤러리 by 청파 ------------------------------------------------------------
dc<-read_csv("~/Desktop/dsproject/data/dc.csv")
names(dc)[1]<-"artist"
a<-unique(dc$artist)
b<-unique(basic$artist)

c<-match(a,b)
c<-data.frame(c)
c$artist<-unique(dc$artist)

### 가수 이름 basic으로 변경하기 ###
#dc 데이터에서; FTISLAND로 변경, 걸그룹 여ᄌ 여자친구로 변경,NCT는 NCT DREAM, NCT 127로 각각 변경하여 추가,김청하는 청하로 
dc$artist2<-recode(dc$artist,"'FT 아ᄋ'='FTISLAND';'걸그룹 여자친구'='여자친구';'NCT'='NCT DREAM';'김청하'='청하'")
dc_nct<-filter(dc,artist=="NCT")
dc_nct$artist2<-"NCT 127"

dc<-bind_rows(dc,dc_nct)
dc$artist<-NULL
names(dc)[7]<-"artist"

### dc 날짜 처리 ###
dc$date<-ymd(dc$date)
dc<-dc %>% filter(date>="2018-04-22"&date<="2020-04-19") #basic 날짜랑 맞추기

dc$year<-year(dc$date)
dc$year<-substr(dc$year,3,4)
dc$wks<-week(dc$date)#2019년도 몇째주 인지?
dc$week<-paste0(dc$year,"_",dc$wks)

### total_number====
t_num<-dc %>% select(week,artist,total_number) 
t_num<-aggregate(t_num$total_number,by=list(t_num$week,t_num$artist),FUN=sum) #week별, artist별 점수 sum
names(t_num)<-c("week","artist","dc_t_number")
data<-t_num
#merge in basic and dc_t_number
basic2<-left_join(basic,data,by=c("week","artist")) #기본+네이버

dim(table(which(is.na(basic2$dc_t_number))))

#dc_t_number없는것을 none파일로 만들어 
none<-basic2[is.na(basic2$dc_t_number),]

none<-subset(none,select=c("id","week","artist"))

none$artist2<-gsub('&',',',none$artist)
artist3<-str_split_fixed(none$artist2, ",", 6)
artist3<-data.frame(artist3)

artist3$X1<-str_trim(artist3$X1,side="both")
artist3$X2<-str_trim(artist3$X2,side="both")
artist3$X3<-str_trim(artist3$X3,side="both")
artist3$X4<-str_trim(artist3$X4,side="both")
artist3$X5<-str_trim(artist3$X5,side="both")
artist3$X6<-str_trim(artist3$X6,side="both")

none<-bind_cols(none,artist3)

none2<-none %>% gather(X1:X6,key="x",value="artist") %>% select(id,week,artist) 

#data와 none을 머지
none3<-left_join(data,none2,by=c("artist","week"))
none3<-merge(none2,data,by=c("artist","week"),all = TRUE)
none3<-none3[is.na(none3$dc_t_number)==FALSE,] #dc_t_number 없는것 삭제
none3<-none3[is.na(none3$id)==FALSE,] #id ᄋ 삭제

#가수 둘 이상의 점수 sum
a<-none3 %>% group_by(id) %>% summarise_at(vars(dc_t_number),list(name=sum)) 
names(a)[2]<-"dc_t_number"
new<-left_join(none,a,by="id") %>% select(id,dc_t_number)

#하
basic3<-left_join(basic2,new,by="id") #기본과 sum낸 데이터 합치기 
basic3$dc_t_number<-ifelse(is.na(basic3$dc_t_number.x)==TRUE,basic3$dc_t_number.y,basic3$dc_t_number.x)
basic3$dc_t_number<-round(basic3$dc_t_number,digit=1) # 소수점   

#정말 값이 없는 데이터 확인 
a<-basic3[is.na(basic3$dc_t_number)==TRUE,] 

basic3$dc_t_number[is.na(basic3$dc_t_number)]=0 #값이 어는 데이터에 "0"입

basic3$dc_t_number.x<-NULL
basic3$dc_t_number.y<-NULL

basic<-basic3


##total_recommend======
t_reco<-dc %>% select(week,artist,total_reccomend) 
t_reco<-aggregate(t_reco$total_reccomend,by=list(t_reco$week,t_reco$artist),FUN=sum)
names(t_reco)<-c("week","artist","dc_t_recommend")
data<-t_reco

#merge in basic and dc_t_recommend
basic2<-left_join(basic,data,by=c("week","artist")) #기본+네이버

dim(table(which(is.na(basic2$dc_t_recommend))))

#dc_t_recommend없는것을 none파일로 만들어 
none<-basic2[is.na(basic2$dc_t_recommend),]

none<-subset(none,select=c("id","week","artist"))

none$artist2<-gsub('&',',',none$artist)
artist3<-str_split_fixed(none$artist2, ",", 6)
artist3<-data.frame(artist3)

artist3$X1<-str_trim(artist3$X1,side="both")
artist3$X2<-str_trim(artist3$X2,side="both")
artist3$X3<-str_trim(artist3$X3,side="both")
artist3$X4<-str_trim(artist3$X4,side="both")
artist3$X5<-str_trim(artist3$X5,side="both")
artist3$X6<-str_trim(artist3$X6,side="both")

none<-bind_cols(none,artist3)

none2<-none %>% gather(X1:X6,key="x",value="artist") %>% select(id,week,artist) 

#data와 none을 머지
none3<-left_join(data,none2,by=c("artist","week"))
none3<-merge(none2,data,by=c("artist","week"),all = TRUE)
none3<-none3[is.na(none3$dc_t_recommend)==FALSE,] #dc_t_recommend 없는것 삭제
none3<-none3[is.na(none3$id)==FALSE,] #id 없느 삭제

#가수 둘 이상의 점수 sum
a<-none3 %>% group_by(id) %>% summarise_at(vars(dc_t_recommend),list(name=sum)) 
names(a)[2]<-"dc_t_recommend"
new<-left_join(none,a,by="id") %>% select(id,dc_t_recommend)

#합계내기
basic3<-left_join(basic2,new,by="id") #기본과 sum낸 데이터 합치기 
basic3$dc_t_recommend<-ifelse(is.na(basic3$dc_t_recommend.x)==TRUE,basic3$dc_t_recommend.y,basic3$dc_t_recommend.x)
basic3$dc_t_recommend<-round(basic3$dc_t_recommend,digit=1) # 소수점   

#정말 값이 없는 데이터 확인 
a<-basic3[is.na(basic3$dc_t_recommend)==TRUE,] 

basic3$dc_t_recommend[is.na(basic3$dc_t_recommend)]=0 #값이 없는 데이터에 "0"입

basic3$dc_t_recommend.x<-NULL
basic3$dc_t_recommend.y<-NULL
basic3$dc_t_number.x<-NULL
basic<-basic3


##total_views==========
t_views<-dc %>% select(week,artist,total_views) 
t_views<-aggregate(t_views$total_views,by=list(t_views$week,t_views$artist),FUN=sum)
names(t_views)<-c("week","artist","dc_t_views")
data<-t_views

#merge in basic and dc_t_views
basic2<-left_join(basic,data,by=c("week","artist")) #기본+네이버

dim(table(which(is.na(basic2$dc_t_views))))

#dc_t_views없는것을 none파일로 만들어 
none<-basic2[is.na(basic2$dc_t_views),]

none<-subset(none,select=c("id","week","artist"))

none$artist2<-gsub('&',',',none$artist)
artist3<-str_split_fixed(none$artist2, ",", 6)
artist3<-data.frame(artist3)

artist3$X1<-str_trim(artist3$X1,side="both")
artist3$X2<-str_trim(artist3$X2,side="both")
artist3$X3<-str_trim(artist3$X3,side="both")
artist3$X4<-str_trim(artist3$X4,side="both")
artist3$X5<-str_trim(artist3$X5,side="both")
artist3$X6<-str_trim(artist3$X6,side="both")

none<-bind_cols(none,artist3)

none2<-none %>% gather(X1:X6,key="x",value="artist") %>% select(id,week,artist) 

#data와 none을 머지
none3<-left_join(data,none2,by=c("artist","week"))
none3<-merge(none2,data,by=c("artist","week"),all = TRUE)
none3<-none3[is.na(none3$dc_t_views)==FALSE,] #dc_t_views 없는것 삭
none3<-none3[is.na(none3$id)==FALSE,] #id 없는것 삭제

#가수 둘 이상의 점수 sum
a<-none3 %>% group_by(id) %>% summarise_at(vars(dc_t_views),list(name=sum)) 
names(a)[2]<-"dc_t_views"
new<-left_join(none,a,by="id") %>% select(id,dc_t_views)

#합계내기
basic3<-left_join(basic2,new,by="id") #기본과 sum낸 데이터 합치기 
basic3$dc_t_views<-ifelse(is.na(basic3$dc_t_views.x)==TRUE,basic3$dc_t_views.y,basic3$dc_t_views.x)
basic3$dc_t_views<-round(basic3$dc_t_views,digit=1) # 소수점   

#정말 값이 없는 데이터 확인 
a<-basic3[is.na(basic3$dc_t_views)==TRUE,] 

basic3$dc_t_views[is.na(basic3$dc_t_views)]=0 #값이 없는 데이터에 "0"입

basic3$dc_t_views.x<-NULL
basic3$dc_t_views.y<-NULL

basic<-basic3


##mean_recommend==========
m_reco<-dc %>% select(week,artist,mean_reccomend) 
m_reco<-aggregate(m_reco$mean_reccomend,by=list(m_reco$week,m_reco$artist),FUN=mean)
names(m_reco)<-c("week","artist","dc_m_recommend")
data<-m_reco

#merge in basic and dc_m_recommend
basic2<-left_join(basic,data,by=c("week","artist")) #기본+네이버

dim(table(which(is.na(basic2$dc_m_recommend))))

#dc_m_recommend없는것을 none파일로 만들어 
none<-basic2[is.na(basic2$dc_m_recommend),]

none<-subset(none,select=c("id","week","artist"))

none$artist2<-gsub('&',',',none$artist)
artist3<-str_split_fixed(none$artist2, ",", 6)
artist3<-data.frame(artist3)

artist3$X1<-str_trim(artist3$X1,side="both")
artist3$X2<-str_trim(artist3$X2,side="both")
artist3$X3<-str_trim(artist3$X3,side="both")
artist3$X4<-str_trim(artist3$X4,side="both")
artist3$X5<-str_trim(artist3$X5,side="both")
artist3$X6<-str_trim(artist3$X6,side="both")

none<-bind_cols(none,artist3)

none2<-none %>% gather(X1:X6,key="x",value="artist") %>% select(id,week,artist) 

#data와 none을 머지
none3<-left_join(data,none2,by=c("artist","week"))
none3<-merge(none2,data,by=c("artist","week"),all = TRUE)
none3<-none3[is.na(none3$dc_m_recommend)==FALSE,] #dc_m_recommend 없는ᄀ 삭제
none3<-none3[is.na(none3$id)==FALSE,] #id 없는것 삭제

#가수 둘 이상의 점수 mean
a<-none3 %>% group_by(id) %>% summarise_at(vars(dc_m_recommend),list(name=mean)) 
names(a)[2]<-"dc_m_recommend"
new<-left_join(none,a,by="id") %>% select(id,dc_m_recommend)

#합계내기
basic3<-left_join(basic2,new,by="id") #기본과 mean한 데이터 합치기 
basic3$dc_m_recommend<-ifelse(is.na(basic3$dc_m_recommend.x)==TRUE,basic3$dc_m_recommend.y,basic3$dc_m_recommend.x)
basic3$dc_m_recommend<-round(basic3$dc_m_recommend,digit=1) # 소수점   

#정말 값이 없는 데이터 확인 
a<-basic3[is.na(basic3$dc_m_recommend)==TRUE,] 

basic3$dc_m_recommend[is.na(basic3$dc_m_recommend)]=0 #값이 없는 데이터에 "0"입

basic3$dc_m_recommend.x<-NULL
basic3$dc_m_recommend.y<-NULL

basic<-basic3


##mean_views============
m_views<-dc %>% select(week,artist,mean_views) 
m_views<-aggregate(m_views$mean_views,by=list(m_views$week,m_views$artist),FUN=mean)
names(m_views)<-c("week","artist","dc_m_views")
data<-m_views

basic2<-left_join(basic,data,by=c("week","artist")) #기본+네이버

dim(table(which(is.na(basic2$dc_m_views))))

#dc_m_views없는것을 none파일로 만들어 
none<-basic2[is.na(basic2$dc_m_views),]

none<-subset(none,select=c("id","week","artist"))

none$artist2<-gsub('&',',',none$artist)
artist3<-str_split_fixed(none$artist2, ",", 6)
artist3<-data.frame(artist3)

artist3$X1<-str_trim(artist3$X1,side="both")
artist3$X2<-str_trim(artist3$X2,side="both")
artist3$X3<-str_trim(artist3$X3,side="both")
artist3$X4<-str_trim(artist3$X4,side="both")
artist3$X5<-str_trim(artist3$X5,side="both")
artist3$X6<-str_trim(artist3$X6,side="both")

none<-bind_cols(none,artist3)

# dc_m_views을 붙이 됨. 
none2<-none %>% gather(X1:X6,key="x",value="artist") %>% select(id,week,artist) 

#data와 none을 머지
none3<-left_join(data,none2,by=c("artist","week"))
none3<-merge(none2,data,by=c("artist","week"),all = TRUE)
none3<-none3[is.na(none3$dc_m_views)==FALSE,] #dc_m_views 없는것 삭제
none3<-none3[is.na(none3$id)==FALSE,] #id 없는것 삭제

#가수 둘 이상의 점수 mean
a<-none3 %>% group_by(id) %>% summarise_at(vars(dc_m_views),list(name=mean)) 
names(a)[2]<-"dc_m_views"
new<-left_join(none,a,by="id") %>% select(id,dc_m_views)

#합계내기
basic3<-left_join(basic2,new,by="id") #기본과 mean한 ᄃ 합치기 
basic3$dc_m_views<-ifelse(is.na(basic3$dc_m_views.x)==TRUE,basic3$dc_m_views.y,basic3$dc_m_views.x)
basic3$dc_m_views<-round(basic3$dc_m_views,digit=1) # 소수점   

#정말 값이 없느  확인 
a<-basic3[is.na(basic3$dc_m_views)==TRUE,] 

basic3$dc_m_views[is.na(basic3$dc_m_views)]=0 #값이 없는 데이터에 "0"입

basic3$dc_m_views.x<-NULL
basic3$dc_m_views.y<-NULL

basic<-basic3
#write.csv(basic,"data/basic_gg_nv_dc_0510.csv") #gaon+ggtrend+navertrend+dc
# save(basic, file="data/basic_gg_nv_dc_0510.RData")


# basic+youtube by 강동원 ----------------------------------------------------
### data import ###
data<-read_csv("~/Desktop/dsproject/data/youtube_merge_final.csv")
data$X1<-data$X1+1 # 0부터 시작되서 1더하기 
names(data)[1]<-"id" #기본의 id만들기
names(data)


###중복제거 ###
data<-data[!duplicated(data[,c("name","st_day","rank")]),]

table(data$rank)

#save(basic, file="basic_dc_you_0512.RData")

######################### Google Trend by 오태환 ----------------------------------------------------------------------

###data import ###
ggtrend<-read_csv("~/Desktop/dsproject/data/googletrend크롤링.csv")
data<-ggtrend
names(data)[1]<-"st_day"
names(data)[369]<-"X1"
data$양요섭_1<-NULL

data$st_day<-ymd(data$st_day)
dim(data)

###structure change
data<-gather(data,names(data)[2]:names(data)[441],key="artist",value="gg_score")

###merge in gaon chart and google trend
basic<-final0511
basic$gg_score<-NULL

basic2<-left_join(basic,data,by=c("st_day","artist"))

###gg_scoreᄋ는것을 none파일로 만들어 
none<-basic2[is.na(basic2$gg_score),]

none<-subset(none,select=c("id","st_day","artist"))

none$artist2<-gsub('&',',',none$artist)
artist3<-str_split_fixed(none$artist2, ",", 6)
artist3<-data.frame(artist3)

artist3$X1<-str_trim(artist3$X1,side="both")
artist3$X2<-str_trim(artist3$X2,side="both")
artist3$X3<-str_trim(artist3$X3,side="both")
artist3$X4<-str_trim(artist3$X4,side="both")
artist3$X5<-str_trim(artist3$X5,side="both")
artist3$X6<-str_trim(artist3$X6,side="both")

none<-bind_cols(none,artist3)

### ggscore을 붙이면 됨. 
none2<-none %>% gather(X1:X6,key="x",value="artist") %>% select(id,st_day,artist) 

###data와 none을 머
none3<-merge(none2,data,by=c("artist","st_day"),all = TRUE)
none3<-none3[is.na(none3$gg_score)==FALSE,] #ggscore 없는것 삭제
none3<-none3[is.na(none3$id)==FALSE,] #id 없는것 삭제

###가ᄉ 둘 이상의 점수 합계내기
a<-none3 %>% group_by(id) %>% summarise_at(vars(gg_score),list(name=mean)) 
names(a)[2]<-"gg_score"
new<-left_join(none,a,by="id") %>% select(id,gg_score)

###합계ᄂ
basic3<-left_join(basic2,new,by="id") #가온차트데이터와 평균 낸 데이터 합치기 
basic3$gg_score<-ifelse(is.na(basic3$gg_score.x)==TRUE,basic3$gg_score.y,basic3$gg_score.x)
basic3$gg_score<-round(basic3$gg_score,digit=1) # 소수점   

#정말 값이 없는 데이터 확인 
a<-basic3[is.na(basic3$gg_score)==TRUE,] 

basic3$gg_score[is.na(basic3$gg_score)]=0 #ᄀ이 없는 데이터에 "0"입

basic3$gg_score.x<-NULL
basic3$gg_score.y<-NULL

basic<-basic3

write.csv(basic,"data/basic_dc_you_gg_0511_pm.csv") 
save(basic, file="data/basic_dc_you_gg_0511_pm.RData")


# Naver Trend by 오태환 ------------------------------------------------------
### data import ###
naver<-read_csv("~/Desktop/dsproject/data/navertrend크롤링.csv")
data<-naver

names(data)[1]<-"st_day"
names(data)[425]<-"X1"
data$st_day<-ymd(data$st_day)

#basic과 navertrend의 날짜 맞추기 
data$st_day<-data$st_day-1

#structure change
dim(data)
data<-gather(data,names(data)[2]:names(data)[477],key="artist",value="nv_score")

#merge in basic and naver trend
basic$nv_score<-NULL
basic2<-left_join(basic,data,by=c("st_day","artist"))#기본+네이버

#nv_score없는것을 none파일로 만들어 
none<-basic2[is.na(basic2$nv_score),]

none<-subset(none,select=c("id","st_day","artist"))

none$artist2<-gsub('&',',',none$artist)
artist3<-str_split_fixed(none$artist2, ",", 6)
artist3<-data.frame(artist3)

artist3$X1<-str_trim(artist3$X1,side="both")
artist3$X2<-str_trim(artist3$X2,side="both")
artist3$X3<-str_trim(artist3$X3,side="both")
artist3$X4<-str_trim(artist3$X4,side="both")
artist3$X5<-str_trim(artist3$X5,side="both")
artist3$X6<-str_trim(artist3$X6,side="both")

none<-bind_cols(none,artist3)

#여기부터 다시 
# nv_core을 붙이면 됨. 
none2<-none %>% gather(X1:X6,key="x",value="artist") %>% select(id,st_day,artist) 

#data와 none을 머지
none3<-merge(none2,data,by=c("artist","st_day"),all = TRUE)
none3<-none3[is.na(none3$nv_score)==FALSE,] #ggscore 없는것 삭제
none3<-none3[is.na(none3$id)==FALSE,] #id 없는것 삭제

#가수 둘 이상의 점수 합계내기
a<-none3 %>% group_by(id) %>% summarise_at(vars(nv_score),list(name=mean)) 
names(a)[2]<-"nv_score"
new<-left_join(none,a,by="id") %>% select(id,nv_score)

#합계내기
basic3<-left_join(basic2,new,by="id") #가온차트데이 평균 낸 데이터 합치기 
basic3$nv_score<-ifelse(is.na(basic3$nv_score.x)==TRUE,basic3$nv_score.y,basic3$nv_score.x)
basic3$nv_score<-round(basic3$nv_score,digit=1) # 소수점   

#정마 값이 없는 데이터 확인 
a<-basic3[is.na(basic3$nv_score)==TRUE,] 

basic3$nv_score[is.na(basic3$nv_score)]=0 #값이 없는 데이터에 "0"입

basic3$nv_score.x<-NULL
basic3$nv_score.y<-NULL

final0511<-basic3
write.csv(final0511,"data/basic_dc_you_gg_nv_0511_pm.csv") 
save(final0511, file="data/basic_dc_you_gg_nv_0511_pm.RData")

