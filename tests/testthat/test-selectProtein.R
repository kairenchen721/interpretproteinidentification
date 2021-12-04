
test_that("select protein works", {
  interpretproteinidentification::skipIfNoPyopenms()
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
  
  interpretproteinidentification::install_python(version = 3.7)
  interpretproteinidentification::install_miniconda()
  interpretproteinidentification::installPyopenms()
  
  pathOne <- system.file("extdata", "BSA1_OMSSA.idXML", package = "interpretproteinidentification")
  
  generatedGraphComponents <- 
    interpretproteinidentification::generateBipartiteGraph(pathOne, "")
  component <- interpretproteinidentification::displayComponent(
    generatedGraphComponents, 1
  )
  generatedSubGraph <- 
    interpretproteinidentification::selectProtein(component,
                                                  "P02769|ALBU_BOVIN")
  expect_equal(igraph::V(generatedSubGraph)$name, igraph::V(handMadeGraph)$name)
})

# [END]