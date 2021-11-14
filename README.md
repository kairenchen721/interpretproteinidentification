
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
#>      checking for file ‘/private/var/folders/tf/d8qr9g7s2036pdql45crxh440000gp/T/RtmprTvZje/remotes10dd6441af265/kairenchen721-interpretproteinidentification-8fc4445/DESCRIPTION’ ...  ✓  checking for file ‘/private/var/folders/tf/d8qr9g7s2036pdql45crxh440000gp/T/RtmprTvZje/remotes10dd6441af265/kairenchen721-interpretproteinidentification-8fc4445/DESCRIPTION’
#>   ─  preparing ‘interpretproteinidentification’:
#>      checking DESCRIPTION meta-information ...  ✓  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>   ─  building ‘interpretproteinidentification_0.1.0.tar.gz’
#>      
#> 
#> Warning in i.p(...): installation of package '/var/folders/tf/
#> d8qr9g7s2036pdql45crxh440000gp/T//RtmprTvZje/file10dd6451fe7d1/
#> interpretproteinidentification_0.1.0.tar.gz' had non-zero exit status
```

## Example

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>. -->
<!-- You can also embed plots, for example: -->
<!-- In that case, don't forget to commit and push the resulting figure files, so they display on GitHub and CRAN. -->

## Description

## Installation

To download the package:

``` r
require("devtools")
devtools::install_github("kairenchen721/interpretproteinidentification", build_vignettes = TRUE)
#> Downloading GitHub repo kairenchen721/interpretproteinidentification@HEAD
#> 
#>      checking for file ‘/private/var/folders/tf/d8qr9g7s2036pdql45crxh440000gp/T/RtmprTvZje/remotes10dd661d2778/kairenchen721-interpretproteinidentification-8fc4445/DESCRIPTION’ ...  ✓  checking for file ‘/private/var/folders/tf/d8qr9g7s2036pdql45crxh440000gp/T/RtmprTvZje/remotes10dd661d2778/kairenchen721-interpretproteinidentification-8fc4445/DESCRIPTION’
#>   ─  preparing ‘interpretproteinidentification’:
#>      checking DESCRIPTION meta-information ...  ✓  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>   ─  building ‘interpretproteinidentification_0.1.0.tar.gz’
#>      
#> 
#> Warning in i.p(...): installation of package '/var/folders/tf/
#> d8qr9g7s2036pdql45crxh440000gp/T//RtmprTvZje/file10dd6640a3a6a/
#> interpretproteinidentification_0.1.0.tar.gz' had non-zero exit status
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

## Contributions

The author of this package is Kai Ren Chen. The *generateBipartiteGraph*
function make use of load function from `pyopenms` python package to
read idXML files, and uses `igraph` R package to draw the graph,
simplify the graph, and decompose the graph into components.
displayComponents also uses the `igraph` R package to draw a component.
selectProtein uses the `igraph` R package to search for relevant
vertices (those connected to the selected protein/peptide)

## References

A reference for igraph and pyopenms

## Acknowledgements

This package was developed as part of an assessment for 2021 BCB410H:
Applied Bioinformatics, University of Toronto, Toronto, CANADA.
