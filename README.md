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
df <- get_individual("NGDP")
tail(df)
#>      YEARQUARTER  ID INDUSTRY    NGDP1    NGDP2    NGDP3    NGDP4    NGDP5    NGDP6
#> 8417     2020 Q3 579        1 19408.80 20384.98 20497.41 20597.55 20683.54 21126.87
#> 8418     2020 Q3 584        1 19408.80 20270.04 20700.32 21014.24 21244.12 21420.96
#> 8419     2020 Q3 585        1 19408.80 20631.68 21027.44 21460.19 21694.82 21804.55
#> 8420     2020 Q3 586        1 19408.80 19982.60 20348.20 20562.50 20786.30 21011.50
#> 8421     2020 Q3 587        1 19408.76 20232.56 20732.60 21055.35 21347.27 21608.73
#> 8422     2020 Q3 588        1 19408.80 20751.67 21359.02 21675.20 21996.78 22282.54
#>      NGDPA NGDPB
#> 8417     1     1
#> 8418     1     1
#> 8419     1     1
#> 8420     1     1
#> 8421     1     1
#> 8422     1     1
```

``` r
df <- get_mean("RGDP", type = "level")
tail(df)
#>     YEARQUARTER   RGDP1    RGDP2    RGDP3    RGDP4    RGDP5    RGDP6    RGDPA    RGDPB
#> 203     2019 Q2 18912.3 19000.29 19103.43 19204.21 19300.12 19397.53 19053.90 19435.76
#> 204     2019 Q3 19023.8 19110.25 19204.55 19298.42 19394.09 19482.52 19068.62 19435.30
#> 205     2019 Q4 19112.5 19193.74 19283.04 19376.66 19461.34 19547.65 19063.77 19416.83
#> 206     2020 Q1 19219.8 19299.81 19401.28 19502.13 19604.59 19701.20 19450.60 19849.56
#> 207     2020 Q2 18987.9 17258.02 17667.70 17940.56 18172.06 18378.07 17973.82 18465.46
#> 208     2020 Q3 17205.8 17981.54 18224.00 18431.25 18598.80 18760.65 18101.86 18679.83
#>        RGDPC    RGDPD
#> 203 19809.12 20270.61
#> 204 19834.82 20282.35
#> 205 19776.05 20214.66
#> 206 20280.59 20676.70
#> 207 19158.13 19673.78
#> 208 19329.32 19748.33
```

``` r
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
