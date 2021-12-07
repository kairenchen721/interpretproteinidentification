# displayComponent.R
# Author: Kai Ren Chen (kairen.chen@mail.utoronto.ca)
# Date: December 8, 2021


#' Select an Component to Display
#'
#' \code{displayComponent} given an index, display that component in the list of
#' component
#'
#' It take the return of \code{generateBipartiteGraph} and an integer, and 
#' decompose the graph and uses indexing to select the graph object to display.
#' What is display is a weakly connected component of the overall graph, the
#' biological meaning is that only these vertices are relevant to the inference 
#' of any protein in this component. 
#'
#' @param proteinPeptideGraph the return from \code{generateBipartiteGraph}, 
#' a graph object, containing all peptides and protein in the idXML given
#' @param displayingComponent an integer representing the index of the component
#'   that the user want to display
#'   
#' @return it returns the component that is displayed
#' 
#' @references 
#' Csardi G, Nepusz T (2006). The igraph software package for complex network
#'  research. *InterJournal, Complex Systems,* 1695. https://igraph.org.
#' 
#' @examples 
#' wholeGraph <- generateBipartiteGraph(allEdges)
#' displayComponent(wholeGraph, 1)
#'
#' @export
displayComponent <- function(proteinPeptideGraph, 
                             displayingComponent) {
    
    peptideProteinGraphComponents <- igraph::decompose(proteinPeptideGraph,
                                                       mode = c("weak"))
    componentInQuestion <- peptideProteinGraphComponents[[displayingComponent]]
    igraph::plot.igraph(componentInQuestion,
                        vertex.label.cex = 0.05,
                        vertex.shape = 'square',
                        vertex.frame.color = NA,
                        vertex.size = 20,
                        vertex.color = 'SkyBlue2')
    
    # add check for user input that exceed the indices of the given list
    return(componentInQuestion)
}

# [END]