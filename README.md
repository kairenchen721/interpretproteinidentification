
<!-- README.md is generated from README.Rmd. Please edit that file -->

# interpretproteinidentification

<!-- badges: start -->
<!-- badges: end -->

The goal of interpretproteinidentification is to …

## Installation

You can install the development version of
interpretproteinidentification from [GitHub](https://github.com/) with:

``` r
require("devtools")
#> Loading required package: devtools
#> Loading required package: usethis
devtools::install_github("kairenchen721/interpretproteinidentification")
#> Downloading GitHub repo kairenchen721/interpretproteinidentification@HEAD
#> 
#>      checking for file ‘/private/var/folders/tf/d8qr9g7s2036pdql45crxh440000gp/T/Rtmp18Vvse/remotes139c662a4d225/kairenchen721-interpretproteinidentification-8d7b5ef/DESCRIPTION’ ...  ✓  checking for file ‘/private/var/folders/tf/d8qr9g7s2036pdql45crxh440000gp/T/Rtmp18Vvse/remotes139c662a4d225/kairenchen721-interpretproteinidentification-8d7b5ef/DESCRIPTION’
#>   ─  preparing ‘interpretproteinidentification’:
#>      checking DESCRIPTION meta-information ...  ✓  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>   ─  building ‘interpretproteinidentification_0.3.0.tar.gz’
#>      
#> 
#> Warning in i.p(...): installation of package '/var/folders/tf/
#> d8qr9g7s2036pdql45crxh440000gp/T//Rtmp18Vvse/file139c632e0adbb/
#> interpretproteinidentification_0.3.0.tar.gz' had non-zero exit status
```

## Example

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

To download the package:

``` r
require("devtools")
devtools::install_github("kairenchen721/interpretproteinidentification", build_vignettes = TRUE)
#> Downloading GitHub repo kairenchen721/interpretproteinidentification@HEAD
#> 
#>      checking for file ‘/private/var/folders/tf/d8qr9g7s2036pdql45crxh440000gp/T/Rtmp18Vvse/remotes139c6544c36c0/kairenchen721-interpretproteinidentification-8d7b5ef/DESCRIPTION’ ...  ✓  checking for file ‘/private/var/folders/tf/d8qr9g7s2036pdql45crxh440000gp/T/Rtmp18Vvse/remotes139c6544c36c0/kairenchen721-interpretproteinidentification-8d7b5ef/DESCRIPTION’
#>   ─  preparing ‘interpretproteinidentification’:
#>      checking DESCRIPTION meta-information ...  ✓  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>   ─  building ‘interpretproteinidentification_0.3.0.tar.gz’
#>      
#> 
#> Warning in i.p(...): installation of package '/var/folders/tf/
#> d8qr9g7s2036pdql45crxh440000gp/T//Rtmp18Vvse/file139c6579ea27c/
#> interpretproteinidentification_0.3.0.tar.gz' had non-zero exit status
library("interpretproteinidentification")
```

To run the shinyApp: Under construction

## Overview

``` r
ls("package:interpretproteinidentification")
#> character(0)
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
contains a sample idXML data. Refer to package vignettes for more
details.

The reason why generateBipartiteGraph and displayComponent is separate
because there may be more than 1 component that the user want to look
at, if the package were to make displayComponent as a helper function to
generateBipartiteGraph, and have the user input a integer as a argument
to generateBipartiteGraph, this may cause 3 problems. The first one is
that if displayComponent functionality is only in generateBipartiteGraph
is that every time the user needs to display another component, the
package re-generate the whole graph again, which can be very resource
intensive. The second one is that if displayComponent functionality also
exist as a separate user-facing function, is that the user may get
confused and re-generate the whole again regardless. The third one is
that in either case, we have an additional parameter, while it may not
be an really bad thing, it is may be better to avoid having more
parameters.

## Contributions

The author of this package is Kai Ren Chen. The *generateBipartiteGraph*
function make use of load function from `pyopenms` python package to
read idXML files, and uses `igraph` R package to draw the graph,
simplify the graph, and decompose the graph into components.
displayComponents also uses the `igraph` R package to draw a component.
selectProtein uses the `igraph` R package to search for relevant
vertices (those connected to the selected protein/peptide), induce a
sub-graph, then plot it

## References

A reference for igraph and pyopenms

## Acknowledgements

This package was developed as part of an assessment for 2021 BCB410H:
Applied Bioinformatics, University of Toronto, Toronto, CANADA.
