
#' @describeIn get_individual Download mean SPF data
#' @export
get_mean <- function(survey, type = "level", file, row.names = FALSE, ...) {
  url <- url_mean(survey, type)

  tt <- httr::GET(url)
  if (tt$headers$`content-type` !=
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
    diff_ <- setdiff(c("level", "growth", "pct", "ave"), type)
    stop("get_data can't find the dataset \n", url, "\n",
         "Maybe you meant one of: ", paste0(diff_, collapse  = ", ", recycle0 = TRUE))
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
