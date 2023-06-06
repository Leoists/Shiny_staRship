#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny);
library(rgl);
library(DT);
library(bslib);
library(dplyr);
li <- tags$li
ul <- tags$ul 


parralaxFiles <- list.files("www/images",pattern = ".png",full.names = TRUE)
# Define UI for application that draws a histogram
ui <- fillPage(
  theme = bs_theme(primary = "#2E302E", base_font = font_google("Share Tech"),
                   code_font = font_google("Share Tech Mono"), heading_font = font_google("Audiowide"),
                   font_scale = NULL, `enable-transitions` = FALSE, spacer = "0.3rem",
                   bootswatch = "cyborg"),

  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles01.css"),
    tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/parallax/3.1.0/parallax.min.js")
  ),
  mapply(function(xx,dd){li(class="layer",`data-depth`=dd,img(src = xx))}
         ,parralaxFiles
         ,seq(0.05,0.4,along.with = parralaxFiles)
         ,SIMPLIFY = FALSE) %>% ul(id = "parallax-scene"),
  img(src="./www/images/stars00.png")
  

)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
app <- shinyApp(ui = ui, server = server)
