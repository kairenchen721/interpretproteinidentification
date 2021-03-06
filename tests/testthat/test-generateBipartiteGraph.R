test_that("reading into graph works", {
  allEdges <- c(
    "SHC(Carbamidomethyl)IAEVEK",
    "P02769|ALBU_BOVIN",
    "LAMTLAEAER",
    "tr|A9GID7|A9GID7_SORC5",
    "KSDDGGEVEK",
    "tr|A9G8G1|A9G8G1_SORC5",
    "LAMTLAEAER",
    "tr|A9GID7|A9GID7_SORC5",
    "YIC(Carbamidomethyl)DNQDTISSK",
    "P02769|ALBU_BOVIN",
    "DDSPDLPK",
    "P02769|ALBU_BOVIN",
    "C(Carbamidomethyl)C(Carbamidomethyl)TESLVNR",
    "P02769|ALBU_BOVIN",
    "EC(Carbamidomethyl)C(Carbamidomethyl)DKPLLEK",
    "P02769|ALBU_BOVIN", 
    "LALDLVVR",
    "tr|A9GN44|A9GN44_SORC5",
    "LC(Carbamidomethyl)VLHEK",
    "P02769|ALBU_BOVIN",
    "C(Carbamidomethyl)C(Carbamidomethyl)TESLVNR",
    "P02769|ALBU_BOVIN",
    "EC(Carbamidomethyl)C(Carbamidomethyl)DKPLLEK",
    "P02769|ALBU_BOVIN",
    "LC(Carbamidomethyl)VLHEK",
    "P02769|ALBU_BOVIN",
    "YIC(Carbamidomethyl)DNQDTISSK",
    "P02769|ALBU_BOVIN",
    "EC(Carbamidomethyl)C(Carbamidomethyl)DKPLLEK",
    "P02769|ALBU_BOVIN",
    "DLGEEHFK",
    "P02769|ALBU_BOVIN",
    "DLGEEHFK",
    "P02769|ALBU_BOVIN",
    "GM(Oxidation)LWAVFEQK",
    "tr|A9GV08|A9GV08_SORC5",
    "DLGEEHFK",
    "P02769|ALBU_BOVIN",
    "YIC(Carbamidomethyl)DNQDTISSK",                
    "P02769|ALBU_BOVIN",
    "LVTDLTK",
    "P02769|ALBU_BOVIN",
    "DLGEEHFK",
    "P02769|ALBU_BOVIN",
    "LC(Carbamidomethyl)VLHEK",
    "P02769|ALBU_BOVIN",
    "LC(Carbamidomethyl)VLHEK",
    "P02769|ALBU_BOVIN",
    "LAADDFR",
    "Q14532|K1H2_HUMAN",
    "LAADDFR",
    "O76014|KRT37_HUMAN",
    "LAADDFR",
    "O76015|KRT38_HUMAN",
    "LAADDFR",
    "O76013|KRT36_HUMAN",
    "LAADDFR",
    "Q92764|KRT35_HUMAN",
    "LAADDFR",
    "Q15323|K1H1_HUMAN",
    "LAADDFR",
    "Q14525|KT33B_HUMAN",
    "GAC(Carbamidomethyl)LLPK",
    "P02769|ALBU_BOVIN",
    "DLGEEHFK",
    "P02769|ALBU_BOVIN",
    "AEFVEVTK",                                     
    "P02769|ALBU_BOVIN",
    "GAC(Carbamidomethyl)LLPK",
    "P02769|ALBU_BOVIN",
    "AEFVEVTK",
    "P02769|ALBU_BOVIN",
    "EAC(Carbamidomethyl)FAVEGPK",
    "P02769|ALBU_BOVIN",
    "GAC(Carbamidomethyl)LLPK",
    "P02769|ALBU_BOVIN",
    "AGAFSLPK",
    "tr|A9G0B6|A9G0B6_SORC5",
    "VATVSLPR",                                     
    "P00761|TRYP_PIG",
    "EAC(Carbamidomethyl)FAVEGPK",
    "P02769|ALBU_BOVIN",
    "AGDLLFFK",
    "tr|A9FUD7|A9FUD7_SORC5",
    "HLVDEPQNLIK",
    "P02769|ALBU_BOVIN",
    "YLYEIAR",
    "P02769|ALBU_BOVIN",
    "YLYEIAR",
    "P02769|ALBU_BOVIN",
    "YLYEIAR",
    "P02769|ALBU_BOVIN",
    "LVVSTQTALA",
    "P02769|ALBU_BOVIN",
    "HLVDEPQNLIK",                                  
    "P02769|ALBU_BOVIN",
    "HLVDEPQNLIK",
    "P02769|ALBU_BOVIN",
    "LKPDPNTLC(Carbamidomethyl)DEFK",
    "P02769|ALBU_BOVIN"
  )
  
  handMadeGraph <- igraph::make_graph(allEdges, directed = FALSE)
  handMadeGraph <- igraph::simplify(handMadeGraph)

  generatedGraph <- interpretproteinidentification::generateBipartiteGraph(allEdges, "")

  generatedVertexNames <- igraph::V(generatedGraph)$name
  handMadeVertexName <- igraph::V(handMadeGraph)$name
  expect_equal(generatedVertexNames, handMadeVertexName)

  
  # this is meant to compare edges, but this comparison is not supported by expect_equal
  # for (i in 1:length(generatedGraphComponents)) {
  #   generatedEdgeNames <- igraph::E(generatedGraphComponents[[i]])
  #   handMadeEdgeName <- igraph::E(handMadeGraphComponents[[i]])
  # 
  #   expect_equal(generatedEdgeNames, handMadeEdgeName)
  # }

})

# [END]