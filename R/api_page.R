addNewPage <- function(id, name, index) {
  method <- "addNewPage"
  callJS(type = "page")
}


addNewQuestion <- function(id, questionType, name, index) {
  method <- "addNewQuestion"
  callJS(type = "page")
}


title <- function(id, title) {
  method <- "title"
  callJS(type = "page")
}


name <- function(id, title) {
  method <- "name"
  callJS(type = "page")
}


description <- function(id, description) {
  method <- "description"
  callJS(type = "page")
}



addQuestion <- function(id) {
  method <- "addQuestion"
  callJS(type = "page")
}
