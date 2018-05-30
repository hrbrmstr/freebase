check_is_package <- function (whos_asking = NULL) {

  if (is_package()) return(invisible())

  message <- paste0("Project ", value(project_name()), " is not an R package.")

  if (!is.null(whos_asking)) {
    message <- paste0(code(whos_asking), " is designed to work with packages. ",
                      message)
  }

  stop(message, call. = FALSE)

}

#' @import rprojroot
is_package <- function (base_path = proj_get()){
  res <- tryCatch(rprojroot::find_package_root_file(path = base_path),
                  error = function(e) NULL)
  !is.null(res)
}

#' @importFrom crayon blue
value <- function (...) {
  x <- paste0(...)
  crayon::blue(encodeString(x, quote = "'"))
}

#' @importFrom crayon make_style
code <- function (...) {
  x <- paste0(...)
  (crayon::make_style("darkgrey"))(encodeString(x, quote = "`"))
}

#' @importFrom desc desc_get
#' @import usethis
project_name <- function (base_path = usethis::proj_get()) {
  desc_path <- file.path(base_path, "DESCRIPTION")
  if (file.exists(desc_path)) {
    desc::desc_get("Package", base_path)[[1]]
  }
  else {
    basename(normalizePath(base_path, mustWork = FALSE))
  }
}
