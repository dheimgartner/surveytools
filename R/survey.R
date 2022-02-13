#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
survey <- function(survey_json, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x <- list(
    survey_json = survey_json
  )

  # API tracker
  x$api <- list()

  # answer tracker
  x$answers <- list()

  # test
  x$test <- list()

  # create widget
  htmlwidgets::createWidget(
    name = 'survey',
    x,
    width = width,
    height = height,
    package = 'surveytools',
    elementId = elementId
  )
}

#' Shiny bindings for survey
#'
#' Output and render functions for using survey within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a survey
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name survey-shiny
#'
#' @export
surveyOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'survey', width, height, package = 'surveytools')
}

#' @rdname survey-shiny
#' @export
renderSurvey <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, surveyOutput, env, quoted = TRUE)
}
