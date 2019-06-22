#' Use base R versions of `purrr` `slowly` and `insistently` functions
#'
#' * Creates base R versions of `purrr` `safely`, `insistently` (and functions for manipulating `rate` objects).
#'
#' @md
#' @param save_as File path and name. Defaults to "`R/utils-slowly.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_slowly <- function(save_as = "R/utils-safely.R", open = TRUE) {

  check_is_package("use_slowly()")

  use_template("raters.R", save_as = save_as, open = open, package = "freebase")

}