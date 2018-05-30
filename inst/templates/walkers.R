# NOTE these aren't 100% equivalent to the purrr walkers but cover very common use-cases
#
# NOTE formula function (e.g. ~{}) are 100% supported

walk <- function(.x, .f, ...) {

  if (inherits(.f, "formula")) {
    .body <- dimnames(attr(terms(.f), "factors"))[[1]]
    .f <- function(.x, . = .x) {}
    body(.f) <- as.expression(parse(text=.body))
  }

  if (inherits(.f, "function")) {
    lapply(.x, .f, ...)
  } else {
    stop("I'm not sure indexing by name or number makes sense for walk().")
  }

  invisible(.x)

}

walk2 <- function(.x, .y, .f, ...) {

  if (inherits(.f, "formula")) {
    .body <- dimnames(attr(terms(.f), "factors"))[[1]]
    .f <- function(.x, .y, . = .x) {}
    body(.f) <- as.expression(parse(text=.body))
  }

  if (inherits(.f, "function")) {
    mapply(.f, .x, .y, ..., SIMPLIFY=FALSE, USE.NAMES=FALSE)
  }

  invisible(.x)

}
