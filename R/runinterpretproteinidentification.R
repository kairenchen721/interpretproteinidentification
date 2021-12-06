#' Launch Shiny App for interpretproteinidentification
#'
#' A function that launches the Shiny app for interpretproteinidentification
#' The code has been placed in \code{./inst/shiny-scripts}.
#'
#' @return No return value but it open up a Shiny page.
#'
#' @examples
#' \dontrun{
#' interpretproteinidentification::runinterpretproteinidentification()
#' }
#'
#' @references
#' Grolemund, G. (2015). Learn Shiny - Video Tutorials. \href{https://shiny.rstudio.com/tutorial/}{Link}
#'
#' @export
#' @importFrom shiny runApp

runinterpretproteinidentification <- function() {
  appDir <- system.file("shiny-scripts",
                        package = "interpretproteinidentification")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}
# [END]