check_is_package <- function (whos_asking = NULL) {

  if (is_package()) return(invisible())

  message <- paste0("Project ", value(project_name()), " is not an R package.")

  if (!is.null(whos_asking)) {
    message <- paste0(code(whos_asking), " is designed to work with packages. ",
                      message)
  }

  stop(message, call. = FALSE)

}

is_package <- function (base_path = proj_get()){
  res <- tryCatch(rprojroot::find_package_root_file(path = base_path),
                  error = function(e) NULL)
  !is.null(res)
}