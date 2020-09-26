#' @title Download SPFmicrodata as Excel file
#' @description Download the SPFmicrodata.csv dataset.
#' @param file file name
#' @export
get_all <- function(file = "SPFmicrodata.xlsx") {
  url <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/historical-data/spfmicrodata.xlsx?la=en"
  utils::download.file(url = url, destfile = file, mode = "wb")
  return(invisible())
}

#' @title Download probability data as Excel file
#' @description Download the the probability dataset.
#' @param file file name
#' @export
get_prob <- function(file = "prob.xlsx") {
  url <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/historical-data/prob.xlsx?la=en"
  utils::download.file(url = url, destfile = file, mode = "wb")
  return(invisible())
}

#' @title Anxious Index
#' @description Download the Anxious Index dataset.
#' @param file if specified, `write.csv` writes the dataset to the disk with name `file`.
#' @param row.names indicates whether the `write.csv` should write `row.names`.
#' @param ... further arguments passed to `write.csv`.
#' @export
get_anxious_index <- function(file, row.names = FALSE, ...) {
  url <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/anxious-index/anxious_index_chart.xlsx?la=en"
  tf <- tempfile(fileext = ".xlsx")
  utils::download.file(url = url, destfile = tf, mode = "wb")
  df <- readxl::read_excel(tf, na = "#N/A")
  file.remove(tf)

  df$`Obs Quarter` <- df$`Obs Quarter` * 0.25 - 0.25
  df <- cbind(YEARQUARTER = zoo::as.yearqtr(df$`Obs Year` + df$`Obs Quarter`), df)
  df$YEARQUARTER <- tsibble::yearquarter(df$YEARQUARTER)
  df <- df[, -c(2:3)]

  if (!missing(file)) {
    utils::write.csv(df, file = file, row.names, ...)
  }

  return(df)
}

#' @title Inflation
#' @description Download the Inflation dataset.
#' @param file if specified, `write.csv` writes the dataset to the disk with name `file`.
#' @param row.names indicates whether the `write.csv` should write `row.names`.
#' @param ... further arguments passed to `write.csv`.
#' @export
get_inflation <- function(file, row.names = FALSE, ...) {
  url <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/historical-data/inflation.xlsx?la=en"
  tf <- tempfile(fileext = ".xlsx")
  utils::download.file(url = url, destfile = tf, mode = "wb")
  df <- readxl::read_excel(tf, na = "#N/A")
  file.remove(tf)

  df$QUARTER <- df$QUARTER * 0.25 - 0.25
  df <- cbind(YEARQUARTER = zoo::as.yearqtr(df$YEAR + df$QUARTER), df)
  df$YEAR <- tsibble::yearquarter(df$YEAR)
  df <- df[, -c(2:3)]

  if (!missing(file)) {
    utils::write.csv(df, file = file, row.names, ...)
  }
  return(df)
}

#' @title Additional CPIE10
#' @description Download the additional CPIE10 dataset.
#' @param file if specified, `write.csv` writes the dataset to the disk with name `file`.
#' @param row.names indicates whether the `write.csv` should write `row.names`.
#' @param ... further arguments passed to `write.csv`.
#' @export
get_additional_cpie10 <- function(file, row.names = FALSE, ...) {
  url <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/historical-data/additional-cpie10.xlsx?la=en"
  tf <- tempfile(fileext = ".xlsx")
  utils::download.file(url = url, destfile = tf, mode = "wb")
  df <- readxl::read_excel(tf, na = "#N/A")
  file.remove(tf)

  dates <- strsplit(df$`Survey Date`, ":")
  d <- rep(NA, length(dates))
  for (i in 1:length(dates)) {
    d[i] <- zoo::as.yearqtr(paste0(dates[[i]], collapse = " Q"))
  }
  d <- tsibble::yearquarter(zoo::as.yearqtr(d))
  df <- cbind(YEARQUARTER = d, df)
  df <- df[, -2]

  if (!missing(file)) {
    utils::write.csv(df, file = file, row.names, ...)
  }

  return(df)
}
