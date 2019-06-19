
setwd("/Users/yisun086/Desktop/RaukR/twitter_proj/RaukR_twitter/06_shiny")
load("twitter_R_Python_data.RData")
n <-3

library(ggplot2)
library(wordcloud2)
library(shiny)


ui <- fluidPage(
  tags$img(height=100,width=100,
           src="logo.png"),
  h1("Twitter data research"),

  #titlePanel("Twitter Research"),
  navbarPage("",
             tabPanel("Component 1",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("data_input",label="Select data",
                                      choices=c("Rstudio.source","Python.source")),
                          textInput(inputId="title",label="Write your plot title here",
                                    value="Barplot for Top 10 Twitter Source")
                        ),
                        
                        mainPanel(
                          plotOutput("plot_output")
                        ))),
             tabPanel("Component 2",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("data_input2",label="Select data",
                                      choices=c("R.name")),
                          bootstrapPage(
                            numericInput('size', 'Size of wordcloud', n)
                            
                          )
                        ),
                        
                        mainPanel(
                          wordcloud2Output('wordcloud2')
                        ))
                      
                      
                      #bootstrapPage(
                      #numericInput('size', 'Size of wordcloud', n),
                      # wordcloud2Output('wordcloud2')
                      # )
             ),
             #mainPanel(
             #plotOutput("plot_output")
             #))),
             tabPanel("Component 3")
  )
)
server <- function(input,output){
  # getdata1 <- reactive({ get(input$data_input) })
  getdata2 <- reactive({ get(input$data_input2) })
   # output$plot_output <- renderPlot({
     # ggplot(data=getdata1(),aes(x=source,y=Freq))+
       # geom_bar(stat="identity",fill="steelblue")+
       # ggtitle(isolate(input$title))+
       # theme(
         # axis.text.x=element_text(angle=90,hjust=1,vjust=0.5,size=15),
         # plot.title = element_text(color="steelblue", size=17, face="bold.italic")
       # )
   # })
  
  output$wordcloud2 <- renderWordcloud2({
    #wordcloud2(getdata2(), size=input$size)
    letterCloud(getdata2(), size=input$size,word = "R", color='random-light' , backgroundColor="black")
  })
}

shinyApp(ui=ui,server=server)