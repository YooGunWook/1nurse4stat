library(readr)
library(dplyr)

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

write_csv(tb,"dc_raw_data.csv")



n_tb =tb %>%
  filter(number!="공지") %>%
  mutate(date=as.Date(date),number=as.numeric(number)) %>%
  group_by(singer,date)%>%
  summarize(
    total_number = max(number)-min(number)+1,
    mean_reccomend = mean(recommend),
    total_reccomend = sum(recommend),
    mean_views = mean(views),
    total_views = sum(views)
          ) %>%
  glimpse()


write_csv(n_tb,"dc_data.csv")



