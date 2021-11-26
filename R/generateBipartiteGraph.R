#' Generate a Graph based on Peptide and Protein
#'
#' \code{generateBipartiteGraph} Based on what protein mapped to peptide
#' identified from mass spectrometry, a graph, specifically a bipartite graph, is
#' drawn.
#'
#' It first uses the pyopenms package to parse the given file in idXML format,
#' and iterate through the file to obtain a mapping of protein accession to
#' peptide sequence, which is then used by function from the igraph package to
#' generate the graph, then decompose into weakly connected components
#' This bipartite graph consist of a set of vertices that represent proteins 
#' and a set of vertices that represent peptides. The edges between protein 
#' vertices and peptide vertices represent protein-peptide matches. protein 
#' accession, peptide identifiers will be displayed at this layer.
#' An idXML consist of a peptide identification object and a protein 
#' identification object
#'
#' @param preInferenceFilePath The file path pointing toward the file before
#'   protein inference it contains all possible protein, and all identified
#'   peptides
#' @param postInferenceFilePath The file path pointing toward the file after
#'   protein inference it contains all identified proteins
#'   
#' @return It will return a graph that include all mapping of protein 
#' to peptides
#' 
#' @examples 
#' preInferenceFilePath <-  system.file("extdata", "BSA1_OMSSA.idXML", package = "interpretproteinidentification")
#' interpretproteinidentification::generateBipartiteGraph(preInferenceFilePath, "")
#' @import reticulate
#' @import igraph
#' @export
generateBipartiteGraph <- function(preInferenceFilePath,
                                   postInferenceFilePath){
  # # testing file
  # download.file("https://github.com/OpenMS/OpenMS/raw/master/share/OpenMS/
  # examples/BSA/BSA1_OMSSA.idXML", "BSA1_OMSSA.idXML")
  # preInferenceFilePath <- "BSA1_OMSSA.idXML"
  
  # import python package
  ropenms <- reticulate::import("pyopenms", convert = FALSE)
  
  # basically when using an python package you need to use $ instead of :: 
  # to access thing in the packge
  idXML <- ropenms$IdXMLFile()
  
  
  # this is a function
  preInferenceLoadedVector <- loadFileIntoVector(preInferenceFilePath)
  # print(paste0("file loaded into R object"))
  
  peptideIdentificationObjectVector <- preInferenceLoadedVector$peptide
  
  proteinIdentificationObjectVector <- preInferenceLoadedVector$protein
  
  # the protein is that 
  
  #find out how many edges there are
  numPeptideProteinsEdge <- findNumEdges(peptideIdentificationObjectVector)
  # print(paste0("number of edges found"))
  
  # so every row before this ordinal is populated
  # it starts at 1 (meaning that the 0th row is population) there is no 0th 
  # row so, no row is populated
  ordinalElementPopulated <- 1
  peptideProteinEdgeVector <- character(length = numPeptideProteinsEdge*2)
  
  # iterate over the peptides 
  for (peptideIDNum in seq(along = peptideIdentificationObjectVector)) {
      peptideHits <- peptideIdentificationObjectVector[[peptideIDNum]]$getHits()
      
      for (peptideHitNum in seq(along = peptideHits)) {
          peptideEvidenceVector <- peptideHits[[peptideHitNum]]$getPeptideEvidences()
          
          for (peptideEvidenceNum in seq(along = peptideEvidenceVector)) {
              proteinAccession <- toString(peptideEvidenceVector
                                           [[peptideHitNum]]$getProteinAccession())
              peptideSequence <- toString(peptideHits[[peptideEvidenceNum]]$getSequence())
                
              # every time an element is populated, we increase the ordinal 
              # which every element before it (not including itself) is 
              # populated. e.g. if the ordinal is 5, that means every element 
              # before the 5th element, (the 1st, 2nd, 3rd, 4th element) is 
              # populated 
              peptideProteinEdgeVector[ordinalElementPopulated] <- peptideSequence
              peptideProteinEdgeVector[ordinalElementPopulated + 1] <- 
                proteinAccession
              ordinalElementPopulated <- ordinalElementPopulated + 2
              
          }
      }
  }
  
  peptideProteinBipartiteGraph <- igraph::make_graph(peptideProteinEdgeVector,
                                                     directed = FALSE)
  
  peptideProteinBipartiteGraph <- igraph::simplify(peptideProteinBipartiteGraph)
  
  return(peptideProteinBipartiteGraph)
}

#' Parses idXML
#'
#' using the python package, pyopenms, load the idXML files into an R
#' object
#'
#' it first take convert R list to python list, load the data into the python
#' list, then convert the R list back,
#' @param idXMLFilePath a filepath that point to the idXML file to be parsed
#' 
#' @return a list consisting of 2 vectors, one that contains the protein
#'   identification and another one that contains the peptide identification
#' @import reticulate
loadFileIntoVector <- function(idXMLFilePath) {
    
    # import python package
    ropenms <- reticulate::import("pyopenms", convert = FALSE)
    
    # basically when using an python package you need to use $ instead of 
    # :: to access thing in the package
    idXML <- ropenms$IdXMLFile()
    
    # convert r list to python list since this python package does not take 
    # R lists
    proteinIdentificationObjectVector <- reticulate::r_to_py(list())
    peptideIdentificationObjectVector <- reticulate::r_to_py(list())
    
    # print(paste0("start to load file into python object"))
    # load to the package into the converted lists
    idXML$load(idXMLFilePath, proteinIdentificationObjectVector, 
               peptideIdentificationObjectVector)
    # print(paste0("file loaded into python object, now converting python object
    # to R object, this will take sometime"))
    
    # then convert the python list back to r object, since R cannot use python objects
    proteinIdentificationObjectVector <- reticulate::py_to_r(
      proteinIdentificationObjectVector)
    peptideIdentificationObjectVector <- reticulate::py_to_r(
      peptideIdentificationObjectVector)
    # print(paste0("python object convert to R object"))
    
    results <- list(protein = proteinIdentificationObjectVector,
                    peptide = peptideIdentificationObjectVector)
  
  return(results)
}

#' Finds the Number of Edges in an idXML File
#'
#' each mapping of protein to peptide counts as one edges, this function counts
#' that
#'
#' it looks at the length of each peptideEvidenceVector which is inside of each
#' peptidehit, which in turn is inside of each peptide identification
#' @param peptideIdentificationObjectVector the vector holding one or more
#'   peptide Identification Objects
#' @return the number of edges
findNumEdges <- function(peptideIdentificationObjectVector) {
    numPeptideProteinsEdge <- 0
    for (i in seq(along = peptideIdentificationObjectVector)) {
        peptideHits <- peptideIdentificationObjectVector[[i]]$getHits()
        
        for (i in seq(along = peptideHits)) {
            peptideEvidenceVector <- peptideHits[[i]]$getPeptideEvidences()
            numPeptideProteinsEdge <- numPeptideProteinsEdge + length(
              peptideEvidenceVector)
            # print(c("numPeptideProteinsEdge", numPeptideProteinsEdge))
        }
    }
    return(numPeptideProteinsEdge)
}

# [END]
