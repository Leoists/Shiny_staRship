library(shiny);
library(rgl);
library(DT);
library(bslib);

ui <- fluidPage(
  theme = bs_theme(primary = "#2E302E", base_font = font_google("Share Tech"), 
                   code_font = font_google("Share Tech Mono"), heading_font = font_google("Audiowide"), 
                   font_scale = NULL, `enable-transitions` = FALSE, spacer = "0.3rem", 
                   bootswatch = "cyborg"),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "starship.css")
  ),
  
  # Narrow banner with logo?
  titlePanel(span(img(src = "staRship.gif", height = 50, align = "left")
                  ,HTML('&emsp;')
                  ,"staRship",tags$br(),tags$h4("the retro open source space webgame"))
             ,windowTitle='StaRship'
  ),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      # Table of ship statistics
      span(tags$b("Ship Status"),class='control_panel_green'),
      tags$img(src = "starship_diagram_placeholder.jpg", width = "200px"),
      DT::dataTableOutput("ship_stats",width = "200px"),
      
      # Scrollable div
      tags$div(id = "scrollable", 
               style = "overflow-y: scroll; height: 300px;",
      ),
      
      # Debug button
      if(file.exists('.debug')){actionButton("debug","Debug")},
      width=2
    ),
    
    # Main content area
    mainPanel(
      tabsetPanel(
        tabPanel("Starmap", 
                 rglwidgetOutput("starmap"),
                 tags$br(),
                 DT::dataTableOutput("destinations"),
                 actionButton("continue", "Continue to current destination"),
                 actionButton("new_destination", "Choose new destination"),
                 actionButton("probes", "Send probes"),
                 actionButton("colony", "Start colony")
        ),
        tabPanel("Ship Log", DT::dataTableOutput("ship_log")),
        tabPanel("Event",class='event_container'
                 ,div(id='event_top_container'
                      ,img(src="event_example.gif",width="800vw")
                      ,textOutput('event_output'))
                 ,actionButton("events/overwhelmed/runscanners","Keep the scanners running.")
                 ,actionButton("events/overwhelmed/flyblind","Fly blind.")
                 ),
        tabPanel("About", tags$div(id = "about_output"))
      )
    )
  )
)
