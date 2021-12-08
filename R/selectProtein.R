# selectProtein.R
# Author: Kai Ren Chen (kairen.chen@mail.utoronto.ca)
# Date: December 8, 2021

#' Display a Protein/Peptide and Its Neighbors
#'
#' select a protein and all the peptide that it maps to or a peptide and all the
#' proteins that it maps to, to display. This function expect the output of 
#' \code{generateBipartiteGraph} and \code{displayComponent} to be its input.
#'
#' Using igraph function, It first finds the vertex object that identifier
#' refers to, then find the neighbors of that vertex, and finally induce a
#' sub-graph that include them. You Feature yet to add: displaying protein 
#' sequence, color code peptide and protein sequence, add gene ontology labels.
#' To display the neighbour of a protein/peptide is to know what peptide/protein
#' can be mapped to it. 
#'
#' @param graphToSearchIn is the component that the user has chosen to displayed
#'   in \code{displayComponent}, selectProtein searches within this component
#' @param vertexIdentifier is an identifier for the vertex in the graph, so what
#'   this refers to here would be either a protein accession or peptide sequence
#'
#' @return The sub-graph that include a vertex and all its neighbors
#' 
#' @examples 
#' wholeGraph <- generateBipartiteGraph(allEdges)
#' oneComponent <- displayComponent(wholeGraph, 1)
#' selectProtein(oneComponent, "P02769|ALBU_BOVIN")
#' selectProtein(wholeGraph, "P02769|ALBU_BOVIN")
#' selectProtein(oneComponent, "DDSPDLPK")
#' selectProtein(wholeGraph, "DDSPDLPK")
#' 
#' #' @references 
#' Csardi G, Nepusz T (2006). The igraph software package for complex network
#'  research. *InterJournal, Complex Systems,* 1695. https://igraph.org.
#' 
#' @export
selectProtein <- function(graphToSearchIn, 
                          vertexIdentifier) {
  
    # potential examples
    # proteinSubgraph <- selectProtein(componentWanted, "P02769|ALBU_BOVIN")
    # proteinSubgraph <- selectProtein(componentWanted, "DDSPDLPK")
    
    # since igraph uses vertex id, we find that first
    vertexID <- match(vertexIdentifier, igraph::V(graphToSearchIn)$name)
    
    # find all adjacent vertices, using vertex id
    vertexObjectVector <- igraph::neighbors(graphToSearchIn, vertexID)
    
    vertexIDVector <- numeric(length = length(vertexObjectVector))
    for (i in seq(along = vertexObjectVector)) {
        # match the vertex object with the item in the vertex sequence 
        vertexIDVector[i] <- match(vertexObjectVector[i], igraph::V(
          graphToSearchIn))
    }
    
    vertexIDVector <- c(vertexIDVector, vertexID)
    # i can make a subgraph, if i know the vertex ids
    proteinAndItsPeptides <- igraph::induced_subgraph(graphToSearchIn, 
                                                      vertexIDVector)
    
    # TODO: better plot  ####
    igraph::plot.igraph(proteinAndItsPeptides,
                        vertex.label.cex = 0.05,
                        vertex.shape = 'square',
                        vertex.frame.color = NA,
                        vertex.size = 20,
                        vertex.color = 'SkyBlue2')
    
    # TODO: displaying protein sequence, color code peptide 
    # and protein sequence, add gene ontology labels.####
  
    return(proteinAndItsPeptides)
}

# [END]