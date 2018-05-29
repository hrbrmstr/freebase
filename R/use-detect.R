#' Use base-ified equivalents of "detect"-ors
#'
#' * Creates `R/utils-detect.R` with base R pseudo-equivalents for `purrr` `detect` (et al).
#'
#' These support formula functions (i.e. `~{}`).
#'
#' @md
#' @param save_as Where to save/what to name the file. Defaults to "`R/utils-detect.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_detect <- function(save_as = "R/utils-detect.R", open = TRUE) {

  check_is_package("use_detect()")

  use_template("detect.R", save_as = save_as , open = open, package = "freebase")

}