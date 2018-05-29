#' Use base R versions of `tidyr` `gather`/`spread`
#'
#' * Creates `R/utils-tidylite.R` containing `gatherlite()` and `spreadlite()`
#'
#' @md
#' @param save_as Where to save/what to name the file. Defaults to "`R/utils-tidylite.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_tidylite <- function(save_as = "R/utils-tidylite.R", open = TRUE) {

  check_is_package("use_tidylite()")

  use_template("tidylite.R", save_as = save_as , open = open, package = "freebase")

}