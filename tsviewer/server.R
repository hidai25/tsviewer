
library(shiny)
library(forecast)
library(fma)
library(xts)
Data1<-data.frame(read.csv("data/amazon.csv"))
Data2<-data.frame(read.csv("data/facebook.csv"))
Data3<-data.frame(read.csv("data/netflix.csv"))
Data4<-data.frame(read.csv("data/google.csv"))

shinyServer(function(input,output,session){
  MyData <- reactive({
    if(input$RD1==2){
      inFile<-input$file1
      if (is.null(inFile))
        return(NULL)
      read.csv(inFile$datapath, header=input$header, sep=input$sep, 
               quote=input$quote)
    }else{
      
      switch(input$Data,
             "Amazon" = Data1,
             "Facebook" = Data2,
             "Netflix"=Data3,
             "Google"=Data4)
    }
  })
  Data1_xts <- xts(Data1$PX_LAST,as.Date(Data1[,1], format="%m/%d/%Y") )
  Data2_xts <- xts(Data2$PX_LAST,as.Date(Data2[,1], format="%m/%d/%Y") )
  Data3_xts <- xts(Data3$PX_LAST,as.Date(Data3[,1], format="%m/%d/%Y") )
  Data4_xts <- xts(Data4$PX_LAST,as.Date(Data4[,1], format="%m/%d/%Y") )
  fit1 <- auto.arima(Data1_xts)
  fit2 <- auto.arima(Data2_xts)
  fit3 <- auto.arima(Data3_xts)
  fit4 <- auto.arima(Data4_xts)
  
  
  MyData1 <- reactive({
    if(input$RD1==2){
      inFile<-input$file1
      
      if (is.null(inFile))
        return(NULL)
      data <-read.csv(inFile$datapath, header = input$header)
      data_xts <- xts(data[,2],as.Date(data[,1],format="%d/%m/%Y") )
      
    }else{
      
      switch(input$Data,
             "Amazon" = Data1_xts,
             "Facebook" = Data2_xts,
             "Netflix"=Data3_xts,
             "Google"=Data4_xts)
    }
  })
  
  MyData2 <- reactive({
    if(input$RD5==2){
      inFile<-input$file1
      
      if (is.null(inFile))
        return(NULL)
      data <-read.csv(inFile$datapath, header = input$header)
      data_xts <- xts(data[,2],as.Date(data[,1],format="%d/%m/%Y") )
      
    }else{
      
      switch(input$Data5,
             "Amazon" = Data1_xts,
             "Facebook" = Data2_xts,
             "Netflix"=Data3_xts,
             "Google"=Data4_xts)
    }
  })
  
  output$summary<-renderPrint({
    summary(MyData()[,2])
  })
  output$table<-renderDataTable({
    MyData()
  })
  
  
  
  output$PlotG<-renderPlot({
    if(is.null(MyData1())!=T){
      plot.xts(MyData1(),main="",auto.legend = TRUE)
      
    }
  })
  
  output$PlotG1<-renderPlot({
    if(is.null(MyData2())!=T){
      fit <- auto.arima(MyData2())
      plot(fc <- forecast(fit, h = 200))
      #plot.xts(MyData2(),main="",auto.legend = TRUE)
      #TotalTS<-ts(MyData2())
      #InsampleTs<-window(TotalTS)
      #forecast1<-ses(InsampleTs)
      # plot(forecast1,xlab="Time",ylab="Observations")
      # plot.xts(MyData2(),main="",auto.legend = TRUE)
      
    }
  })
  
  
  
})