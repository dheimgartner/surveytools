locale <- function(id, locale) {
  method <- "locale"
  callJS()
}


showNavigationButtons <- function(id, showNavigationButtons = c("bottom", "top", "both", "none")) {
  showNavigationButtons <- match.arg(showNavigationButtons)
  method <- "showNavigationButtons"
  callJS()
}


showQuestionNumbers <- function(id, showQuestionNumbers = c("on", "onpage", "off")) {
  showQuestionNumbers <- match.arg(showQuestionNumbers)
  method <- "showQuestionNumbers"
  callJS()
}


showProgressBar <- function(id, showProgressBar = c("off", "top", "bottom", "both")) {
  showProgressBar <- match.arg(showProgressBar)
  method <- "showProgressBar"
  callJS()
}


addNewPage <- function(id, name, index) {
  method <- "addNewPage"
  callJS()
}


addNewQuestion <- function(id, questionType, name, index) {
  method <- "addNewQuestion"
  callJS()
}


title <- function(id, title) {
  method <- "title"
  callJS()
}


name <- function(id, name) {
  method <- "name"
  callJS()
}


description <- function(id, description) {
  method <- "description"
  callJS()
}


isRequired <- function(id) {
  method <- "isRequired"
  callJS()
}


requiredErrorText <- function(id, requiredErrorText) {
  method <- "requiredErrorText"
  callJS()
}


placeHolder <- function(id, placeHolder) {
  method <- "placeHolder"
  callJS()
}


visibleIf <- function(id, expression) {
  method <- "visibleIf"
  callJS()
}


requiredIf <- function(id, expression) {
  method <- "requiredIf"
  callJS()
}


cssClasses <- function(id) {
  method <- "cssClasses"
  callJS()
}


defaultValue <- function(id, defaultValue) {
  method <- "defaultValue"
  callJS()
}


inputType <- function(id, inputType = c("color", "date", "datetime", "datetime-local", "email", "month", "number", "password", "range", "tel", "text", "time", "url", "week")) {
  inputType <- match.arg(inputType)
  method <- "inputType"
  callJS()
}


max <- function(id, max) {
  method <- "max"
  callJS()
}


maxErrorText <- function(id, maxErrorText) {
  method <- "maxErrorText"
  callJS()
}


min <- function(id, min) {
  method <- "min"
  callJS()
}


minErrorText <- function(id, minErrorText) {
  method <- "minErrorText"
  callJS()
}


#' (Not text size)
#'
#' @param id
#' @param size
#'
#' @return
#' @export
#'
#' @examples
size <- function(id, size) {
  method <- "size"
  callJS()
}


#' Title
#'
#' @param id
#' @param choices list of named list with names value and text
#'
#' @return
#' @export
#'
#' @examples
choices <- function(id, choices) {
  method <- "choices"
  callJS()
}


noneText <- function(id, noneText) {
  method <- "noneText"
  callJS()
}


otherPlaceHolder <- function(id, otherPlaceHolder) {
  method <- "otherPlaceHolder"
  callJS()
}


otherText <- function(id, otherText) {
  method <- "otherText"
  callJS()
}


getAllQuestions <- function(id) {
  method <- "getAllQuestions"
  callJS()
}


toJSON <- function(id) {
  method <- "toJSON"
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


doComplete <- function(id) {
  method <- "doComplete"
  callJS()
}


onValueChanged <- function(id, name = NULL) {
  method <- "onValueChanged"
  callJS()
}


completedHtml <- function(id, completedHtml) {
  method <- "completedHtml"
  callJS()
}


showCompletedPage <- function(id, showCompletedPage) {
  method <- "showCompletedPage"
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
callback <- function(id, JS, object = c("survey", "page", "question")) {
  object <- match.arg(object)
  method <- "callback"
  callJS()
}

