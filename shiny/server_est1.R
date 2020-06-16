datatab = read_csv("data/final_result_graph.csv")

output$mytable<-DT::renderDataTable({
  DT::datatable(datatab[,2:14,drop=F],options=list(lengthMenu=c(10,50,100),orderClasses=TRUE))
})