library(DT)
library(plotly)

server <- function(input, output) {
  cdata<-read.csv("compare.csv",header=TRUE)
  #Random Forest
  rf_matrix=table(cdata$CatboostRegressor,cdata$RandomForest)
  rf_matrix_plot<-as.data.frame(rf_matrix)
  rf_acc_up=sum(cdata$CatboostRegressor==cdata$RandomForest)
  data_length=length(cdata$RandomForest)
  rf_accuracy<-round(rf_acc_up/data_length,2)
  rf_trn<-sum(cdata$CatboostRegressor==0 & cdata$RandomForest==0)+sum(cdata$CatboostRegressor==2 & cdata$RandomForest==2)
  rf_fap<-sum(cdata$CatboostRegressor!=1 & cdata$RandomForest==1)
  total_neg<-sum(cdata$CatboostRegressor==0)+sum(cdata$CatboostRegressor==2)
  rf_specificity<-round(rf_trn/total_neg,2)
  #DNN
  dnn_matrix=table(cdata$CatboostRegressor,cdata$DNN)
  dnn_matrix_plot<-as.data.frame(dnn_matrix)
  dnn_acc_up=sum(cdata$CatboostRegressor==cdata$DNN)
  dnn_accuracy<-round(dnn_acc_up/data_length,2)
  dnn_trn<-sum(cdata$CatboostRegressor==0 & cdata$DNN==0)+sum(cdata$CatboostRegressor==2 & cdata$DNN==2)
  dnn_fap<-sum(cdata$CatboostRegressor!=1 & cdata$DNN==1)
  dnn_specificity<-round(dnn_trn/total_neg,2)
  #CatboostClassifier
  cbc_matrix=table(cdata$CatboostRegressor,cdata$CatboostClassifier)
  cbc_matrix_plot<-as.data.frame(cbc_matrix)
  cbc_acc_up=sum(cdata$CatboostRegressor==cdata$CatboostClassifier)
  cbc_accuracy<-round(cbc_acc_up/data_length,2)
  cbc_trn<-sum(cdata$CatboostRegressor==0 & cdata$CatboostClassifier==0)+sum(cdata$CatboostRegressor==2 & cdata$CatboostClassifier==2)
  cbc_fap<-sum(cdata$CatboostRegressor!=1 & cdata$CatboostClassifier==1)
  cbc_specificity<-round(cbc_trn/total_neg,2)

  fdata<-read.csv("predict.csv",header=TRUE)
  class_counts=table(fdata$QualityClass)
  class_num=as.data.frame(class_counts)

  output$random_forest<-renderPlotly({
    ggplot(rf_matrix_plot,aes(x=Var1,y=Var2,fill=Freq))+
    geom_tile(color = "black") +
    ggtitle("Confusion matrix of\n Random forest")+
    geom_text(aes(label = Freq), vjust = 1) +
    labs(x = "Actual", y = "Predicted", fill = "Frequency") +
    theme_minimal() +
    scale_fill_gradient(low = "white", high = "blue") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))    
  })
  output$rf_text<-renderText({
    paste("Accuracy:\n",rf_accuracy,"Specificity:\n",rf_specificity)
  })
  output$DNN<-renderPlotly({
    ggplot(dnn_matrix_plot,aes(x=Var1,y=Var2,fill=Freq))+
    geom_tile(color = "black") +
    ggtitle("Confusion matrix of\n DNN")+
    geom_text(aes(label = Freq), vjust = 1) +
    labs(x = "Actual", y = "Predicted", fill = "Frequency") +
    theme_minimal() +
    scale_fill_gradient(low = "white", high = "blue") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))    
  })
  output$dnn_text<-renderText({
    paste("Accuracy:\n",dnn_accuracy,"Specificity:\n",dnn_specificity)
  })
  output$CatboostClassifier<-renderPlotly({
    ggplot(cbc_matrix_plot,aes(x=Var1,y=Var2,fill=Freq))+
    geom_tile(color = "black") +
    ggtitle("Confusion matrix of\n CatboostClassifier")+
    geom_text(aes(label = Freq), vjust = 1) +
    labs(x = "Actual", y = "Predicted", fill = "Frequency") +
    theme_minimal() +
    scale_fill_gradient(low = "white", high = "blue") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))    
  })
  output$cbc_text<-renderText({
    paste("Accuracy:\n",cbc_accuracy,"Specificity:\n",cbc_specificity)
  })

  output$quality_table<-renderDT({
    datatable(fdata)
  })

  output$quality_pie<-renderPlotly({
    quality_pie<-plot_ly(class_num,labels=~Var1,values=~Freq,type='pie')
    quality_pie <- quality_pie %>%
      layout(title = "Pie graph of quality classes")
    quality_pie
  })

  output$line_table<-renderDT({
    ldata<-fdata %>% filter(LineID==input$line) %>% select(ProductID,QualityClass)
    datatable(ldata)
  })

  output$line_quality_pie<-renderPlotly({
    ldata<-fdata %>% filter(LineID==input$line) %>% select(ProductID,QualityClass)
    pieTitle=paste("Pie graph of quality classes from ",input$line)
    line_class_counts=table(ldata$QualityClass)
    line_class_num=as.data.frame(line_class_counts)
    line_quality_pie<-plot_ly(line_class_num,labels=~Var1,values=~Freq,type='pie')
    line_quality_pie <- line_quality_pie %>%
      layout(title = pieTitle)
    line_quality_pie
  })

  output$scatter_density<-renderPlotly({
    ldata<-fdata %>% filter(ProductCode==input$product_code) %>% select(LineID,QualityClass,ProductCode,X_251,X_371,X_632,X_660,X_956,X_1000)
    sdTitle=paste(input$product_code," : ",input$xaxis," vs. ",input$yaxis)
    ggplot(ldata,aes(x=get(input$xaxis),y=get(input$yaxis),shape=LineID,color=factor(QualityClass)))+
    geom_point(size=4)+
    scale_color_manual(values=c("red","green","purple"))+
    labs(x=input$xaxis,y=input$yaxis,shpae="LineID",color="품질 class")+
    theme_minimal()
  })  
}