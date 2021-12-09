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
#' sub-graph that include them. When this subgraph is plotted, if the
#' vertexIdentifier is a protein accession, the gene ontology IDs will be display
#' at the top of the plot, if it is involve in disease then it will be displayed
#' at the bottom. (if it is not, then nothing would be displayed).
#' Also to display all the neighbour of a protein/peptide is to plot what 
#' peptide/protein can be mapped to the vertex in question from 
#' vertexIdentifier
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
#' selectProtein(oneComponent, "P02769")
#' selectProtein(wholeGraph, "P02769")
#' selectProtein(oneComponent, "DDSPDLPK")
#' selectProtein(wholeGraph, "DDSPDLPK")
#' 
#' @references 
#' Csardi G, Nepusz T (2006). The igraph software package for complex network
#'  research. *InterJournal, Complex Systems,* 1695. https://igraph.org.
#'  
#' @import igraph
#' @import UniprotR
#' @import graphics
#' 
#' @export
selectProtein <- function(graphToSearchIn, 
                          vertexIdentifier) {
  
    # check the graphToSearchIn is an igraph object
    if (!igraph::is_igraph(graph = graphToSearchIn)) {
      stop("graphToSearchIn is expected to be an igraph object, use the output from
           either generateBiparate or displayComponent")
    } else {
      ; # does nothing (explicit inactive else case as per coding style)
    }
    
    # since igraph uses vertex id, we find that first
    vertexID <- match(
      vertexIdentifier,
      igraph::V(graphToSearchIn)$name,
      nomatch = 0
    )
    
    if (vertexID == 0) {
      stop("this vertexIdentifier is not in this graph")
    } else {
      ; # does nothing (explicit inactive else case as per coding style)
    }
    
    # find all adjacent vertices, using vertex id
    vertexObjectVector <- igraph::neighbors(
      graph = graphToSearchIn,
      v = vertexID
    )
    
    vertexIDVector <- numeric(length = length(vertexObjectVector))
    for (i in seq(along = vertexObjectVector)) {
        # match the vertex object with the item in the vertex sequence 
        vertexIDVector[i] <- match(vertexObjectVector[i], igraph::V(
          graphToSearchIn))
    }
    
    vertexIDVector <- c(vertexIDVector, vertexID)
    # make a subgraph, from vertex ids
    proteinAndItsPeptides <- igraph::induced_subgraph(
      graph = graphToSearchIn,
      vids = vertexIDVector)
    
    accList <- c(vertexIdentifier)
    
    # find gene ontology and involvement in disease
    gOList <- UniprotR::GetProteinGOInfo(accList)
    goID <- gOList$Gene.ontology.IDs

    # find involvement in disease
    pathoList <- UniprotR::GetPathology_Biotech(accList)
    disease <- pathoList$Involvement.in.disease
    
    # TODO: better plot  ####
    igraph::plot.igraph(
      x = proteinAndItsPeptides,
      vertex.label.cex = 0.05,
      vertex.shape = 'square',
      vertex.frame.color = NA,
      vertex.size = 20,
      vertex.color = 'SkyBlue2'
    )
    
    graphics::title(main = goID, cex.main = 0.3, sub = disease, cex.sub = 0.3)

  
    return(proteinAndItsPeptides)
}

# [END]