# NOTE these aren't 100% equivalent to the purrr mappers but cover very common use-cases
map <- function(.x, .f, ...) {

  if (inherits(.f, "formula")) {
    .body <- dimnames(attr(terms(.f), "factors"))[[1]]
    .f <- function(.x, .=.x) {}
    body(.f) <- as.expression(parse(text=.body))
  }

  if (inherits(.f, "function")) {
    lapply(.x, .f, ...)
  } else if (is.numeric(.f)) {
    lapply(.x, `[`, .f)
  }

}

map2 <- function(.x, .y, .f, ...) {

  if (inherits(.f, "formula")) {
    .body <- dimnames(attr(terms(.f), "factors"))[[1]]
    .f <- function(.x, .y, .=.x) {}
    body(.f) <- as.expression(parse(text=.body))
  }

  if (inherits(.f, "function")) {
    mapply(.f, .x, .y, ..., SIMPLIFY=FALSE, USE.NAMES=FALSE)
  }

}

map_chr <- function(.x, .f, ...) {
  as.character(unlist(map(.x, .f, ...), use.names = FALSE))
}

map2_chr <- function(.x, .y, .f, ...) {
  as.character(unlist(map2(.x, .y, .f, ...), use.names = FALSE))
}

map_lgl <- function(.x, .f, ...) {
  as.logical(unlist(map(.x, .f, ...), use.names = FALSE))
}

map2_lgl <- function(.x, .y, .f, ...) {
  as.logical(unlist(map2(.x, .y, .f, ...), use.names = FALSE))
}

map_dbl <- function(.x, .f, ...) {
  as.double(unlist(map(.x, .f, ...), use.names = FALSE))
}

map2_dbl <- function(.x, .y, .f, ...) {
  as.double(unlist(map2(.x, .y, .f, ...), use.names = FALSE))
}

map_int <- function(.x, .f, ...) {
  as.integer(unlist(map(.x, .f, ...), use.names = FALSE))
}

map2_int <- function(.x, .y, .f, ...) {
  as.integer(unlist(map2(.x, .y, .f, ...), use.names = FALSE))
}


map_df <- function(.x, .f, ..., .id=NULL) {

  res <- map(.x, .f, ...)
  out <- bind_rows(res, .id=.id)
  out

}

map2_df <- function(.x, .y, .f, ..., .id=NULL) {

  res <- map(.x, .y, .f, ...)
  out <- bind_rows(res, .id=.id)
  out

}

# this has limitations and is more like 75% of dplyr::bind_rows()
# this is also orders of magnitude slower than dplyr::bind_rows()
bind_rows <- function(..., .id = NULL) {

  res <- list(...)

  if (length(res) == 1) res <- res[[1]]

  cols <- unique(unlist(lapply(res, names), use.names = FALSE))

  if (!is.null(.id)) {
    inthere <- cols[.id %in% cols]
    if (length(inthere) > 0) {
      .id <- make.unique(c(inthere, .id))[2]
    }
  }

  id_vals <- if (is.null(names(res))) 1:length(res) else names(res)

  saf <- default.stringsAsFactors()
  options(stringsAsFactors = FALSE)
  on.exit(options(stringsAsFactors = saf))

  idx <- 1
  do.call(
    rbind.data.frame,
    lapply(res, function(.x) {
      x_names <- names(.x)
      moar_names <- setdiff(cols, x_names)
      if (length(moar_names) > 0) {
        for (i in 1:length(moar_names)) {
          .x[[moar_names[i]]] <- rep(NA, length(.x[[1]]))
        }
      }
      if (!is.null(.id)) {
        .x[[.id]] <- id_vals[idx]
        idx <<- idx + 1
      }
      .x
    })
  ) -> out

  rownames(out) <- NULL

  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}
