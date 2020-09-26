url_base <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/data-files/files/individual_"

url_individual <- function(survey) {
  url <- paste0(url_base, survey, ".xlsx")
  return(url)
}

url_mean <- function(survey, type) {
  url_base <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/data-files/files/mean_"
  if (type == "level") {
    what <- "level"
  } else if (type == "growth") {
    what <- "growth"
  } else if (type %in% c("pct", "pct_chg")) {
    what <- "pct_chg"
  } else if (type %in% c("avg_chg", "ave", "ave_chg")) {
    what <- "ave_chg"
  } else {
    stop(type, " not implemented yet")
  }
  url <- paste0(url_base, survey, "_", what, ".xlsx")
  return(url)
}

url_median <- function(survey, type) {
  url_base <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/data-files/files/median_"
  if (type == "level") {
    what <- "level"
  } else if (type == "pct") {
    what <- "pct_chg"
  } else if (type == "ave") {
    what <- "ave_chg"
  } else {
    stop(type, " not implemented yet")
  }
  url <- paste0(url_base, survey, "_", what, ".xlsx")
  return(url)
}

url_dispersion <- function(survey) {
  url_base <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/data-files/files/dispersion_"
  url <- paste0(url_base, survey, ".xlsx")
  return(url)
}

if (FALSE) {
indi <- c("NGDP", "PGDP", "CPROF", "UNEMP", "EMP", "INDPROD", "HOUSING", "TBILL", "BOND", "BAABOND", "TBOND", "RGDP", "RCONSUM", "RNRESIN", "RRESINV", "RFEDGOV", "RSLGOV", "RCBI", "REXPORT", "CPI", "CORECPI", "PCE", "COREPCE", "CPI5YR", "PCE5YR", "CPI10", "PCE10", "RGDP10", "PROD10", "STOCK10", "BOND10", "BILL10", "UBAR", "PRGDP", "PRPGDP", "PRCCPI", "PRCPCE", "PRUNEMP", "RECESS", "RGDP", "SPR_TBOND_TBILL", "SPR_BAA_AAA", "SPR_BAA_TBOND", "SPR_AAA_TBOND", "CPIF5", "PCEF5", "RR1_TBILL_PGDP", "RR2_TBILL_PGDP", "RR3_TBILL_PGDP", "RR1_TBILL_CPI", "RR2_TBILL_CPI", "RR3_TBILL_CPI", "RR1_TBILL_CCPI", "RR2_TBILL_CCPI", "RR3_TBILL_CCPI", "RR1_TBILL_PCE", "RR2_TBILL_PCE", "RR3_TBILL_PCE", "RR1_TBILL_CPCE", "RR2_TBILL_CPCE", "RR3_TBILL_CPCE")
n <- length(indi)

for (indi in indi[6:n]) {
  print(indi)
  get_individual(indi)
}
}

