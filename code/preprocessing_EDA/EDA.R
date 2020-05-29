data<-read_csv("~/Desktop/dsproject/data/basic_0504.csv")

# sex ---------------------------------------------------------------------
ggplot(data,aes(x=sex))+
  geom_bar(fill=c("sky blue","pink","orange"))

ggplot(data,aes(x=sex,y=rank))+
  geom_boxplot(fill=c("sky blue","pink","orange"))

# genre -------------------------------------------------------------------
ggplot(data,aes(x=type))+
  geom_bar(fill=c("LightSky Blue","pink","violet","orange"))

ggplot(data,aes(x=type,y=rank))+
  geom_boxplot(fill=c("LightSky Blue","pink","violet","orange"))

ggplot(data,aes(x=genre_g))+
  geom_bar(fill=c("LightSky Blue","pink","orange"))

ggplot(data,aes(x=genre_g,y=rank))+
  geom_boxplot(fill=c("LightSky Blue","pink","orange"))

# runtime -----------------------------------------------------------------
ggplot(data,aes(x=runtime))+
  geom_histogram(fill="#F8766D",color="black",binwidth = 3.5)

ggplot(data,aes(x=runtime_g,y=rank))+
  geom_boxplot(fill="#F8766D",color="black")


# active_type -------------------------------------------------------------
ggplot(data,aes(x=active_type))+
  geom_bar(fill=c("#D73027","#F46D43","#FDAE61","#FEE090","#FFFFBF"))

ggplot(data,aes(x=active_type_g))+
  geom_bar(fill=c("#F46D43","#D73027"))

ggplot(data,aes(x=active_type,y=rank))+
  geom_boxplot(fill=c("#D73027","#F46D43","#FDAE61","#FEE090","#FFFFBF"))

ggplot(data,aes(x=active_type_g,y=rank))+
  geom_boxplot(fill=c("#F46D43","#D73027"))


# 200위안에 6개월동안 몇주동 지? ----------------------------------------------------------
top<-data[!duplicated(data$song_id),]

ggplot(top,aes(x=top_freq))+
  geom_histogram(fill="#F8766D",color="black",binwidth = 1)

ggplot(top,aes(x=top_freq_g))+
  geom_bar(aes(fill=genre_g))

ggplot(top,aes(x=top_freq_g))+
  geom_bar(aes(fill=sex))

ggplot(top,aes(x=top_freq_g))+
  geom_bar(aes(fill=runtime_g))

ggplot(top,aes(x=top_freq_g))+
  geom_bar(aes(fill=active_type_g))

