#' @export
locale <- function(id, locale) {
  method <- "locale"
  callJS()
}


#' @export
showNavigationButtons <- function(id, showNavigationButtons = c("bottom", "top", "both", "none")) {
  showNavigationButtons <- match.arg(showNavigationButtons)
  method <- "showNavigationButtons"
  callJS()
}


#' @export
showQuestionNumbers <- function(id, showQuestionNumbers = c("on", "onpage", "off")) {
  showQuestionNumbers <- match.arg(showQuestionNumbers)
  method <- "showQuestionNumbers"
  callJS()
}


#' @export
showProgressBar <- function(id, showProgressBar = c("off", "top", "bottom", "both")) {
  showProgressBar <- match.arg(showProgressBar)
  method <- "showProgressBar"
  callJS()
}


#' @export
addNewPage <- function(id, name, index) {
  method <- "addNewPage"
  callJS()
}


#' @export
addNewQuestion <- function(id, questionType, name, index) {
  method <- "addNewQuestion"
  callJS()
}


#' @export
title <- function(id, title) {
  method <- "title"
  callJS()
}


#' @export
name <- function(id, name) {
  method <- "name"
  callJS()
}


#' @export
description <- function(id, description) {
  method <- "description"
  callJS()
}


#' @export
isRequired <- function(id) {
  method <- "isRequired"
  callJS()
}


#' @export
requiredErrorText <- function(id, requiredErrorText) {
  method <- "requiredErrorText"
  callJS()
}


#' @export
placeHolder <- function(id, placeHolder) {
  method <- "placeHolder"
  callJS()
}


#' @export
visibleIf <- function(id, expression) {
  method <- "visibleIf"
  callJS()
}


#' @export
requiredIf <- function(id, expression) {
  method <- "requiredIf"
  callJS()
}


#' @export
cssClasses <- function(id) {
  method <- "cssClasses"
  callJS()
}


#' @export
defaultValue <- function(id, defaultValue) {
  method <- "defaultValue"
  callJS()
}


#' @export
inputType <- function(id, inputType = c("color", "date", "datetime", "datetime-local", "email", "month", "number", "password", "range", "tel", "text", "time", "url", "week")) {
  inputType <- match.arg(inputType)
  method <- "inputType"
  callJS()
}


#' @export
max <- function(id, max) {
  method <- "max"
  callJS()
}


#' @export
maxErrorText <- function(id, maxErrorText) {
  method <- "maxErrorText"
  callJS()
}


#' @export
min <- function(id, min) {
  method <- "min"
  callJS()
}


#' @export
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


#' @export
noneText <- function(id, noneText) {
  method <- "noneText"
  callJS()
}


#' @export
otherPlaceHolder <- function(id, otherPlaceHolder) {
  method <- "otherPlaceHolder"
  callJS()
}


#' @export
otherText <- function(id, otherText) {
  method <- "otherText"
  callJS()
}


#' @export
getAllQuestions <- function(id) {
  method <- "getAllQuestions"
  callJS()
}


#' @export
html <- function(id, html) {
  method <- "html"
  callJS()
}


#' @export
toJSON <- function(id) {
  method <- "toJSON"
  callJS()
}


#' @export
setValue <- function(id, name, value) {
  method <- "setValue"
  callJS()
}


#' @export
nextPage <- function(id) {
  method <- "nextPage"
  callJS()
}


#' @export
answersOnComplete <- function(id) {
  method <- "answersOnComplete"
  callJS()
}


#' @export
doComplete <- function(id) {
  method <- "doComplete"
  callJS()
}


#' @export
onValueChanged <- function(id, name = NULL) {
  method <- "onValueChanged"
  callJS()
}


#' @export
completedHtml <- function(id, completedHtml) {
  method <- "completedHtml"
  callJS()
}


#' @export
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
callback <- function(id, JS, object = c("default", "survey", "page", "question")) {
  object <- match.arg(object)
  method <- "callback"
  callJS()
}

