
<!-- README.md is generated from README.Rmd. Please edit that file -->

# interpretproteinidentification

<!-- badges: start -->
<!-- badges: end -->

The goal of interpretproteinidentification is to improve the
interpretbility of protein inference

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>. -->
<!-- You can also embed plots, for example: -->
<!-- In that case, don't forget to commit and push the resulting figure files, so they display on GitHub and CRAN. -->

## Description

The purpose of this package is to visualize the connection between
peptide identified from mass spectrometry, and the protein that the
peptide can map to, and and to improve interpertability of a proteome.
This package is not trying to show a plot that visualizes the
performance of protein inference, nor is it trying to visualize the
connection between mass spectrometry spectra and peptides. The main
reason why is the interesting is because one peptide sequence can map to
multiple proteins sequence (because or else if one peptide can only map
to one protein, visualization of this kind would not provide much
information), even though there can be one protein that a peptide map to
that is most probable, so this means that this package can show the what
conclusion (protein) has been drawn (inferred) given the evidences
(peptide), and what other conclusion could have been drawn (other
protein that could possibly be inferred). In theory, cytoscape can do
this, (since it is a visualizer for any network), but file reading
(idXML is not an supported file format) and processing (having to click
many thing in the graphical user interface, or run a few command in the
command line interface) may be an issue, there is a possibly that
directly maybe more time-consuming (in non-automated parts). The R
version is 4.0.2 and the platform used to develop this package is Mac.

## Installation

You can install the development version of
interpretproteinidentification from [GitHub](https://github.com/) with:

``` r
require("devtools")
devtools::install_github("kairenchen721/interpretproteinidentification", build_vignettes = TRUE)
library("interpretproteinidentification")
```

To run the shinyApp: Under construction

## Overview

``` r
ls("package:interpretproteinidentification")
#> [1] "displayComponent"       "generateBipartiteGraph" "selectProtein"
data(package = "interpretproteinidentification")
#> no data sets found
```

interpretproteinidentification contains 4 functions to visualize protein
inference. The generateBipartiteGraph function generate the graph. The
displayComponent allows the user to choose a component of the graph to
display. selectProtein is a function that draw a sub-graph consisting of
the selected protein/peptide and all its adjacent vertices. The
runinterpretproteinidentification is the function that launches the
shiny app for this package. (not yet implemented) The package also
contains a sample idXML data. Refer to package vignettes (that will be
here in the future) for more details.

``` r
browseVignettes("TestingPackage")
```

## Contributions

The author of this package is Kai Ren Chen. The *generateBipartiteGraph*
function make use of load function from `pyopenms` python package to
read idXML files, and uses `igraph` R package to draw the graph,
simplify the graph, and decompose the graph into components.
displayComponents also uses the `igraph` R package to draw a component.
selectProtein uses the `igraph` R package to search for relevant
vertices (those connected to the selected protein/peptide), induce a
sub-graph, then plot it. The data set BSA1_OMSSA.idXML is obtained from
the OpenMS github.

## Bugs to fix/Feature to implement

1.  Examples in roxygen documentation fails (probably have to do with
    reticulate)
2.  test_check fails (testing in r cmd check) despite devtools::test()
    works maybe I am not sure if it has something to do with getwd()
3.  How do I compare edges in an igraph object?, it seems to be
    unsupported
4.  Get data into the package and write its documentation 1. Change plot
    to include inferred protein information
5.  In select protein displaying protein sequence, color code peptide
    and protein sequence, add gene ontology labels
6.  Implemented search for annotations, maybe use match
7.  Consider using cytoscape
    <http://cytoscape.org/RCy3/articles/Cytoscape-and-iGraph.html>
8.  somehow, building the vignette is killed when it reach one of the
    functions, I suspect it because I am using reticulate

## References

A reference for igraph and pyopenms also openms also cytoscape and all
the package that this depends on

## Acknowledgements

This package was developed as part of an assessment for 2021 BCB410H:
Applied Bioinformatics, University of Toronto, Toronto, CANADA.
