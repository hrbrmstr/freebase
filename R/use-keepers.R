#' Use base R versions of `purrr` `keep` functions
#'
#' * Creates base R versions of `purrr` `keep` fuctions.
#'
#' These support formula functions (i.e. `~{}`).
#'
#' @md
#' @param save_as File path and name. Defaults to "`R/utils-keepers.R`"
#' @param open if `TRUE`, open the resultant file
#' @export
use_keepers <- function(save_as = "R/utils-keepers.R", open = TRUE) {

  check_is_package("use_keepers()")

  use_template("keepers.R", save_as = save_as, open = open, package = "freebase")

}
