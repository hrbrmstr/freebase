
# freebase

A ‘usethis’-esque Package for Base R Versions of ‘tidyverse’ Code

## Description

The ‘tidyverse’ is awesome, but can take a bit to compile on systems
where there are no pre-built binary packages. Methods are provided which
use the facilities of the ‘usethis’ package to snap-in base versions of
useful ‘tidyverse’ functions that are mostly equivalent (some are more
complete than others). The base R counterpart functions will likely be
slower than the ‘tidyverse’ equivalents but using them will decrease
‘Imports’ dependencies.

Use deliberately and with caution.

## What’s Inside The Tin

The following functions are implemented:

  - `use_detect`: Use base R versions of `purrr` `detect` functions
    (these support `~{}` formula functions)
  - `use_infix_helpers`: Use infix-helpers
  - `use_isers`: Use “is\_” tester functions
  - `use_keepers`: Use base R versions of `purrr` `keep` functions
    (these support `~{}` formula functions)
  - `use_mappers`: Use base R versions of `purrr` `map` functions (these
    support `~{}` formula functions) along with `set_names()`
  - `use_safely`: Use base R versions of `purrr` `safely` functions
  - `use_tidylite()`: Use base R versions of core `tidyr` functions
  - `use_walkers`: Use base R versions of `purrr` `walk` functions
    (these support `~{}` formula functions)

## Installation

``` r
devtools::install_git("git://gitlab.com/hrbrmstr/freebase")
```

## Usage

``` r
library(freebase)

# current version
packageVersion("freebase")
```

    ## [1] '0.2.0'
