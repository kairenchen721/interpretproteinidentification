## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----attach package-----------------------------------------------------------
require("devtools")
devtools::install_github("kairenchen721/interpretproteinidentification")
library(interpretproteinidentification)

## ----makeGraph----------------------------------------------------------------
graphForProteinInference <- interpretproteinidentification::generateBipartiteGraph(
  interpretproteinidentification::allEdges, "")

## ----displayComponent---------------------------------------------------------
componentYouWantToDisplay <- interpretproteinidentification::displayComponent(graphForProteinInference, 1)

## ----selectProtein------------------------------------------------------------
interpretproteinidentification::selectProtein(componentYouWantToDisplay, "P02769")

## ----selectPeptide------------------------------------------------------------
interpretproteinidentification::selectProtein(componentYouWantToDisplay, "DDSPDLPK")

