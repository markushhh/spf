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
