#' @describeIn get_individual Download median SPF data
#' @export
get_median <- function(survey, type = "level", file, row.names = FALSE, ...) {
  url <- url_median(survey, type)

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

  df <- df %>% dplyr::mutate_at(dplyr::vars(dplyr::starts_with(survey)), as.numeric)
  if (!missing(file)) {
    utils::write.csv(df, file = file, row.names, ...)
  }
  return(df)
}
