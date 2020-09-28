#' @title Download SPF Data
#' @description Download a dataaset from the Survey of Professional Forecasters (SPF) provided by the Federal Reserve Bank of Philadelphia.
#' @param survey The survey you want to download, e.g. "NGDP", "CPI", prgdp".
#' @param type one of level: "level", change: "pct", or "ave".
#' @param file path, the data gets written to, e.g. "file.csv"
#' @param row.names, passed to `write.csv`.
#' @param ... further arguments passed to `write.csv`.
#' @details Download data from the \href{https://www.philadelphiafed.org/research-and-data/real-time-center/survey-of-professional-forecasters}{Survey of Professional Forecasters provided by the Federal Reserve Bank of Philadelphia}.
#' @seealso [utils::write.csv()]
#' @return Returns a `data.frame`.
#' @examples
#' \dontrun{
#' get_individual("EMP")
#' get_mean("RGDP", type = "growth")
#' get_mean("EMP", type = "level")
#' get_mean("EMP", type = "pct")
#' get_mean("EMP", type = "ave")
#' get_median("EMP", type = "level")
#' get_median("EMP", type = "pct")
#' get_median("EMP", type = "ave")
#' get_dispersion("EMP")
#' }
#' @importFrom magrittr %>%
#' @importFrom stats IQR
#' @export
get_individual <- function(survey, file, row.names = FALSE, ...) {
  YEARQUARTER <- NULL
  url <- url_individual(survey)

  tt <- httr::GET(url)
  if (tt$headers$`content-type` != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
    stop("get_data can't find the dataset \n", url)
  }

  tf <- tempfile(fileext = ".xlsx")
  utils::download.file(url = url, destfile = tf, mode = "wb")
  df <- readxl::read_excel(tf, na = "#N/A")
  file.remove(tf)

  df$QUARTER <- df$QUARTER * 0.25 - 0.25
  df <- cbind(YEARQUARTER = zoo::as.yearqtr(df$YEAR + df$QUARTER), df)
  df$YEARQUARTER <- tsibble::yearquarter(df$YEARQUARTER)

  df <- df[, -c(2, 3)]
  df$INDUSTRY <- as.integer(df$INDUSTRY)

  df <- df %>% dplyr::mutate_at(dplyr::vars(dplyr::starts_with(survey)), as.numeric)
  if (!missing(file)) {
    utils::write.csv(df, file = file, row.names = row.names)
  }
  return(df)
}
