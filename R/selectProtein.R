# display this protein
# and all the peptides that it links to
# 
# or display this peptide
# and all the peptide that it links to
# you must pass one component and not the list of components
# 
# need to find the protein sequence and add to this
# then color code it 
# and add gene ontology here

#' @param graphToSearchIn is the component that the user has choose to displayed in displayComponent,
#' selectProtein searches within this component
#' @param vertexIdentifier is an identifier for the vertex in the graph, so what this refer to here
#' would be either a protein accession or peptide sequence
selectProtein <- function(graphToSearchIn, 
                          vertexIdentifier) {
    # since igraph uses vertex id, we find that first
    vertexID <- match(vertexIdentifier, igraph::V(graphToSearchIn)$name)
    
    # find all adjacent vertices, using vertex id
    vertexObjectVector <- igraph::neighbors(graphToSearchIn, vertexID)
    
    vertexIDVector <- numeric(length = length(vertexObjectVector))
    # but i can do this
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
  
}