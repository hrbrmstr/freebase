is_even <- function(x) x %% 2 == 0
is_odd <- function(x) x %% 2 != 0

is_empty <- function(x) length(x) == 0

is_true <- function (x) identical(x, TRUE)
is_false <- function(x) identical(x, FALSE)
