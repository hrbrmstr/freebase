#' Use base-ified equivalents of `walk`/`walk2`
#'
#' * Creates `R/utils-walkers.R` with base R pseudo-equivalents for `purrr`
#' `walk`/`walk2`
#'
#' These support formula functions (i.e. `~{}`).
#'
#' @md
#' @param save_as Where to save/what to name the file. Defaults to "`R/utils-walkers.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_walkers <- function(save_as = "R/utils-walkers.R", open = TRUE) {

  check_is_package("use_walkers()")

  use_template("walkers.R", save_as = save_as , open = open, package = "freebase")

}