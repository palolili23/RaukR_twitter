library("shiny")
source("../01_functions/00_load_libraries.R")
source("../01_functions/03_barplots.R")
library("shinythemes")
timeline <- import(here("03_rawdata", "timeline_top20_bioinf.RData"))

#### INTERFAZ DE USUARIO ####

ui <- fluidPage(theme = shinytheme("lumen"),
                h1(strong("Barplot")),
                h4(em("For different variable")),
                sidebarLayout(sidebarPanel(
                  radioButtons(
                    "Vx",
                    inline = FALSE,
                    width = NULL ,
                    choices = c(
                      "Screen name" = "screen_name",
                      "Source" = "source",
                      "Location" = "location"
                    )
                  ),
                  img(src = 'nametag_7x5.png', width = 200)
                ),
                
                mainPanel(plotOutput("coolplot"))))



##### SERVIDOR #####



server <- function(input, output) {
  output$coolplot <-
    renderPlot({
      print(
        data %>% 
            count(input$Vx, sort = TRUE) %>%
            slice(1:20) %>% 
            ggplot(aes(x = reorder(input$Vx, -n), y = n, fill = input$Vx)) +
            geom_bar(stat = "identity") +
            coord_flip() +
            labs(title = glue("Top twitter {label} in #bioinformatics"),
                 x = glue("{label}")) +
            theme(plot.title = element_text(size = rel(2))) +
            theme_minimal() +
            theme(legend.position="none") +
            scale_fill_manual(
              values = colorRampPalette(
                RColorBrewer::brewer.pal(n = 25, name = "Spectral"))(25),
              guide = guide_legend(reverse = TRUE))
      )})}



###### FINAL ####

shinyApp(ui = ui, server = server) 


