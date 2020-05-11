library(XML)
library(httr)
library(RCurl)


seqday<-seq(as.Date("2019-05-27"),to= as.Date("2019-12-30"),by="7 day")
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





for(i in 1:length(date)){
  
nielsen1<-paste("https://www.nielsenkorea.co.kr/tv_terrestrial_day.asp?menu=Tit_1&sub_menu=1_2&area=00&begin_date=",date[i],sep = "")
  

r = GET(nielsen1, encoding = "UTF-8")


  
  
  table[[i]]<-readHTMLTable(content(r, "text"),which=9, skip.rows = 3)
}


rankingtable = c()
for(i in 1:32){
  ratio = cbind(table[[i]][-1, c(-1,-2)], rep(date[i],20))
  colnames(ratio) = c("제목", "시청률", "주차")
  rankingtable<-rbind(rankingtable,ratio)
}
write.csv(rankingtable,file="시청률.csv")

#리스트 형태로 만든 각 주차별 table을 모두 합친 후에 csv 형태로 저장한다.