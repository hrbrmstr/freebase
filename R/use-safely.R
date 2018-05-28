#' Use base-ified equivalents of "safely"-ifiers
#'
#' * Creates `R/utils-safely.R` with base R pseudo-equivalents for `purrr` `safely` (et al).
#'
#' @md
#' @param save_as Where to save/what to name the file. Defaults to "`R/utils-safely.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_safely <- function(save_as = "R/utils-safely.R", open = TRUE) {

  check_is_package("use_safely()")

  use_template("safely.R", save_as = save_as , open = open, package = "freebase")

}