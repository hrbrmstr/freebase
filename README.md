
# freebase

A ‘usethis’-like Package for Base Pseudo-equivalents of ‘tidyverse’ Code

## Description

The ‘tidyverse’ is awesome, but can take a bit compile on systems where
there are no pre-built binary packages. Methods are provided which use
the facilities of the ‘usethis’ package to snap-in base versions of
useful ‘tidyverse’ functions that are mostly equivalent (some are more
complete than others). The base R counterpart functions will likely be
slower than the ‘tidyverse’ equivalents but using them will decrease
‘Imports’ dependencies.

Use deliberately and with caution.

## What’s Inside The Tin

The following functions are implemented:

  - `use_detect`: Use base-ified equivalents of “detect”-ors (these
    support `~{}` formula functions)
  - `use_infix_helpers`: Use infix-helpers
  - `use_isers`: Use “is\_” functions
  - `use_keepers`: Use base-ified equivalents of keep/discard/compact
    (these support `~{}` formula functions)
  - `use_mappers`: Use base-ified equivalents of ‘map’-pers (these
    support `~{}` formula functions)
  - `use_safely`: Use base-ified equivalents of “safely”-ifiers
  - `use_tidylite()`: Use base R versions of ‘tidyr’
    ‘gather’/‘spread’/‘unite’
  - `use_walkers`: Use base-ified equivalents of keep/discard/compact
    (these support `~{}` formula functions)

## Installation

``` r
devtools::install_github("hrbrmstr/freebase")
```

## Usage

``` r
library(freebase)

# current verison
packageVersion("freebase")
```

    ## [1] '0.1.0'
