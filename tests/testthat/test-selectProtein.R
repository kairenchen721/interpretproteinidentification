



# also for an vertex that is not in it
test_that("select protein works", {
  myProteins <- c(
    "SHC(Carbamidomethyl)IAEVEK",
    "P02769|ALBU_BOVIN",                           
    "YIC(Carbamidomethyl)DNQDTISSK",                
    "DDSPDLPK",                                    
    "C(Carbamidomethyl)C(Carbamidomethyl)TESLVNR",  
    "EC(Carbamidomethyl)C(Carbamidomethyl)DKPLLEK",
    "LC(Carbamidomethyl)VLHEK",                     
    "DLGEEHFK",                                    
    "LVTDLTK",                                      
    "GAC(Carbamidomethyl)LLPK",                    
    "AEFVEVTK",                                     
    "EAC(Carbamidomethyl)FAVEGPK",                 
    "HLVDEPQNLIK",                                  
    "YLYEIAR",                                     
    "LVVSTQTALA",                                   
    "LKPDPNTLC(Carbamidomethyl)DEFK"   
  )
  handMadeGraph <- igraph::make_graph(myProteins, directed = FALSE)
  handMadeGraph <- igraph::simplify(handMadeGraph)
  
  generatedGraphComponents <- interpretproteinidentification::generateBipartiteGraph(file.path(getwd(), "BSA1_OMSSA.idXML"), file.path(getwd(), "BSA1_OMSSA_AFter.idXML"))
  component <- interpretproteinidentification::displayComponent(graph, 1)
  generatedSubGraph <- interpretproteinidentification::selectProtein(component, "P02769|ALBU_BOVIN")
  expect_equal(igraph::V(generatedSubGraph)$name, igraph::V(handMadeGraph)$name)
})
