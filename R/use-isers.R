#' Use "is_" functions
#'
#' * Creates `R/utils-isers.R` filled with `is_...` testors
#'
#' @md
#' @param save_as Where to save/what to name the file. Defaults to "`R/utils-isers.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_isers <- function(save_as = "R/utils-isers.R", open = TRUE) {

  check_is_package("use_isers()")

  use_template("is-ers.R", save_as = save_as , open = open, package = "freebase")

}