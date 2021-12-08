# GenerateBipartiteGraph.R
# Author: Kai Ren Chen (kairen.chen@mail.utoronto.ca)
# Date: December 8, 2021

library(shiny)
options(shiny.maxRequestSize = 30*1024^2)

ui <- shiny::fluidPage(
  shiny::sidebarPanel(
    shiny::fileInput(
      inputId = "file1",
      label = "upload a file",
      multiple = FALSE,
      accept = c(".idXML",
                 ".osw",
                 ".rda"),
      width = NULL,
      buttonLabel = "Browse...",
      placeholder = "No file selected"),
    
    # actionButton
    shiny::actionButton(
      inputId = "button1",
      label = "Run"), 
    
    shiny::textInput(inputId = "component", label = "component", value = "1"),
    
    shiny::textInput(inputId = "vertex.label.cex", label = "label size", "0.05"),
    shiny::textInput(inputId = "vertex.frame.color", label = "vertex's frame color", NA),
    shiny::textInput(inputId = "vertex.size", label = "size of vertex", "20"),
    shiny::textInput(inputId = "vertex.color", label = "color of vertex", "SkyBlue2"),
    
    shiny::actionButton(
      inputId = "button2",
      label = "plot"), 
    
    shiny::actionButton(
      inputId = "button3",
      label = "test"), 
  ),
  
  # Main panel for displaying outputs ----
  shiny::mainPanel(
    
    # Output: Tabset w/ plot, summary, and table ----
    shiny::tabsetPanel(
      type = "tabs",
      # 1st, what you will see, 2nd is what it is referred as
      shiny::tabPanel("Plot1", shiny::plotOutput("Plot1")),
      shiny::tabPanel("Output1", shiny::verbatimTextOutput("Output1")),
      shiny::tabPanel("test", shiny::verbatimTextOutput("test"))
    )
  )
)

server <- function(input, output) {
  displayVertices <- shiny::eventReactive(eventExpr = input$button1, {
    interpretproteinidentification::readSQLiteFile(
      OSWFilePath = input$file1$datapath)
  })
  
  output$Output1 <- shiny::renderPrint({
    if (!is.null(displayVertices)) {
      displayVertices()
    }
  })
  
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
          #1
          as.integer(input$component)
        )
    
    igraph::plot.igraph(componentWanted,
                        vertex.label.cex = as.numeric(input$vertex.label.cex),
                        vertex.frame.color = NA,
                        vertex.size = as.numeric(input$vertex.size),
                        vertex.color = input$vertex.color
                        )
  })
  
  output$Plot1 <- shiny::renderPlot({
    if (!is.null(displayComponent)) {
      displayComponent()
    }
  })
  
  
  
  
  testingFunction <- shiny::eventReactive(eventExpr = input$button3, {
    input$component
  })
  
  output$test <- shiny::renderPrint({
    if (!is.null(testingFunction)) {
      testingFunction()
    }
  })

}

shiny::shinyApp(ui = ui, server = server)
# [END]
