## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----attach package, message=FALSE, warning=FALSE, error=FALSE----------------
require("devtools")
devtools::install_github("kairenchen721/interpretproteinidentification")
library(interpretproteinidentification)

## -----------------------------------------------------------------------------
dbPath <- system.file("extdata", "test_data.osw", package = "interpretproteinidentification")
dbProteinPeptides <- interpretproteinidentification::readSQLiteFile(dbPath)

## -----------------------------------------------------------------------------
graphForProteinInference <- interpretproteinidentification::generateBipartiteGraph(dbProteinPeptides, "")

## ----makeGraph----------------------------------------------------------------
graphForProteinInference <- interpretproteinidentification::generateBipartiteGraph(
  interpretproteinidentification::allEdges, "")

## ----displayComponent---------------------------------------------------------
componentYouWantToDisplay <- interpretproteinidentification::displayComponent(graphForProteinInference, 1)

## ----selectProtein------------------------------------------------------------
interpretproteinidentification::selectProtein(componentYouWantToDisplay, "P02769")

## ----selectPeptide------------------------------------------------------------
interpretproteinidentification::selectProtein(componentYouWantToDisplay, "DDSPDLPK")

