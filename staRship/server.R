#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$starmap <- renderRglwidget({
    clear3d()
    #dat <- iris[, c(input$plot_x, input$plot_y, input$plot_z, "Species")]
    #dat$id <-as.character(seq_len(nrow(iris)))
    #@rglids <<- ;
    #plot3d(x = dat[, 1:3], type = "s", size = 1, col = as.integer(iris[, "Species"]), aspect = TRUE)
    sharedData <<- rglShared(id = rglStarChart(foo)['data']); #rglids['data'])
                             # text3d(dat[, 1:3], text = dat[, "id"], adj = -0.5),
                             # group = "SharedData_plot_3D_ids",
                             # deselectedFade = 0,
                             # selectedIgnoreNone = FALSE)
    bg3d(texture='www/starmap_background.png',color='white');
    rglwidget(shared=sharedData);
    # shinyResetBrush(session, "rgl_3D_brush")
    # rglwidget(shared = sharedData,
    #           shinyBrush = "rgl_3D_brush")
  });
  
  output$ship_stats <- DT::renderDataTable({
    shipdat <- shipReport(foo) %>% 
      mutate(.,status=case_when(
               rownames(.) %in% c('colonists','probes') ~ prettyNum(status)
               ,rownames(.) == 'traveled' ~ sprintf('%.2f LY',status*10)
               ,TRUE ~ sprintf('%.2f%%',status)));
    datatable(shipdat,style='bootstrap',colnames = '',selection = 'none'
              ,options=list(dom='t',ordering=F,bFilter=0,bInfo=0
                            ,scrollX=F,autoWidth=F,width="195px"))})
  
  output$event_output <- renderText("The seedship's course takes it through a dense star-forming nebula. Hundreds of infant suns illuminate clouds of interstellar gas and fill the sky with riotous color. Clouds twist through complex gravitational interference patterns and glitter with heavy elements formed in the death throes of the last generation of stars. \n\nThe scanners were not designed to deal with this level of input, and it is threatening to overwhelm them. If the AI continues to use the scanners to navigate, it can tell that the gravity_scanner will be damaged. Shutting off the scanners, however, would leave the seedship vulnerable to collisions in this crowded area of space.");
  
  output$ship_log <- DT::renderDataTable({
    datatable(foo$log[,c('stardate','description')],rownames = F,style = 'bootstrap')});
  
})
