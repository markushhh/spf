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
