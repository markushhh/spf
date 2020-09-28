#' @title Download probability data as Excel file
#' @description Download the the probability dataset.
#' @param file file name
#' @export
get_prob <- function(file = "prob.xlsx") {
  url <- "https://www.philadelphiafed.org/-/media/research-and-data/real-time-center/survey-of-professional-forecasters/historical-data/prob.xlsx?la=en"
  utils::download.file(url = url, destfile = file, mode = "wb")
  return(invisible())
}
