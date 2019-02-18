shinyServer(function(input, output, session) {
  
  # reactive dataframe qui contient les informations du central node selected
  central_node_df <- reactive({
    build_centralnode_df(param_central_node = input$selected_central_node,
                         param_top_n =15,
                         param_bottom_n = 15)
  })
  
  # List de bubbles reactives
  bubbles <- reactive ({
    bubbles = build_bubbles(central_node_df(),input$selected_date_index)
  })
  
  # Le plot bubbles hype
  output$hypeplot <- renderBubbles({
    bubbles()$hypest
  })
  
  # # Le plot bubbles worst
  # output$worstplot <- renderBubbles({
  #   bubbles()$worst
  # })
  
  # MAJ du slider input date index
  observeEvent(input$selected_central_node,{
    ndates = length(unique(benefice$date[benefice$central_node == input$selected_central_node]))
    updateSliderInput(session, "selected_date_index",
                      value = 1,
                      min = 1,
                      max = ndates,
                      step = 1)
  })
  
  
  whichdate <-reactive({
    tempdf = central_node_df()$hype
    alldates = names(tempdf)
    solution = alldates[input$selected_date_index]
    solution
  })
  
  output$datetitle <- renderText({
    x = paste0("Hypest stackoverflow tags associated to the ",input$selected_central_node," tag in ", whichdate())
    x
  })
  
  

  
  
})