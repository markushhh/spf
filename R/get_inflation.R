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
    utils::write.csv(df, file = file, row.names = row.names, ...)
  }
  return(df)
}
