#' Use base-ified equivalents of 'map'-pers
#'
#' * Creates `R/utils-mappers.R` with base R pseudo-equivalents for `purrr` `map`-pers.
#'
#' These support formula functions (i.e. `~{}`).
#'
#' @md
#' @param save_as Where to save/what to name the file. Defaults to "`R/utils-mappers.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_mappers <- function(save_as = "R/utils-mappers.R", open = TRUE) {

  check_is_package("use_mappers()")

  use_template("mappers.R", save_as = save_as , open = open, package = "freebase")

}