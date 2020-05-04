# library -----------------------------------------------------------------
library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(forcats)
library(car)
library(ggplot2)


#######################GAON Chart by yoogunwook ----------------------------------------------------------------------
# data import -------------------------------------------------------------
data<-read_csv("~/Desktop/dsproject/data/2019.06~2019.12.csv")
glimpse(data)
tail(data)
names(data)
data$X1<-data$X1+1 #0부터 시작되서 1더하기 
names(data)[1]<-"id"

#data의 song의 id 만들기
table(duplicated(data[,c("name","artist")]))  
names(data)

only1<-data[which(!duplicated(data[,c("name","artist")])),] #duplicated_none
only1$song_id<-c(1:686)
only1<-subset(only1,select=c("name","artist","song_id"))
data<-left_join(data,only1,by=c("name","artist"))

# rank --------------------------------------------------------------------
data$rank_g<-ifelse(data$rank==c(1:10),1,
                    ifelse(data$rank==c(11:20),2,
                           ifelse(data$rank==c(21:30),3,
                                  ifelse(data$rank==c(31:40),4,
                                         ifelse(data$rank==c(41:50),5,
                                                ifelse(data$rank==c(51:60),6,
                                                       ifelse(data$rank==c(61:70),7,
                                                              ifelse(data$rank==c(71:80),8,
                                                                     ifelse(data$rank==c(81:90),9,
                                                                            ifelse(data$rank==c(91:100),10,
                                                                                   ifelse(data$rank==c(101:110),11,
                                                                                          ifelse(data$rank==c(111:120),12,
                                                                                                 ifelse(data$rank==c(121:130),13,
                                                                                                        ifelse(data$rank==c(131:140),14,
                                                                                                               ifelse(data$rank==c(141:150),15,
                                                                                                                      ifelse(data$rank==c(151:160),16,
                                                                                                                             ifelse(data$rank==c(161:170),17,
                                                                                                                                    ifelse(data$rank==c(171:180),18,
                                                                                                                                           ifelse(data$rank==c(181:190),19,20)))))))))))))))))))





# change to weeks variable ----------------------------------------------------
data<-data %>% separate(time,c("st_day","ed_day"),"~") 

data$st_day<-ymd(data$st_day)
data$ed_day<-ymd(data$ed_day)

data<- data %>% group_by(year(st_day)) %>% group_by(month(st_day)) %>% group_by(day(st_day))
names(data)
names(data)[16]<-"year"
names(data)[17]<-"month"
names(data)[18]<-"day"
data<-data %>% group_by(year) %>% group_by(month) %>% mutate(num=dense_rank(day)) 
data$year<-substr(data$year,3,4)
data$month<-ifelse(str_count(data$month)==1,paste0(0,data$month),data$month)
data$wks<-paste0(data$year,data$month,"_",data$num,"wk") #In what weeks of the month?

# sex ---------------------------------------------------------------------
data$sex<- fct_recode(data$sex,male="",female="여성",mixed="혼성")


# production --------------------------------------------------------------정리안함
dim(addmargins(table(data$production)))

# distributor -------------------------------------------------------------정리안함
dim(addmargins(table(data$distributor)))


# genre -------------------------------------------------------------------
table(data$genre)
A<-str_split_fixed(data$genre,"/ ",n=2)
A<-data.frame(A)
names(A)[1]<-"type"
names(A)[2]<-"gen"
data<-bind_cols(data,A)

mode(data$type)
table(data$type)
data$type

data$type<-fct_recode(data$type,K_POP="가요 ",POP="POP ",OST="OST ",Others="그외장르 ") 
data$type<-fct_relevel(data$type,c("K_POP","POP","OST","Others"))
addmargins(table(data$type))

addmargins(table(data$gen))


data$genre_g<-recode(data$gen,"'댄스'='Dance_etc';'락'='Dance_etc';'랩/힙합'='Dance_etc';'일렉트로ᄂ'='Dance_etc';'캐롤'='Dance_etc';'트로트'='Dance_etc';
                              '발라드'='Balad_etc';'블루스/포크'='Balad_etc';'R&B/소울'='Balad_etc';'인디'='Balad_etc';
                              '드라마'='Others';'애니메이션/게임'='Others';'팝'='Others';'해외영화'='Others';'전체'='Others'")


names(data)
str(data)

# runtime -----------------------------------------------------------------
data$runtime<-substr(data$runtime,1,5)
data$runtime<-as.numeric(substr(data$runtime,1,2))*60+as.numeric(substr(data$runtime,4,5))

a<-data %>% arrange(runtime) %>% mutate(qaun_runtime=ntile(runtime,2))
a<-subset(a,select=c(runtime,qaun_runtime))

percent_rank(data$runtime)
min_rank(data$runtime)

summary(data$runtime)
data$runtime_g<-as.factor(ifelse(data$runtime<=199,"Short",
                          ifelse(data$runtime>=241,"Long","Middle")))


# active_type -------------------------------------------------------------
data$active_type<-factor(data$active_type,levels=c("솔로","그룹","밴드","프로젝트","듀엣"),
                         labels=c("Solo","Group","Band","Project","Duet"))

table(data$active_type)

data$active_type_g<-as.factor(ifelse(data$active_type=="Solo","Solo","Non_solo"))



# 200위안에 6개월동안 몇주동아 지? ----------------------------------------------------------
data$song_id<-factor(data$song_id)
a<-table(data$song_id)
A<-data.frame(a)
names(A)[1]<-"song_id"
names(A)[2]<-"top_freq"

ggplot(A,aes(x=top_freq))+
  geom_histogram(fill="#F8766D",color="black",binwidth = 1)

summary(A$top_freq)

A$top_freq_g<-factor(ifelse(A$top_freq<=2,"Low",
                      ifelse(A$top_freq>=13,"High","Middle")))
A$top_freq_g<-fct_relevel(A$top_freq_g,"High","Middle","Low")

data<-left_join(data,A,by="song_id")

basic<-data
save(basic, file="basic.RData")

######################### Google Trend by 오태환 ----------------------------------------------------------------------

# data import -------------------------------------------------------------
ggtrend<-read_csv("~/Desktop/dsproject/data/singer.csv")
data<-ggtrend

names(data)[1]<-"st_day"
names(data)[44]<-"X1"
data[317]<-NULL #원래 데이터와 변수명은 , 값이 달라서 원 . 
data[323]<-NULL #원래 데이터와 변수명은 중복인데, 값이 달라서 원본으로 함. 
names(data)
data$st_day<-ymd(data$st_day)
dim(table(basic$st_day))
dim(data)

#structure change
data<-gather(data,names(data)[2]:names(data)[331],key="artist",value="gg_score")

#merge in gaon chart and google trend
basic2<-left_join(basic,data,by=c("st_day","artist"))#가온차트&ᄀ

dim(table(which(is.na(basic2$gg_score))))

#gg_score없는것을 none파일로 만들어 
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

# ggscore을 붙이면 됨. 
none2<-none %>% gather(X1:X6,key="x",value="artist") %>% select(id,st_day,artist) 

#data와 none을 머지
none3<-merge(none2,data,by=c("artist","st_day"),all = TRUE)
none3<-none3[is.na(none3$gg_score)==FALSE,] #ggscore 없는것 삭제
none3<-none3[is.na(none3$id)==FALSE,] #id 없는것 삭제

#가수 둘 이상의 점수 합계내기
a<-none3 %>% group_by(id) %>% summarise_at(vars(gg_score),list(name=mean)) 
names(a)[2]<-"gg_score"
new<-left_join(none,a,by="id") %>% select(id,gg_score)

#합계내기
basic3<-left_join(basic2,new,by="id") #가온차트데이터와 평균 낸 데이터 합치기 
basic3$gg_score<-ifelse(is.na(basic3$gg_score.x)==TRUE,basic3$gg_score.y,basic3$gg_score.x)
basic3$gg_score<-round(basic3$gg_score,digit=1) # 소수점   

#정말 값이 없는 데이터 확인 
a<-basic3[is.na(basic3$gg_score)==TRUE,] 

basic3$gg_score[is.na(basic3$gg_score)]=0 #값이 없는 데이터에 "0"입

basic<-basic3
names(basic)
basic<-select(basic,id,song_id,name,production,distributor,artist,st_day,wks,num,ed_day,year,month,day,score,rank,rank_g,runtime,runtime_g,
              sex,genre,type,gen,genre_g,sex,active_type,active_type_g,gg_score,top_freq,top_freq_g)

#write.csv(basic,"data/basic_0504.csv") #gaon+ggtrend
#save(basic, file="data/basic_0504.RData")

