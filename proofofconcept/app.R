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

parralaxFiles <- list.files("www",pattern = ".png",full.names = FALSE,recursive=TRUE)
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
  tags$script(HTML( 
        "
        var scene = document.getElementById('parallax-scene');
        var parallaxInstance = new Parallax(scene, {
            relativeInput: true
        });

        // get all the image elements inside .layer
        var images = document.querySelectorAll('.layer img');
        
        // loop over each image and set its scale
        for (var i = 0; i < images.length; i++) {
            var scale = 1 + i * 0.5; 
            // this will give 1.0 for the first image, 1.1 for the second, 1.2 for the third, etc.
            images[i].style.transform = 'scale(' + scale + ')';
        }
        "
    ))

)

# Define server logic required to draw a histogram
server <- function(input, output) {

}

# Run the application 
app <- shinyApp(ui = ui, server = server)
