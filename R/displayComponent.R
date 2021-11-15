#' select an component to display
#'
#' \code{displayComponent} given an index, display that component in the list of
#' component
#'
#' It take the return of \code{generateBipartiteGraph} and an integer, and uses
#' indexing to select the graph object to display
#'
#' @param proteinPeptideGraphComponents the return from \code{generateBipartiteGraph}
#' @param displayingComponent an integer representing the index of the component
#'   that the user want to display
#' @return it returns the component that is displayed
#'
#' @export
displayComponent <- function(proteinPeptideGraphComponents, 
                             displayingComponent) {
    componentInQuestion <- proteinPeptideGraphComponents[[displayingComponent]]
    igraph::plot.igraph(componentInQuestion,
                        vertex.label.cex = 0.05,
                        vertex.shape = 'square',
                        vertex.frame.color = NA,
                        vertex.size = 20,
                        vertex.color = 'SkyBlue2')
    
    # add check for user input that exceed the indices of the given list
    return(componentInQuestion)
}