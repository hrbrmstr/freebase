# NOTE: is_true() is also in use_isers()
is_true <- function (x) identical(x, TRUE)

# These support formula functions (i.e. `~{}`).
detect <- function (.x, .f, ..., .right = FALSE, .p) {

  if (inherits(.f, "formula")) {
    .body <- dimnames(attr(stats::terms(.f), "factors"))[[1]]
    .f <- function(.x, .=.x) {}
    body(.f) <- as.expression(parse(text=.body))
  }

  for (i in index(.x, .right)) {
    if (inherits(.f, "function")) {
      if (is_true(.f(.x[[i]], ...))) return(.x[[i]])
    } else {
      if (is_true(.x[[i]][[.f]])) return(.x[[i]])
    }
  }

  NULL

}

detect_index <- function (.x, .f, ..., .right = FALSE, .p) {

  if (inherits(.f, "formula")) {
    .body <- dimnames(attr(stats::terms(.f), "factors"))[[1]]
    .f <- function(.x, .=.x) {}
    body(.f) <- as.expression(parse(text=.body))
  }

  for (i in index(.x, .right)) {
    if (inherits(.f, "function")) {
      if (is_true(.f(.x[[i]], ...))) return(i)
    } else {
      if (is_true(.x[[i]][[.f]])) return(i)
    }
  }

  0L

}

index <- function (x, right = FALSE) {
  idx <- seq_along(x)
  if (right) idx <- rev(idx)
  idx
}
