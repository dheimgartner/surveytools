addNewPage <- function(id, page_name) {
  method <- "addNewPage"
  callJS()
}


setValue <- function(id, name, value) {
  method <- "setValue"
  callJS()
}


nextPage <- function(id) {
  method <- "nextPage"
  callJS()
}


answersOnComplete <- function(id) {
  method <- "answersOnComplete"
  callJS()
}


onValueChanged <- function(id, question_name, tracking = c("on", "off")) {
  tracking <- match.arg(tracking)
  method <- "onValueChanged"
  callJS()
}


#' Evaluate any JavaScript code after the `survey` object has been initialized
#'
#' @param id widget or input$id
#' @param JS use `htmlwidgets::JS`
#'
#' @source <https://surveyjs.io/Documentation/Library?id=SurveyModel/>
#'
#' @return
#' @export
#'
#' @examples
#' # The `onValueChanged` api could be implemented via
#' \dontrun{
#'
#' }
callback <- function(id, JS) {
  method <- "callback"
  callJS()
}

