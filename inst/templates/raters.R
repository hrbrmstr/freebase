#' Transform a function to make it run insistently or slowly
#'
insistently <- function(.f, rate = rate_backoff(), quiet = TRUE) {

  stopifnot(is_rate(rate))

  function(...) {
    rate_reset(rate) #

    repeat {
      rate_sleep(rate, quiet = quiet) #
      out <- capture_error(.f(...), quiet = quiet)

      if (is.null(out$error)) {
        return(out$result)
      }
    }
  }
}

slowly <- function(f, rate = rate_delay(), quiet = TRUE) {

  stopifnot(is_rate(rate))

  function(...) {
    rate_sleep(rate, quiet = quiet)
    f(...)
  }
}

#' Create delaying rate settings
#'
rate_delay <- function(pause = 1,
                       max_times = Inf) {
  stopifnot(is.numeric(pause))
  new_rate(
    "rate_delay",
    pause = pause,
    max_times = max_times,
    jitter = FALSE
  )
}

rate_backoff <- function(pause_base = 1,
                         pause_cap = 60,
                         pause_min = 1,
                         max_times = 3,
                         jitter = TRUE) {
  stopifnot(
    is.numeric(pause_base),
    is.numeric(pause_cap),
    is.numeric(pause_min)
  )
  new_rate(
    "rate_backoff",
    pause_base = pause_base,
    pause_cap = pause_cap,
    pause_min = pause_min,
    max_times = max_times,
    jitter = jitter
  )
}

new_rate <- function(.subclass, ..., jitter = TRUE, max_times = 3) {
  stopifnot(
    is.logical(jitter),
    is.numeric(max_times) || identical(max_times, Inf)
  )

  rate <- list(
    ...,
    state = new.env(),
    jitter = jitter,
    max_times = max_times
  )

  rate$state$i <- 0L

  structure(
    rate,
    class = c(.subclass, "rate")
  )
}

is_rate <- function(x) {
  inherits(x, "rate")
}

rate_sleep <- function(rate, quiet = TRUE) {
  stopifnot(is_rate(rate))

  i <- rate_count(rate)

  if (i > rate$max_times) {
    stop("Error rate expired!", call. = FALSE)
  }
  if (i == rate$max_times) {
    rate_bump_count(rate)
    stop("Error rate exceeded maximum number of attempts!", call. = FALSE)
  }

  if (i == 0L) {
    rate_bump_count(rate)
    return(invisible())
  }

  on.exit(rate_bump_count(rate))
  UseMethod("rate_sleep")
}

rate_sleep.rate_backoff <- function(rate, quiet = TRUE) {
  i <- rate_count(rate)

  pause_max <- min(rate$pause_cap, rate$pause_base * 2^i)
  if (rate$jitter) {
    pause_max <- stats::runif(1, 0, pause_max)
  }

  length <- max(rate$pause_min, pause_max)
  Sys.sleep(length)
}

rate_sleep.rate_delay <- function(rate, quiet = TRUE) {
  Sys.sleep(rate$pause)
}


rate_reset <- function(rate) {
  stopifnot(is_rate(rate))

  rate$state$i <- 0L

  invisible(rate)
}

rate_count <- function(rate) {
  rate$state$i
}

rate_bump_count <- function(rate, n = 1L) {
  rate$state$i <- rate$state$i + n
  invisible(rate)
}

