library(XML)
library(httr)
library(RCurl)


seqday<-seq(as.Date("2018-04-22"),to= as.Date("2020-04-25"),by="1 day")
seqday<-as.character(seqday)
strsp<-unlist(strsplit(seqday,split="-"))

strsp

data<-c()
j<-1
date<-0
for(i in seq(1,(length(strsp)-2),3)){
  date1<-paste(strsp[i],strsp[i+1],strsp[i+2],sep = "")
  date<-c(date,date1)
}
date<-date[-1]

#yyyy-mm-dd 형태의 날짜를 yyyymmdd 형태로 만듦



table<-list()
classes<-c("integer","character","character","character","character")




## 지상파 일일 시청률 크롤링
for(i in 1:length(date)){
  
  nielsen1<-paste("https://www.nielsenkorea.co.kr/tv_terrestrial_day.asp?menu=Tit_1&sub_menu=1_1&area=00&begin_date=",date[i],sep = "")
  

  r = GET(nielsen1, encoding = "UTF-8")


  
  
    table[[i]]<-readHTMLTable(content(r, "text"),which=9, skip.rows = 3)
}


rankingtable = c()
for(i in 1:length(date)){
  ratio = cbind(table[[i]][-1, c(-1,-2)], rep(date[i],20))
  colnames(ratio) = c("제목", "시청률", "주차")
  rankingtable<-rbind(rankingtable,ratio)
}
write.csv(rankingtable,file="지상파시청률.csv")

## 종편 일일 시청률 크롤링
for(i in 1:length(date)){
  
  nielsen1<-paste("https://www.nielsenkorea.co.kr/tv_terrestrial_day.asp?menu=Tit_1&sub_menu=2_1&area=00&begin_date=",date[i],sep = "")
  
  
  r = GET(nielsen1, encoding = "UTF-8")
  
  
  
  
  table[[i]]<-readHTMLTable(content(r, "text"),which=9, skip.rows = 3)
}


rankingtable = c()
for(i in 1:length(date)){
  ratio = cbind(table[[i]][-1, c(-1,-2)], rep(date[i],20))
  colnames(ratio) = c("제목", "시청률", "주차")
  rankingtable<-rbind(rankingtable,ratio)
}
write.csv(rankingtable,file="종편편시청률.csv")

# 케이블 일일 시청률 크롤링
for(i in 1:length(date)){
  
  nielsen1<-paste("https://www.nielsenkorea.co.kr/tv_terrestrial_day.asp?menu=Tit_1&sub_menu=3_1&area=00&begin_date=",date[i],sep = "")
  
  
  r = GET(nielsen1, encoding = "UTF-8")
  
  
  
  
  table[[i]]<-readHTMLTable(content(r, "text"),which=9, skip.rows = 3)
}


rankingtable = c()
for(i in 1:length(date)){
  ratio = cbind(table[[i]][-1, c(-1,-2)], rep(date[i],20))
  colnames(ratio) = c("제목", "시청률", "주차")
  rankingtable<-rbind(rankingtable,ratio)
}
write.csv(rankingtable,file="케이블시청률.csv")
#리스트 형태로 만든 각 주차별 table을 모두 합친 후에 csv 형태로 저장한다.