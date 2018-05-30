#' Use base R versions of `purrr` `map` functions
#'
#' * Creates base R versions of `purrr` `map` functions.
#'
#' These support formula functions (i.e. `~{}`).
#'
#' @md
#' @param save_as File path and name. Defaults to "`R/utils-mappers.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_mappers <- function(save_as = "R/utils-mappers.R", open = TRUE) {

  check_is_package("use_mappers()")

  use_template("mappers.R", save_as = save_as, open = open, package = "freebase")

}
