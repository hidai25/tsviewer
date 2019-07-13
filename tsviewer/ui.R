library(shiny)
library(shinythemes)


shinyUI(navbarPage(
  theme = shinytheme("flatly"),
  strong("Time Series upload and visualize"),
  tabPanel("About",
           h3(strong("Introduction")),
           br(),
           p("This App can be used as a simple tool visualize stocks prices and see them on a plot",align="Justify"),
           p("The first part presents the summary of data you choose to analyze. The user can either upload his/her own data or use the  data we put of the FANG stocks.  ",align="Justify"),
           p("In case users want to upload their own data set, the suggested form of data frame is that time in the first column and observation in the second column. However, once the files is uploaded in the required form, the app will definitely work.",align="Justify"),
           br(),
           h3(strong("Author")),
           h5(strong("Hidai Bar-Mor"))
           
  ),
  
  
  
  tabPanel("Data Summary",
           sidebarLayout(
             sidebarPanel(
               radioButtons("RD1",label=h3(strong("Data Type")),choices = list("Different stocks historical dataset"=1,"Your Data"=2),selected = 1),
               
               conditionalPanel(condition="input.RD1==2",fileInput('file1', h4(strong('Choose csv File')),
                                                                   accept=c('text/csv', 
                                                                            'text/comma-separated-values,text/plain', 
                                                                            '.csv'))),
               selectInput("Data", "Choose Stock to analyze:", 
                           choices =  c("Amazon","Facebook","Netflix","Google"), selected = "Amazon")
               
             ),
             mainPanel(fluidRow(
               column(10,h3("Stock Price Table"),dataTableOutput("table")),
               column(10,h3("Summary"),verbatimTextOutput("summary")),
               column(10,h3("Plot"),plotOutput("PlotG"))))
             
           )), 
  
  tabPanel("Regression",
           sidebarLayout(
             sidebarPanel(
               
               'Linear regression analysis of the dataset',
               radioButtons("RD5",label=h3(strong("Data Type")),choices = list("Different stocks historical dataset"=1,"Your Data"=2),selected = 1),
               
               conditionalPanel(condition="input.RD5==2",fileInput('file1', h4(strong('Choose csv File')),
                                                                   accept=c('text/csv', 
                                                                            'text/comma-separated-values,text/plain', 
                                                                            '.csv'))),
               
               
               selectInput("Data5", "Choose Stock to analyze:", 
                           choices =  c("Amazon","Facebook","Netflix","Google"), selected = "Amazon")
               
             ),
             
             mainPanel(
               fluidRow(
                 h3('Arima'),
                 p('In time series analysis, an autoregressive integrated moving average (ARIMA) model is a generalization of an autoregressive moving average (ARMA) model. Both of these models are fitted to time series data either to better understand the data or to predict future points in the series (forecasting)',align='justify'),
                 
                 
                 #fit <- auto.arima(Data1_xts),
                 #plot(fc <- forecast(fit, h = 15))
                 column(10,h3(""),plotOutput("PlotG1"))
               )
             )
           ))
  
  
  
  
  
  
)
)