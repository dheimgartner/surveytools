addNewQuestion <- function(id, type, parameters) {
  method <- "addNewQuestion"
  callJS(type = "page")
}


#' Title
#'
#' @param id
#' @param question widget
#'
#' @return
#' @export
#'
#' @examples
addQuestion <- function(id, question) {
  method <- "addQuestion"
  callJS(type = "page")
}
