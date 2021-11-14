if (!requireNamespace("reticulate", quietly = TRUE)) {
  BiocManager::install("reticulate")
}
library(reticulate)
if (!requireNamespace("pyopenms", quietly = TRUE)) {
  reticulate::py_install("pyopenms")
}
if (!requireNamespace("igraph", quietly = TRUE)) {
  install.packages("igraph")
}
library("igraph")



# import python package
ropenms <- reticulate::import("pyopenms", convert = FALSE)

# basically when using an python package you need to use $ instead of :: to access thing in the packge
idXML <- ropenms$IdXMLFile()

#' @param preInferenceFilePath The file path pointing toward the file before protein inference
#' it contains all possible protein, and all identified peptides
#' @param postInferenceFilePath The file path pointing toward the file after protein inference 
#' it contains all identified proteins
generateBipartiteGraph <- function(preInferenceFilePath,
                                   postInferenceFilePath){
  # I need to read the file
  # protein accession, peptide id, peptide evidence (match to protein)
  
  
  # # testing file
  # download.file("https://github.com/OpenMS/OpenMS/raw/master/share/OpenMS/examples/BSA/BSA1_OMSSA.idXML", "BSA1_OMSSA.idXML")
  # preInferenceFilePath <- "BSA1_OMSSA.idXML"
  
  # this is a function
  preInferenceLoadedVector <- loadFileIntoVector(preInferenceFilePath)
  print(paste0("file loaded into R object"))
  
  peptideIdentificationObjectVector <- preInferenceLoadedVector$peptide
  
  proteinIdentificationObjectVector <- preInferenceLoadedVector$protein
  
  # the protein is that 
  
  #find out how many edges there are
  numPeptideProteinsEdge <- findNumEdges(peptideIdentificationObjectVector)
  print(paste0("number of edges found"))
  
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
              print(c(ordinalRowPopulated, numPeptideProteinsEdge))
              peptideProteinEdgeMatrix[ordinalRowPopulated, 1] <- peptideSequence
              peptideProteinEdgeMatrix[ordinalRowPopulated, 2] <- proteinAccession
              ordinalRowPopulated <- ordinalRowPopulated + 1
              # TODO I can pre allocate, then access index to assign it ####
              peptideProteinEdgeVector <- c(peptideProteinEdgeVector, peptideSequence, proteinAccession)
              
          }
      }
  }
  
  peptideProteinGraph <- igraph::graph_from_edgelist(el = peptideProteinEdgeMatrix)
  
  
  # wait what?
  # ok, despite what the documentation says, the edges vector cannot be a character vector
  # so I gave them internal vertex ids, by using factor and then as numeric
  # peptideProteinBipartiteGraph <- igraph::make_bipartite_graph(rep(0:1, length = 100), as.numeric(factor(peptideProteinEdgeVector)))
  
  # igraph::plot.igraph(x = peptideProteinBipartiteGraph, lty = 1, arrow.mode = 0)
  
  peptideProteinBipartiteGraph <- igraph::make_graph(peptideProteinEdgeVector, directed = FALSE)
  
  peptideProteinBipartiteGraph <- igraph::simplify(peptideProteinBipartiteGraph)
  
  igraph::plot.igraph(peptideProteinBipartiteGraph, 
                      vertex.label.cex = 0.05,
                      vertex.shape = 'square',
                      vertex.frame.color = NA,
                      vertex.size = 5,
                      vertex.color = 'SkyBlue2')
  
  peptideProteinBipartiteGraphComponents <- igraph::decompose(peptideProteinBipartiteGraph, mode = c("weak"))
  
  return(peptideProteinBipartiteGraphComponents)
}


loadFileIntoVector <- function(preInferenceFilePath) {
  # convert r list to python list since this python package does not take R lists
  proteinIdentificationObjectVector <- reticulate::r_to_py(list())
  peptideIdentificationObjectVector <- reticulate::r_to_py(list())
  
  print(paste0("start to load file into python object"))
  # load to the package into the converted lists
  idXML$load(preInferenceFilePath, proteinIdentificationObjectVector, peptideIdentificationObjectVector)
  print(paste0("file loaded into python object, now converting python object to R object, this will take sometime"))
  
  # then convert the python list back to r object, since R cannot use python objects
  proteinIdentificationObjectVector <- reticulate::py_to_r(proteinIdentificationObjectVector)
  peptideIdentificationObjectVector <- reticulate::py_to_r(peptideIdentificationObjectVector)
  print(paste0("python object convert to R object"))
  
  results <- list(protein = proteinIdentificationObjectVector, peptide = peptideIdentificationObjectVector)
  
  return(results)
}

findNumEdges <- function(peptideIdentificationObjectVector) {
    numPeptideProteinsEdge <- 0
    for (i in 1:length(peptideIdentificationObjectVector)) {
        peptideHits <- peptideIdentificationObjectVector[[i]]$getHits()
        
        for (i in 1:length(peptideHits)) {
            # peptideSequence <- peptideHits[[i]]$getSequence()
            peptideEvidenceVector <- peptideHits[[i]]$getPeptideEvidences()
            numPeptideProteinsEdge <- numPeptideProteinsEdge + length(peptideEvidenceVector)
            print(c("numPeptideProteinsEdge", numPeptideProteinsEdge))
        }
    }
    return(numPeptideProteinsEdge)
}


