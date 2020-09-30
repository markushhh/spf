#' @describeIn get_individual Download disersion SPF data
#' @export
get_dispersion <- function(survey, file, row.names = FALSE, ...) {
  url <- url_dispersion(survey)

  tt <- httr::GET(url)
  if (tt$headers$`content-type` != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
    stop("get_data can't find the dataset \n", url)
  }

  tf <- tempfile(fileext = ".xlsx")
  utils::download.file(url = url, destfile = tf, mode = "wb")
  df <- readxl::read_excel(tf, na = "#N/A", skip = 9)
  file.remove(tf)

  df$`Survey_Date(T)` <- tsibble::yearquarter(df$`Survey_Date(T)`)

  if (!missing(file)) {
    utils::write.csv(df, file = file, row.names = row.names, ...)
  }
  return(df)
}
