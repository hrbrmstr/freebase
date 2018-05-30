#' Use base R versions of `purrr` `walk` functions
#'
#' * Creates base R versions of `purrr` `walk` functions
#'
#' These support formula functions (i.e. `~{}`).
#'
#' @md
#' @param save_as File path and name. Defaults to "`R/utils-walkers.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_walkers <- function(save_as = "R/utils-walkers.R", open = TRUE) {

  check_is_package("use_walkers()")

  use_template("walkers.R", save_as = save_as, open = open, package = "freebase")

}
