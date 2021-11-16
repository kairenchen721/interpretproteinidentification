#' makes a graph based on peptide and protein
#'
#' \code{generateBipartiteGraph} Based on what protein mapped to peptide
#' identified from mass spectrometry, a graph, specifically a bipartite graph, is
#' drawn.
#'
#' It first uses the pyopenms package to parse the given file in idXML format,
#' and iterate through the file to obtain a mapping of protein accession to
#' peptide sequence, which is then used by function from the igraph package to
#' generate the graph, then decompose into weakly connected components
#' Add something about assumptions
#'
#' @param preInferenceFilePath The file path pointing toward the file before
#'   protein inference it contains all possible protein, and all identified
#'   peptides
#' @param postInferenceFilePath The file path pointing toward the file after
#'   protein inference it contains all identified proteins
#' @return It will return a list of weakly connected component of decompose from the whole graph
#'   each component in the list is a graph object
#' @import utils
#' @export
generateBipartiteGraph <- function(preInferenceFilePath,
                                   postInferenceFilePath){
  # # testing file
  # download.file("https://github.com/OpenMS/OpenMS/raw/master/share/OpenMS/examples/BSA/BSA1_OMSSA.idXML", "BSA1_OMSSA.idXML")
  # preInferenceFilePath <- "BSA1_OMSSA.idXML"
  
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    utils::install.packages("reticulate")
  }
  if (!requireNamespace("igraph", quietly = TRUE)) {
    utils::install.packages("igraph")
  }
  # import python package
  ropenms <- reticulate::import("pyopenms", convert = FALSE)
  
  # basically when using an python package you need to use $ instead of :: to access thing in the packge
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
  
  peptideProteinEdgeMatrix <- matrix(nrow = numPeptideProteinsEdge, ncol = 2)
  
  # so every row before this ordinal is populated
  # it starts at 1 (meaning that the 0th row is population) there is no 0th row so, no row is populated
  ordinalRowPopulated <- 1
  peptideProteinEdgeVector <- c()
  
  # iterate over the peptides 
  for (i in 1:length(peptideIdentificationObjectVector)) {
      peptideHits <- peptideIdentificationObjectVector[[i]]$getHits()
      
      for (j in 1:length(peptideHits)) {
          peptideEvidenceVector <- peptideHits[[j]]$getPeptideEvidences()
          
          for (k in 1:length(peptideEvidenceVector)) {
              proteinAccession <- toString(peptideEvidenceVector[[k]]$getProteinAccession())
              peptideSequence <- toString(peptideHits[[j]]$getSequence())
                
              # every time an row is populated, we increase the ordinal which every row before it (not including itself)
              # is populated. e.g. if the ordinal is 5, that means every row before the 5th row, 
              # (the 1st, 2nd, 3rd, 4th row) is populated 
              # print(c(ordinalRowPopulated, numPeptideProteinsEdge))
              # peptideProteinEdgeMatrix[ordinalRowPopulated, 1] <- peptideSequence
              # peptideProteinEdgeMatrix[ordinalRowPopulated, 2] <- proteinAccession
              # ordinalRowPopulated <- ordinalRowPopulated + 1
              # TODO I can pre allocate, then access index to assign it ####
              peptideProteinEdgeVector <- c(peptideProteinEdgeVector, peptideSequence, proteinAccession)
              
          }
      }
  }
  
  # peptideProteinGraph <- igraph::graph_from_edgelist(el = peptideProteinEdgeMatrix)
  
  
  # ok, despite what the documentation says, the edges vector cannot be a character vector
  # so I gave them internal vertex ids, by using factor and then as numeric
  # that still does not work, just ignore this
  # peptideProteinBipartiteGraph <- igraph::make_bipartite_graph(rep(0:1, length = 100), as.numeric(factor(peptideProteinEdgeVector)))
  
  peptideProteinBipartiteGraph <- igraph::make_graph(peptideProteinEdgeVector, directed = FALSE)
  
  peptideProteinBipartiteGraph <- igraph::simplify(peptideProteinBipartiteGraph)
  
  peptideProteinBipartiteGraphComponents <- igraph::decompose(peptideProteinBipartiteGraph, mode = c("weak"))
  
  return(peptideProteinBipartiteGraphComponents)
}

#' parses idXML
#'
#' using the python package, pyopenms, this would load the idXML files into an R
#' object
#'
#' it first take convert R list to python list, load the data into the python
#' list, then convert the R list back,
#' @param idXMLFilePath a filepath that point to the idXML file to be parsed
#' @return a list consisting of 2 vectors, one that contains the protein
#'   identification and another one that contains the peptide identification
#' @import utils
loadFileIntoVector <- function(idXMLFilePath) {
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    utils::install.packages("reticulate")
  }
  
  # reticulate::py_install("pyopenms")
  # import python package
  ropenms <- reticulate::import("pyopenms", convert = FALSE)
  
  # basically when using an python package you need to use $ instead of :: to access thing in the packge
  idXML <- ropenms$IdXMLFile()
  
  # convert r list to python list since this python package does not take R lists
  proteinIdentificationObjectVector <- reticulate::r_to_py(list())
  peptideIdentificationObjectVector <- reticulate::r_to_py(list())
  
  # print(paste0("start to load file into python object"))
  # load to the package into the converted lists
  idXML$load(idXMLFilePath, proteinIdentificationObjectVector, peptideIdentificationObjectVector)
  # print(paste0("file loaded into python object, now converting python object to R object, this will take sometime"))
  
  # then convert the python list back to r object, since R cannot use python objects
  proteinIdentificationObjectVector <- reticulate::py_to_r(proteinIdentificationObjectVector)
  peptideIdentificationObjectVector <- reticulate::py_to_r(peptideIdentificationObjectVector)
  # print(paste0("python object convert to R object"))
  
  results <- list(protein = proteinIdentificationObjectVector, peptide = peptideIdentificationObjectVector)
  
  return(results)
}

#' finds the number of edges in an idXML file
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
    for (i in 1:length(peptideIdentificationObjectVector)) {
        peptideHits <- peptideIdentificationObjectVector[[i]]$getHits()
        
        for (i in 1:length(peptideHits)) {
            peptideEvidenceVector <- peptideHits[[i]]$getPeptideEvidences()
            numPeptideProteinsEdge <- numPeptideProteinsEdge + length(peptideEvidenceVector)
            # print(c("numPeptideProteinsEdge", numPeptideProteinsEdge))
        }
    }
    return(numPeptideProteinsEdge)
}


