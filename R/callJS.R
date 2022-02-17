#' Title
#'
#' @source <https://deanattali.com/blog/htmlwidgets-tips/#init-once/>
#' @return
#' @export
callJS <- function(type = c("survey", "page", "add")) {
  type <- match.arg(type)
  # The message is just the id, method name, and the params from api func
  message <- Filter(function(x) !is.symbol(x), as.list(parent.frame(1)))
  session <- shiny::getDefaultReactiveDomain()

  # If a widget was passed in, this is during a chain pipeline in the
  # initialization of the widget, so keep track of the desired function call
  # by adding it to a list of functions that should be performed when the widget
  # is ready
  if (methods::is(message$id, type)) {
    widget <- message$id
    message$id <- NULL
    widget$x$api <- c(widget$x$api, list(message))
    return(widget)
  }

  # If an ID was passed, the widget already exists and we can simply call the
  # appropriate JS function
  else if (is.character(message$id)) {
    method <- paste0(type, ":", message$method)
    session$sendCustomMessage(method, message)
    return(message$id)
  } else {
    stop("The `id` argument must be either a htmlwidget or an ID of one")
  }
}
