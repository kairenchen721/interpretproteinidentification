# GenerateBipartiteGraph.R
# Author: Kai Ren Chen (kairen.chen@mail.utoronto.ca)
# Date: December 8, 2021

#' Generate a Graph based on Peptide and Protein
#'
#' Based on the protein that can be mapped to peptide which are identified from
#' mass spectrometry, a bipartite graph, is drawn.
#'
#' It takes a mapping of protein accession to peptide sequence, 
#' which is then used by function from the igraph package to
#' generate the graph, then decompose into weakly connected components.
#' This un-directed bipartite graph consist of a set of vertices that represent
#' proteins and a set of vertices that represent peptides. The edges between 
#' protein vertices and peptide vertices represent protein-peptide matches. 
#' Protein accession, peptide identifiers will be displayed at this layer.
#'
#' @param peptideProteinEdgeVector A mapping of protein accession 
#' to peptide sequence in a character vector, either the odd elements are all
#' proteins and the even elements are all peptide or the odd elements are all 
#' peptides and the even elements are all proteins. There should be an even
#' number of elements
#' @param inferredProteinVector A character vector of all protein that are
#' inferred (that is considered presented in the pre mass spectrometry sample)
#' out of all possible proteins
#'   
#' @return It will return a igraph object that include all mapping of protein 
#' to peptides
#' 
#' @examples 
#' generateBipartiteGraph(allEdges)
#' 
#' dbPath <- system.file("extdata", "test_data.osw", package = "interpretproteinidentification")
#' otherEdges <- readSQLiteFile(dbPath)
#' generateBipartiteGraph(otherEdges)
#' 
#' @references 
#' Csardi G, Nepusz T (2006). The igraph software package for complex network
#'  research. *InterJournal, Complex Systems,* 1695. https://igraph.org.
#' 
#' @import igraph
#' 
#' @export
generateBipartiteGraph <- function(peptideProteinEdgeVector,
                                   inferredProteinVector){


  # check that peptideProteinEdgeVector is even
  if (!length(peptideProteinEdgeVector) %% 2 == 0) {
    stop("an peptideProteinEdgeVector with even length is expected")
  } else {
    ; # does nothing (explicit inactive else case as per coding style)
  }
  
  # check that peptideProteinEdgeVector is a character vector
  if (!typeof(peptideProteinEdgeVector) == "character") {
    stop("an peptideProteinEdgeVector with character elements is expected")
  } else {
    ;  # does nothing (explicit inactive else case as per coding style)
  }
  
  
  peptideProteinBipartiteGraph <- igraph::make_graph(peptideProteinEdgeVector,
                                                     directed = FALSE)
  
  peptideProteinBipartiteGraph <- igraph::simplify(peptideProteinBipartiteGraph)
  
  return(peptideProteinBipartiteGraph)
}


#' Reads and Parses an SQLite Database File
#' 
#' using RSQLite, it read an OSW file, which is database file that can be read
#' using with SQLite, this will return the mapping of protein to peptides
#' 
#' @param OSWFilePath the file path for the OSW file
#' 
#' @examples 
#' dbPath <- system.file("extdata", "test_data.osw", package = "interpretproteinidentification")
#' readSQLiteFile(dbPath)
#' 
#' @import DBI
#' @import RSQLite
#' 
#' @references R Special Interest Group on Databases (R-SIG-DB), Hadley Wickham
#'  and Kirill Müller (2021). DBI: R Database Interface. R package version 
#'  1.1.1. https://CRAN.R-project.org/package=DBI
#' 
#' Kirill Müller, Hadley Wickham, David A. James and Seth Falcon (2021). 
#' RSQLite: 'SQLite' Interface for R. R package version 2.2.8. 
#' https://CRAN.R-project.org/package=RSQLite
#' 
#' @export
readSQLiteFile <- function(OSWFilePath) {
  con <- DBI::dbConnect(RSQLite::SQLite(), OSWFilePath)
  
  peptideProteinMatches <- DBI::dbGetQuery(con, "SELECT UNMODIFIED_SEQUENCE, PROTEIN.PROTEIN_ACCESSION FROM PEPTIDE
                  INNER JOIN PEPTIDE_PROTEIN_MAPPING ON PEPTIDE.ID = PEPTIDE_PROTEIN_MAPPING.PEPTIDE_ID
                  INNER JOIN PROTEIN ON PROTEIN.ID = PEPTIDE_PROTEIN_MAPPING.PROTEIN_ID
                  ")
  
  # peptideProteinMatches is a named list
  # so I reformat it into a matrix with each named list as 1 column
  # then I convert matrix to the character vector by row
  
  sqlmatrix <- matrix(data = unlist(peptideProteinMatches),
                      nrow = length(peptideProteinMatches$UNMODIFIED_SEQUENCE),
                      ncol = length(peptideProteinMatches))
  
  peptideProteinEdgeVector <- as.vector(t(sqlmatrix))
  
  DBI::dbDisconnect(con)
  
  return(peptideProteinEdgeVector)
}


#' Parses idXML (Does not work due to reticulate not working)
#'
#' using the python package, pyopenms, load the idXML files into an R
#' object then parse it to obtain what the graph needs
#'
#' it first take convert R list to python list, load the data into the python
#' list, then convert the R list back, and iterate through the file to obtain a
#' mapping of protein to peptides.
#' An idXML consist of a peptide identification object and a protein 
#' identification object
#' 
#' @param preInferenceFilePath The file path pointing toward an idXML file 
#' before protein inference, it contains all possible protein, and all identified
#' peptides
#' @param postInferenceFilePath The file path pointing toward an idXML file 
#' after protein inference, it contains all identified/inferred proteins
#' @param ropenms a variable containing the reference to the package "ropenms"
#' 
#' @return a character vector where every two elements represent an edge 
#' in the graph
#' 
#' @examples
#' \dontrun{
#' reticulate::install_python(3.1)
#' reticulate::use_python_version(3.1)
#' reticulate::conda_create("r-reticulate")
#' reticulate::conda_install("r-reticulate", "pyopenms") 
#' ropenms <- DIAlignR::get_ropenms(condaEnv = "r-reticulate", useConda=TRUE)
#' }
#' 
#' @references 
#' Röst, H. L., Sachsenberg, T., Aiche, S., Bielow, C., Weisser, H.,
#'  Aicheler, F., Andreotti, S., Ehrlich, H. C., Gutenbrunner, P., Kenar,
#'  E., Liang, X., Nahnsen, S., Nilse, L., Pfeuffer, J., Rosenberger, G.,
#'  Rurik, M., Schmitt, U., Veit, J., Walzer, M., Wojnar, D., … Kohlbacher, O.
#'  (2016). OpenMS: a flexible open-source software platform for mass 
#'  spectrometry data analysis. *Nature methods, 13*(9), 741–748. 
#'  https://doi.org/10.1038/nmeth.3959 
# loadFileIntoVector <- function(preInferenceFilePath, postInferenceFilePath, ropenms) {
#   
#     # basically when using an python package you need to use $ instead of 
#     # :: to access thing in the package
#     idXML <- ropenms$IdXMLFile()
#     
#     # convert r list to python list since this python package does not take 
#     # R lists
#     proteinIdentificationObjectVector <- reticulate::r_to_py(list())
#     peptideIdentificationObjectVector <- reticulate::r_to_py(list())
#     
#     # print(paste0("start to load file into python object"))
#     # load to the package into the converted lists
#     idXML$load(preInferenceFilePath, proteinIdentificationObjectVector, 
#                peptideIdentificationObjectVector)
#     # print(paste0("file loaded into python object, now converting python object
#     # to R object, this will take sometime"))
#     
#     # then convert the python list back to r object, since R cannot use python objects
#     proteinIdentificationObjectVector <- reticulate::py_to_r(
#       proteinIdentificationObjectVector)
#     peptideIdentificationObjectVector <- reticulate::py_to_r(
#       peptideIdentificationObjectVector)
#     # print(paste0("python object convert to R object"))
#     
#     
#     #find out how many edges there are to pre-allocate vector size
#     numPeptideProteinsEdge <- findNumEdges(peptideIdentificationObjectVector)
#     # print(paste0("number of edges found"))
#     
#     # so every row before this ordinal is populated
#     # it starts at 1 (meaning that the 0th row is population) there is no 0th 
#     # row so, no row is populated
#     ordinalElementPopulated <- 1
#     peptideProteinEdgeVector <- character(length = numPeptideProteinsEdge*2)
#     
#     # iterate over the peptides 
#     for (peptideIDNum in seq(along = peptideIdentificationObjectVector)) {
#       peptideHits <- peptideIdentificationObjectVector[[peptideIDNum]]$getHits()
#       
#       for (peptideHitNum in seq(along = peptideHits)) {
#         peptideEvidenceVector <- peptideHits[[peptideHitNum]]$getPeptideEvidences()
#         
#         for (peptideEvidenceNum in seq(along = peptideEvidenceVector)) {
#           proteinAccession <- toString(peptideEvidenceVector
#                                        [[peptideEvidenceNum]]$getProteinAccession())
#           peptideSequence <- toString(peptideHits[[peptideHitNum]]$getSequence())
#           
#           # every time an element is populated, we increase the ordinal 
#           # which every element before it (not including itself) is 
#           # populated. e.g. if the ordinal is 5, that means every element 
#           # before the 5th element, (the 1st, 2nd, 3rd, 4th element) is 
#           # populated 
#           peptideProteinEdgeVector[ordinalElementPopulated] <- peptideSequence
#           peptideProteinEdgeVector[ordinalElementPopulated + 1] <- 
#             proteinAccession
#           ordinalElementPopulated <- ordinalElementPopulated + 2
#         }
#       }
#     }
#   
#   return(peptideProteinEdgeVector)
# }

#' Finds the Number of Edges in an idXML File
#'
#' each mapping of protein to peptide counts as one edges, this function counts
#' that
#'
#' it looks at the length of each peptideEvidenceVector which is inside of each
#' peptidehit, which in turn is inside of each peptide identification
#' 
#' @param peptideIdentificationObjectVector the vector holding one or more
#'   peptide Identification Objects
#' 
#' @references 
#' Röst, H. L., Sachsenberg, T., Aiche, S., Bielow, C., Weisser, H.,
#'  Aicheler, F., Andreotti, S., Ehrlich, H. C., Gutenbrunner, P., Kenar,
#'  E., Liang, X., Nahnsen, S., Nilse, L., Pfeuffer, J., Rosenberger, G.,
#'  Rurik, M., Schmitt, U., Veit, J., Walzer, M., Wojnar, D., … Kohlbacher, O.
#'  (2016). OpenMS: a flexible open-source software platform for mass 
#'  spectrometry data analysis. *Nature methods, 13*(9), 741–748. 
#'  https://doi.org/10.1038/nmeth.3959 
#' 
#' @return the number of edges
# findNumEdges <- function(peptideIdentificationObjectVector) {
#     numPeptideProteinsEdge <- 0
#     for (i in seq(along = peptideIdentificationObjectVector)) {
#         peptideHits <- peptideIdentificationObjectVector[[i]]$getHits()
#         
#         for (i in seq(along = peptideHits)) {
#             peptideEvidenceVector <- peptideHits[[i]]$getPeptideEvidences()
#             numPeptideProteinsEdge <- numPeptideProteinsEdge + length(
#               peptideEvidenceVector)
#             # print(c("numPeptideProteinsEdge", numPeptideProteinsEdge))
#         }
#     }
#     return(numPeptideProteinsEdge)
# }

# [END]
