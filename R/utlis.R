# from https://cran.r-project.org/web/packages/reticulate/vignettes/package.html


# global reference to scipy (will be initialized in .onLoad)
ropenms <- NULL
.onLoad <- function(libname, pkgname) {
  # use superassignment to update global reference to scipy
  ropenms <<- reticulate::import("pyopenms", delay_load = TRUE)
  return(ropenms)
}


# just a wrapper for install pyopenms
installPyopenms <- function(method = "auto", conda = "auto") {
  return(reticulate::py_install("pyopenms", method = method, conda = conda))
}


skipIfNoPyopenms <- function() {
  have_pyopenms <- reticulate::py_module_available("scipy")
  
  if (!have_pyopenms) {
    testthat::skip("scipy not available for testing")
  }
}