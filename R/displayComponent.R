# pass a list into from generate bipartite graph
# then select one index to show, should be graph object?
# 
# This function expects an input of from generateBipartiteGraph
# so the user should do something like
# graph <- generateBipartiteGraph(file1, file2)
# displayComponent(graph, componentnumber = 1)
# 
# 

displayComponent <- function(proteinPeptideGraphComponents, 
                             displayingComponent) {
    componentInQuestion <- proteinPeptideGraphComponents[[displayingComponent]]
    igraph::plot.igraph(componentInQuestion,
                        vertex.label.cex = 0.05,
                        vertex.shape = 'square',
                        vertex.frame.color = NA,
                        vertex.size = 20,
                        vertex.color = 'SkyBlue2')
    return(componentInQuestion)
}