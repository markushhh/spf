#' @title Calculate Dispersion Measures
#' @param df a `data.frame` holding the SPF, or other data.
#' @param f a function specifying the dispersion measure, e.g. `IQR`, `sd`. Defaults to `IQR`.
#' @param ... additional arguments passed to `f`.
#' @details Computes dispersion measures for the SPF datasets.
#' @return a `tsibble`
#' @seealso [spf::get_individual]
#' @examples
#' \donttest{
#' tmp <- get_individual(survey = "CPI")
#' dsp <- summarize_group(tmp, IQR)
#' }
#' @rdname summarize_groups
#' @export
summarize_group <- function(df, f, ...) {
  UseMethod("summarize_group")
}

#' @rdname summarize_groups
#' @export
summarize_group.data.frame <- function(df, f = IQR, ...) {
  ID <- INDUSTRY <- YEARQUARTER <- NULL

  if (!is.function(f)) {
    stop("'f' is no function")
  }
  if ("ID" %in% names(df)) {
    df <- dplyr::select(df, -ID)
  }
  if ("INDUSTRY" %in% names(df)) {
    df <- dplyr::select(df, -INDUSTRY)
  }

  df <- df %>%
    dplyr::group_by(YEARQUARTER) %>%
    dplyr::summarize_all(f, ...)
  return(df)
}
