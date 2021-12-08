

# hand make the graph (same way as gBG), then check that it is the right component returned
test_that("display components works", {
  allEdges <- c(
    "SHC(Carbamidomethyl)IAEVEK",
    "P02769",
    "LAMTLAEAER",
    "A9GID7",
    "KSDDGGEVEK",
    "A9G8G1",
    "LAMTLAEAER",
    "A9GID7",
    "YIC(Carbamidomethyl)DNQDTISSK",
    "P02769",
    "DDSPDLPK",
    "P02769",
    "C(Carbamidomethyl)C(Carbamidomethyl)TESLVNR",
    "P02769",
    "EC(Carbamidomethyl)C(Carbamidomethyl)DKPLLEK",
    "P02769", 
    "LALDLVVR",
    "A9GN44",
    "LC(Carbamidomethyl)VLHEK",
    "P02769",
    "C(Carbamidomethyl)C(Carbamidomethyl)TESLVNR",
    "P02769",
    "EC(Carbamidomethyl)C(Carbamidomethyl)DKPLLEK",
    "P02769",
    "LC(Carbamidomethyl)VLHEK",
    "P02769",
    "YIC(Carbamidomethyl)DNQDTISSK",
    "P02769",
    "EC(Carbamidomethyl)C(Carbamidomethyl)DKPLLEK",
    "P02769",
    "DLGEEHFK",
    "P02769",
    "DLGEEHFK",
    "P02769",
    "GM(Oxidation)LWAVFEQK",
    "A9GV08",
    "DLGEEHFK",
    "P02769",
    "YIC(Carbamidomethyl)DNQDTISSK",                
    "P02769",
    "LVTDLTK",
    "P02769",
    "DLGEEHFK",
    "P02769",
    "LC(Carbamidomethyl)VLHEK",
    "P02769",
    "LC(Carbamidomethyl)VLHEK",
    "P02769",
    "LAADDFR",
    "Q14532",
    "LAADDFR",
    "O76014",
    "LAADDFR",
    "O76015",
    "LAADDFR",
    "O76013",
    "LAADDFR",
    "Q92764",
    "LAADDFR",
    "Q15323",
    "LAADDFR",
    "Q14525",
    "GAC(Carbamidomethyl)LLPK",
    "P02769",
    "DLGEEHFK",
    "P02769",
    "AEFVEVTK",                                     
    "P02769",
    "GAC(Carbamidomethyl)LLPK",
    "P02769",
    "AEFVEVTK",
    "P02769",
    "EAC(Carbamidomethyl)FAVEGPK",
    "P02769",
    "GAC(Carbamidomethyl)LLPK",
    "P02769",
    "AGAFSLPK",
    "A9G0B6",
    "VATVSLPR",                                     
    "P00761",
    "EAC(Carbamidomethyl)FAVEGPK",
    "P02769",
    "AGDLLFFK",
    "A9FUD7",
    "HLVDEPQNLIK",
    "P02769",
    "YLYEIAR",
    "P02769",
    "YLYEIAR",
    "P02769",
    "YLYEIAR",
    "P02769",
    "LVVSTQTALA",
    "P02769",
    "HLVDEPQNLIK",                                  
    "P02769",
    "HLVDEPQNLIK",
    "P02769",
    "LKPDPNTLC(Carbamidomethyl)DEFK",
    "P02769"
  )
  
  handMadeGraph <- igraph::make_graph(allEdges, directed = FALSE)
  handMadeGraph <- igraph::simplify(handMadeGraph)
  handMadeGraphComponents <- igraph::decompose(handMadeGraph, mode = c("weak"))
  
  generatedGraph <- interpretproteinidentification::generateBipartiteGraph(
    allEdges, "")
  
  for (i in 1:length(handMadeGraphComponents)) {
    displayedGeneratedComponent <- interpretproteinidentification::displayComponent(generatedGraph, i)
    generatedVertexNames <- igraph::V(displayedGeneratedComponent)$name
    handMadeVertexName <- igraph::V(handMadeGraphComponents[[i]])$name
    expect_equal(generatedVertexNames, handMadeVertexName)
  }
})

# [END]