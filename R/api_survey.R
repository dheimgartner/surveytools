addNewPage <- function(id, page_name) {
  method <- "addNewPage"
  callJS(type = "survey")
}


setValue <- function(id, name, value) {
  method <- "setValue"
  callJS(type = "survey")
}


nextPage <- function(id) {
  method <- "nextPage"
  callJS(type = "survey")
}


answersOnComplete <- function(id) {
  method <- "answersOnComplete"
  callJS(type = "survey")
}


onValueChanged <- function(id, question_name, tracking = c("on", "off")) {
  tracking <- match.arg(tracking)
  method <- "onValueChanged"
  callJS(type = "survey")
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
  callJS(type = "survey")
}

