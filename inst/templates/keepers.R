# NOTE!!!
# This requires map_lgl() which requries map()

is_empty <- function(x) length(x) == 0

keep <- function(.x, .p, ...) {
  .x[map_lgl(.x, .p, ...)]
}

discard <- function(.x, .p, ...) {
  .x[!map_lgl(.x, .p, ...)]
}

compact <- function(.x, .p=identity) {
  discard(.x, function(x) is_empty(.p(x)))
}
