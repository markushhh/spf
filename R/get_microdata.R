#' @title Download SPFmicrodata as Excel file
#' @description Download the SPFmicrodata.csv dataset.
#' @param file file name
#' @export
get_microdata <- function(file = "SPFmicrodata.xlsx") {
  url <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/historical-data/spfmicrodata.xlsx?la=en"
  utils::download.file(url = url, destfile = file, mode = "wb")
  return(invisible())
}
