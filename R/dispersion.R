#' @title Calculate Cross-Sectional Dispersion Measures
#' @param df a `data.frame` holding the SPF data.
#' @param method a function specifying the dispersion measure, e.g. `IQR`, `sd`.
#' @details Computes dispersion measures for the SPF datasets.
#' @return a `tsibble`
#' @seealso [spf::get_individual]
#' @examples
#' \donttest{
#' tmp <- get_individual(survey = "CPI")
#' dsp <- dispersion(tmp, IQR)
#' }
#' @rdname dispersion
#' @export
dispersion <- function(df, method) {
  UseMethod("dispersion")
}

#' @rdname dispersion
#' @export
dispersion.data.frame <- function(df, method = IQR) {
  YEARQUARTER <- NULL
  if (!is.function(method)) {
    stop("method is no function")
  }
  df[, -c(2, 3)] %>%
    dplyr::group_by(YEARQUARTER) %>%
    dplyr::summarize_all(IQR, na.rm = TRUE) %>%
    tsibble::as_tsibble(index = YEARQUARTER) %>%
    return()
}
