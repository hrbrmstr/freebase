#' Use base-ified equivalents of keep/discard/compact
#'
#' * Creates `R/utils-keepers.R` with base R pseudo-equivalents for `purrr`
#' `keep`/`discard`/`compact`
#'
#' @md
#' @param save_as Where to save/what to name the file. Defaults to "`R/utils-keepers.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_keepers <- function(save_as = "R/utils-keepers.R", open = TRUE) {

  check_is_package("use_keepers()")

  use_template("keepers.R", save_as = save_as , open = open, package = "freebase")

}