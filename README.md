<!-- README.md is generated from README.Rmd. Please edit that file -->

spf <a href='https://github.com/markushhh/spf'><img src='man/figures/sticker.png' align="right" height="138.5" /></a>
=====================================================================================================================

<!-- badges: start -->
<!-- badges: end -->

`spf` offers the possibility to download data from the [Survey of
Professional
Forecasters](https://www.philadelphiafed.org/research-and-data/real-time-center/survey-of-professional-forecasters/data-files)
(SPF) provided by the Federal Reserve Bank of Philadelphia.

Installation
------------

``` r
devtools::install_github("markushhh/spf")
```

Examples
--------

``` r
df <- get_individual("EMP")
df <- get_mean("RGDP", type = "level")
df <- get_mean("RGDP", type = "growth")
df <- get_mean("RGDP", type = "pct")
df <- get_mean("EMP", type = "level")
df <- get_mean("EMP", type = "pct")
df <- get_mean("EMP", type = "ave")
df <- get_median("EMP", type = "level")
df <- get_median("EMP", type = "pct")
df <- get_median("EMP", type = "ave")
df <- get_dispersion("EMP")
df <- get_anxious_index()
df <- get_inflation()
df <- get_additional_cpie10()
get_all(file = "SPFmicrodata.xlsx") # download and writes "SPFmicrodata.xlsx" to the disk
get_prob(file = "prob.xlsx") # download and writes "prob.xlsx" to the disk
```

Survey of Professional Forecasters in Europe (ECB)
--------------------------------------------------

For the survey of professional forecasters in Europe, visit the [ECB’s
Data Warehouse](https://sdw.ecb.europa.eu/browse.do?node=9691152) The R
package [ecb](https://github.com/expersso/ecb) may be useful.

Code of Conduct
---------------

Please note that the spf project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

Disclaimer
----------

This package is in no way officially related to, or endorsed by, the
Federal Reserve Bank of Philadelphia nor the European Central Bank.
