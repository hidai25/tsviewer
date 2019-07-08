library(shiny)
library(shinythemes)

Data1<-data.frame(read.csv("data/amazon.csv"))
Data2<-data.frame(read.csv("data/facebook.csv"))
Data3<-data.frame(read.csv("data/netflix.csv"))
Data4<-data.frame(read.csv("data/google.csv"))


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
                                 choices =  c("Amazon","Facebook","Netflix","Google"), selected = "Amazon"),
                     ## render dynamic checkboxes
                     uiOutput("show_vars")
                 ),
                 mainPanel(fluidRow(
                     column(10,h3("Stock Price Table"),dataTableOutput("table")),
                     column(10,h3("Summary"),verbatimTextOutput("summary")),
                     column(10,h3("Plot"),plotOutput("PlotG"))))
                 
             )), 
    
    tabPanel("Naive Method",
                        sidebarLayout(
                            sidebarPanel(
                                
                                'Naive Method Does not Need any Parameter.'
                            ),
                            
                            mainPanel(
                                fluidRow(
                                    h3('Model Introduction'),
                                    p('Naive forecasts are the most cost effective forecasting model. Generally, it just use the value of past to predict the near future',align='justify'),
                                    
                                    column(10,h4(strong('Forecasting Plot')),plotOutput("Plot0")),
                                    
                                    column(10,h4(strong('Accuracy Table')),tableOutput("accu0")),
                                    
                                    column(10,h4(strong('Accuracy Bar Plot')),plotOutput("Plot00"))
                                )
                            )
                        ))
    
    
    
    
    
    
)
)
