#' display a protein/peptide and its neighbours
#'
#' select a protein and all the peptide that it maps to or a peptide and all the
#' proteins that it maps to, to display
#'
#' Using igraph function, It first finds the vertex object that identifier
#' refers to, then find the neighbours of that vertex, and finally induce a
#' sub-graph that include them. Feature yet to add: displaying protein sequence,
#' color code peptide and protein sequence, add gene ontology labels.
#'
#' @param graphToSearchIn is the component that the user has chosen to displayed
#'   in \code{displayComponent}, selectProtein searches within this component
#' @param vertexIdentifier is an identifier for the vertex in the graph, so what
#'   this refers to here would be either a protein accession or peptide sequence
#' @return The sub-graph that include a vertex and all its neighbours
#' @examples
#' componentWanted <- displayComponent(componentList, displayingComponent = 1)
#' proteinSubgraph <- selectProtein(componentWanted, "P02769|ALBU_BOVIN")
#' proteinSubgraph <- selectProtein(componentWanted, "DDSPDLPK")
selectProtein <- function(graphToSearchIn, 
                          vertexIdentifier) {
    # since igraph uses vertex id, we find that first
    vertexID <- match(vertexIdentifier, igraph::V(graphToSearchIn)$name)
    
    # find all adjacent vertices, using vertex id
    vertexObjectVector <- igraph::neighbors(graphToSearchIn, vertexID)
    
    vertexIDVector <- numeric(length = length(vertexObjectVector))
    for (i in 1:length(vertexObjectVector)) {
        # match the vertex object with the item in the vertex sequence 
        vertexIDVector[i] <- match(vertexObjectVector[i], igraph::V(graphToSearchIn))
    }
    
    vertexIDVector <- c(vertexIDVector, vertexID)
    # i can make a subgraph, if i know the vertex ids
    proteinAndItsPeptides <- igraph::induced_subgraph(graphToSearchIn, vertexIDVector)
    
    # need to adjust this
    igraph::plot.igraph(proteinAndItsPeptides,
                        vertex.label.cex = 0.05,
                        vertex.shape = 'square',
                        vertex.frame.color = NA,
                        vertex.size = 20,
                        vertex.color = 'SkyBlue2')
    
    # need to add
  
    return(proteinAndItsPeptides)
}