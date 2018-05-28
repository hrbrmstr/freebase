#' Use infix-helpers
#'
#' * Creates `R/utils-infix-helpers.R` with base R `%XXX%` helpers
#'
#' @md
#' @param save_as Where to save/what to name the file. Defaults to "`R/utils-infix-helpers.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_infix_helpers <- function(save_as = "R/utils-infix-helpers.R", open = TRUE) {

  check_is_package("use_infix_helpers()")

  use_template("infix-helpers.R", save_as = save_as , open = open, package = "freebase")

}