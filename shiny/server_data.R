datatab = read_csv("data/finalresult_graph_final_5.csv")

output$mytable<-DT::renderDataTable({
  DT::datatable(datatab[,c(2,3,5,6,8,19,84),drop=F],options=list(lengthMenu=c(10,50,100),orderClasses=TRUE))
})

names(datatab)
