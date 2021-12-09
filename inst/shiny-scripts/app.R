# app.R
# Author: Kai Ren Chen (kairen.chen@mail.utoronto.ca)
# Date: December 8, 2021

library(shiny)
options(shiny.maxRequestSize = 30*1024^2)

ui <- shiny::fluidPage(
  shiny::sidebarPanel(
    
    shiny::tags$p("please only use osw files.
                  please enter a vertex name before clicking plot protein"),
    
    shiny::fileInput(
      inputId = "file1",
      label = "upload a file",
      multiple = FALSE,
      accept = c(".osw"),
      width = NULL,
      buttonLabel = "Browse...",
      placeholder = "No file selected"),
    

    
    shiny::textInput(inputId = "component", label = "component", value = "1"),
    
    shiny::textInput(inputId = "vertex.label.cex", label = "label size", "0.5"),
    shiny::textInput(inputId = "vertex.frame.color", label = "vertex's frame color", NA),
    shiny::textInput(inputId = "vertex.size", label = "size of vertex", "20"),
    shiny::textInput(inputId = "vertex.color", label = "color of vertex", "SkyBlue2"),
    
    shiny::textInput(inputId = "protein", label = "which protein"),
    
    # actionButton
    shiny::actionButton(
      inputId = "button1",
      label = "Extract Matches"), 
    
    shiny::actionButton(
      inputId = "button2",
      label = "plot component"), 
    
    shiny::actionButton(
      inputId = "button3",
      label = "plot protein"), 
    
    # shiny::actionButton(
    #   inputId = "button4",
    #   label = "test"), 
  ),
  
  # Main panel for displaying outputs ----
  shiny::mainPanel(
    
    # Output: Tabset w/ plot, summary, and table ----
    shiny::tabsetPanel(
      type = "tabs",
      # 1st, what you will see, 2nd is what it is referred as
      shiny::tabPanel("Component Plot", shiny::plotOutput("ComponentPlot")),
      shiny::tabPanel("Matches Output", shiny::verbatimTextOutput("MatchesOutput")),
      # shiny::tabPanel("test", shiny::verbatimTextOutput("test")),
      shiny::tabPanel("Protein Plot", shiny::plotOutput("ProteinPlot"))
    )
  )
)

server <- function(input, output) {
  
  # display the protein peptide matches
  displayMatches <- shiny::eventReactive(eventExpr = input$button1, {
    interpretproteinidentification::readSQLiteFile(
      OSWFilePath = input$file1$datapath)
  })
  
  output$MatchesOutput <- shiny::renderPrint({
    if (!is.null(displayMatches)) {
      displayMatches()
    }
  })
  
  # display a component of the protein peptide graph
  displayComponent <- shiny::eventReactive(eventExpr = input$button2, {
    peptideProteinEdgeVector <- interpretproteinidentification::readSQLiteFile(
      OSWFilePath = input$file1$datapath)
    
    wholeGraph <-
      interpretproteinidentification::generateBipartiteGraph(
        peptideProteinEdgeVector = peptideProteinEdgeVector,
        inferredProteinVector = "")
    
    componentWanted <-
      interpretproteinidentification::displayComponent(
          wholeGraph,
          as.integer(input$component)
        )
    
    igraph::plot.igraph(componentWanted,
                        vertex.label.cex = as.numeric(input$vertex.label.cex),
                        vertex.frame.color = NA,
                        vertex.size = as.numeric(input$vertex.size),
                        vertex.color = input$vertex.color,
                        rescale = TRUE,
                        ylim = c(-0.7,0.7),
                        xlim = c(-0.7,0.7),
                        asp = 1)
  })
  
  output$ComponentPlot <- shiny::renderPlot({
    if (!is.null(displayComponent)) {
      displayComponent()
    }
  })

  # display all neighbours of a protein/peptide
  displayVertices <- shiny::eventReactive(eventExpr = input$button3, {
    peptideProteinEdgeVector <- interpretproteinidentification::readSQLiteFile(
      OSWFilePath = input$file1$datapath)
    
    wholeGraph <-
      interpretproteinidentification::generateBipartiteGraph(
        peptideProteinEdgeVector = peptideProteinEdgeVector,
        inferredProteinVector = "")
    
    componentWanted <-
      interpretproteinidentification::displayComponent(
        wholeGraph,
        as.integer(input$component)
      )
    
    proteinWanted <- interpretproteinidentification::selectProtein(
      componentWanted,
      input$protein
    )$graph
    
    igraph::plot.igraph(proteinWanted, 
                        vertex.label.cex = as.numeric(input$vertex.label.cex),
                        vertex.frame.color = NA,
                        vertex.size = as.numeric(input$vertex.size),
                        vertex.color = input$vertex.color, 
                        rescale = TRUE,
                        ylim = c(-0.7,0.7),
                        xlim = c(-0.7,0.7),
                        asp = 1)
  })
  
  output$ProteinPlot <- shiny::renderPlot({
    if (!is.null(displayVertices)) {
      displayVertices()
    }
  })
  

  # testingFunction <- shiny::eventReactive(eventExpr = input$button3, {
  #   input$component
  # })
  # 
  # output$test <- shiny::renderPrint({
  #   if (!is.null(testingFunction)) {
  #     testingFunction()
  #   }
  # })

}

shiny::shinyApp(ui = ui, server = server)
# [END]
