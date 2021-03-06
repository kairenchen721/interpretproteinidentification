
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
peptide can map to, and to improve interpertability of a proteome.

In proteomics, bottom-up proteomics is used more often, where the
protein first undergoes protease digestion into smaller piece of protein
known as “peptides”, it is then the peptides that the mass spectrometer
identifies. Then each peptide is determined to be part which protein
based on sequence. This package is not trying to show a plot that
visualizes the performance of protein inference, nor is it trying to
visualize the connection between mass spectrometry spectra and peptides.

The main reason why this is interesting is because one peptide sequence
can map to multiple proteins sequence (because or else if one peptide
can only map to one protein, visualization of this kind would not
provide much information compare to text files), so this means that this
package can show the what conclusion (or protein) has been drawn (or
inferred) given the evidences (or peptide), and what other conclusion
could have been drawn (or other protein that could possibly be
inferred).

In theory, cytoscape \[4\] can do this, (since it is a visualizer for
any network), but file reading (idXML or osw \[1\] is not an supported
file format) and processing (having to click many thing in the graphical
user interface, or run a few command in the command line interface) may
a slight annoyance. This package solve cytoscape’s limitation through
its simplicity and short learning phase.

The reason why an idXML is not supported by cytoscape is because it is
not a file represent a network, it is just a file represent what peptide
are identified from mass spectra and which protein has a sequence that
also is a supersequence of those peptide’s sequence

The R version is 4.0.2 and the platform used to develop this package is
Mac.

## Installation

You can install the development version of
interpretproteinidentification from [GitHub](https://github.com/) with:

``` r
require("devtools")
devtools::install_github("kairenchen721/interpretproteinidentification", build_vignettes = TRUE)
library("interpretproteinidentification")
```

To run the shinyApp:

``` r
runinterpretproteinidentification()
```

## Overview

``` r
ls("package:interpretproteinidentification")
#> [1] "allEdges"                          "displayComponent"                 
#> [3] "generateBipartiteGraph"            "readSQLiteFile"                   
#> [5] "runinterpretproteinidentification" "selectProtein"
data(package = "interpretproteinidentification")
```

interpretproteinidentification contains 4 functions to visualize protein
inference. The readSQLiteFil} read the osw file and make a character
vector representing the edges of a graph. The generateBipartiteGraph
function generate the graph. The displayComponent allows the user to
choose a component of the graph to display. selectProtein is a function
that draw a sub-graph consisting of the selected protein/peptide and all
its adjacent vertices. The runinterpretproteinidentification is the
function that launches the shiny app for this package. The package also
contains a sample idXML and osw data in inst/extdata Refer to package
vignettes for more details.

``` r
browseVignettes("interpretproteinidentification")
```

The package tree structure is provided below

``` r
- interpretProteinIdentification
  |- interpretProteinIdentification.Rproj
  |- DESCRIPTION
  |- NAMESPACE
  |- LICENSE
  |- README
  |- inst
    |-extdata
      |-BSA1_OMSSA.idXML
  |- doc
    |-my-vignette.html
  |- man
    |- displayComponent.Rd
    |- findNumEdges.Rd
    |- generateBipartiteGraph.Rd
    |- interpretProteinIdentitification.Rd
    |- loadFileIntoVector.Rd
    |- selectProtein.Rd
  |- R
    |- displayComponent.R
    |- searchForAnnotations.R
    |- generateBipartiteGraph.R
    |- interpretProteinIdentitification-package.R
    |- selectProtein.R
  |- vignettes
  |- tests
    |- testthat.R
    |- testthat
      |- test-displayComponent.R
      |- test-searchForAnnotations.R
      |- test-generateBipartiteGraph.R
      |- test-selectProtein.R
```

## Contributions

The author of this package is Kai Ren Chen. The function make use of
load function from `pyopenms` python package \[3\] to read idXML files,
through `reticulate`. \[7\] uses `DBI` \[9\] and `RSQLite` \[10\] to
execute the SQL queries. uses `igraph` R package \[2\] to make the graph
and simplify the graph. also uses the `igraph` R package \[2\] to
decompose the graph into components and draw the component. uses the
`igraph` R package \[2\] to search for relevant vertices (those
connected to the selected protein/peptide), induce a sub-graph, then
plot it. The data set BSA1_OMSSA.idXML is obtained from the OpenMS
github. \[1\]. The data set test_data.osw is obtain from the pyprophet
github. \[8\]

## References

1.  Röst, H. L., Sachsenberg, T., Aiche, S., Bielow, C., Weisser, H.,
    Aicheler, F., Andreotti, S., Ehrlich, H. C., Gutenbrunner, P.,
    Kenar, E., Liang, X., Nahnsen, S., Nilse, L., Pfeuffer, J.,
    Rosenberger, G., Rurik, M., Schmitt, U., Veit, J., Walzer, M.,
    Wojnar, D., … Kohlbacher, O. (2016). OpenMS: a flexible open-source
    software platform for mass spectrometry data analysis. *Nature
    methods, 13*(9), 741–748. <https://doi.org/10.1038/nmeth.3959>

2.  Csardi G, Nepusz T (2006). The igraph software package for complex
    network research. *InterJournal, Complex Systems,* 1695.
    <https://igraph.org>.

3.  Röst, H. L., Schmitt, U., Aebersold, R., & Malmström, L. (2014).
    pyOpenMS: a Python-based interface to the OpenMS mass-spectrometry
    algorithm library. *Proteomics, 14*(1), 74–77.
    <https://doi.org/10.1002/pmic.201300246>

4.  Shannon, P., Markiel, A., Ozier, O., Baliga, N. S., Wang, J. T.,
    Ramage, D., Amin, N., Schwikowski, B., & Ideker, T. (2003).
    Cytoscape: a software environment for integrated models of
    biomolecular interaction networks. *Genome research, 13*(11),
    2498–2504. <https://doi.org/10.1101/gr.1239303>

5.  Wickham, H., and Bryan, J. (2019). *R Packages (2nd edition)*.
    Newton, Massachusetts: O’Reilly Media. <https://r-pkgs.org/>

6.  R Core Team (2020). R: A language and environment for statistical
    computing. R Foundation for Statistical Computing, Vienna, Austria.
    <https://www.R-project.org/>.

7.  Ushey, K., Allaire, JJ., and Tang, Y. (2021). reticulate: Interface
    to ‘Python’. R package version 1.22.
    <https://CRAN.R-project.org/package=reticulate>

8.  Teleman, J., Röst, H. L., Rosenberger, G., Schmitt, U., Malmström,
    L., Malmström, J., & Levander, F. (2015). DIANA–algorithmic
    improvements for analysis of data-independent acquisition MS data.
    Bioinformatics (Oxford, England), 31(4), 555–562.
    <https://doi.org/10.1093/bioinformatics/btu686>

9.  R Special Interest Group on Databases (R-SIG-DB), Hadley Wickham and
    Kirill Müller (2021). DBI: R Database Interface. R package version
    1.1.1. <https://CRAN.R-project.org/package=DBI>

10. Kirill Müller, Hadley Wickham, David A. James and Seth Falcon
    (2021). RSQLite: ‘SQLite’ Interface for R. R package version 2.2.8.
    <https://CRAN.R-project.org/package=RSQLite>

## Acknowledgements

This package was developed as part of an assessment for 2021 BCB410H:
Applied Bioinformatics, University of Toronto, Toronto, CANADA.

## Bugs to fix/Feature to implement

1.  How do I compare edges in an igraph object?, it seems to be
    unsupported
2.  Change plot to include inferred protein information
3.  In select protein add gene ontology labels and pathology
4.  Implemented search for annotations, maybe use match
5.  Consider using cytoscape \[4\]
    <http://cytoscape.org/RCy3/articles/Cytoscape-and-iGraph.html>
