source("config.R",encoding = "UTF-8")

ui <- dashboardPage(
  skin = "blue",
  
  # le DASHBOARD HEADER
  dashboardHeader(title = ""),
  
  
  # le DASHBOARD SIDEBAR
  dashboardSidebar(
    
    
    
    
    # les options sidebar
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    tags$script("$(document).ready(function(){
                        setTimeout(function() {$('.slider-animate-button').click()},1000);
                });"),
    
    
    
    
    sidebarMenu(
      menuItem("Stackoverflow Tech Tracker", tabName = "ONGLET_tracker",icon = icon("stack-overflow")),
      menuItem("What is hype?", tabName = "ONGLET_help", icon = icon("question")),
      menuItem("Github", tabName = "ONGLET_github", icon = icon("github")),
      
      
      #INPUT SELECTOR DE IDs, selected_id
      selectInput(
        inputId = "selected_central_node",
        label = "Tracked tag", 
        choices = central_nodes,
        selected = startingnode
      ),
      sliderInput(inputId = "selected_date_index",
                  label = "Evolution over time (animation)",
                  min = 1,
                  max = length(unique(benefice$date[benefice$central_node == startingnode])),
                  value = 1,
                  step =1,
                  animate = animationOptions(interval = 1000, loop = TRUE))

      
      
      
      
      
    ) # fin de la sidebar menu
    
    
    
    
  ), # fin de la dashboardsidebar
  
  
  
  
  
  # LE DASHBOARD BODY
  dashboardBody(
    
    # Les styles


    

    
    
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: hidden; }"
    ),
    
    
    
    
    
    
    
    
    
    
    
    tabItems(
      
      
      
  
      
      
      
      # Debut onglet tracker
      tabItem(
        tabName = "ONGLET_tracker",
        fluidRow(
          box(
            width = 12,
            status = "primary",
            solidHeader = TRUE,
            title = textOutput("datetitle"),
            bubblesOutput("hypeplot", width = "100%", height = 500)
          )
        )
      ), # FIN ONGLET tracker
      
      
      
      
      
      # début Onglet help
      tabItem(
        tabName = "ONGLET_help",
        fluidRow(
          box(
            width = 7,
            status = "primary",
            solidHeader = TRUE,
            title = "StackOverFlow Questions Tags",
            includeMarkdown("docs/tab1.md")
          )
        ),
        fluidRow(
          box(
            width = 7,
            status = "primary",
            solidHeader = TRUE,
            title = "Hype Definition",
            includeMarkdown("docs/tab2.md")
          )
        )
      ), # fin onglet help
      
      
      # Debut onglet github
      tabItem(
        tabName = "ONGLET_github",
        fluidRow(
          box(
            width = 12,
            status = "primary",
            solidHeader = TRUE,
            title = "Github",
            includeMarkdown("docs/github.md")
          )
        )
      ) # FIN ONGLET github
      
      
      
      
      
      
      
      
    ) # fin de tabitems global
    
    
    ) # fin dashboard body
  
  
    ) # fin dashboard page