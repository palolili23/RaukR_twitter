
#library(rtweet)
#tw.bio <- get_timelines("bioinformatics",
#                        n = 10000,
#                       language = 'en',
#                      since = '2018-01-01',
#                      until = '2019-06-01',
#                      token = token)

library(shiny)
ui <- fluidPage(
  titlePanel("Tweet Research"),
  navbarPage("",
             tabPanel("Component 1",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("radio-button",label="radioButtons",choices=c("A","B","C"),inline=T)
                        ),
                        
                        mainPanel(
                          plotOutput("distPlot")
                        ))),
             tabPanel("Component 2"),
             tabPanel("Component 3")
)
)
server <- function(input,output){}
shinyApp(ui=ui,server=server)