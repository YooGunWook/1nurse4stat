datatab = read_csv("data/finalresult_graph_final_5.csv")

output$mytable<-DT::renderDataTable({
  DT::datatable(datatab[,c(2,3,5,6,8,19,84),drop=F],options=list(lengthMenu=c(10,50,100),orderClasses=TRUE))
})

names(datatab)

diff_data = datatab %>% mutate(diff_rank = abs(rank - rank_g_pred))
tempd=diff_data%>%select(artist, name, week, rank, rank_g_pred,previous_ranking_nan,diff_rank) %>% arrange(diff_rank)


hist(tempd$diff_rank, main='Rank Difference',border='white',col='#CF325C',xlim=c(0,100))

names(datatab)
