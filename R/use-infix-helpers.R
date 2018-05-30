#' Use infix-helpers
#'
#' * Creates base R `%xyz%` helpers
#'
#' @md
#' @param save_as File path and name. Defaults to "`R/utils-infix-helpers.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_infix_helpers <- function(save_as = "R/utils-infix-helpers.R", open = TRUE) {

  check_is_package("use_infix_helpers()")

  use_template("infix-helpers.R", save_as = save_as, open = open, package = "freebase")

}
