#' Use base R versions of `tidyr` functions
#'
#' * Creates base R versions of `tidyr` functions
#'
#' @md
#' @param save_as File path and name. Defaults to "`R/utils-tidylite.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_tidylite <- function(save_as = "R/utils-tidylite.R", open = TRUE) {

  check_is_package("use_tidylite()")

  use_template("tidylite.R", save_as = save_as, open = open, package = "freebase")

}
