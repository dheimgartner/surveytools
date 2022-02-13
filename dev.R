devtools::load_all()

SURVEY <- preStudy::survey

library(shiny)

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "slate"),
  surveyOutput("blobb"),
  actionButton("button", "Next Page")
)


server <- function(input, output, session) {
  my_survey <- survey(SURVEY)
  output$blobb <- renderSurvey(my_survey)
  observeEvent(input$button, {
    nextPage("blobb")
  })
}


shinyApp(ui, server)


survey(SURVEY) %>% nextPage()


# interact with the widget
s <- survey(SURVEY)
s
s2 <- htmlwidgets::onRender(s, JS("function(el, x, data){console.log(data); return 1;}"), data = 7)
s2
s2$jsHooks
s2$jsHooks$render[[1]]


new_x <- jsonlite::fromJSON(SURVEY)
new_x$description <- "hello, world"
s$x <- jsonlite::toJSON(new_x)
s
s$x <- SURVEY
s

s3 <- htmlwidgets::onRender(s, JS("function(el, x, data){this['s'].showProgressBar = data}"), data = "bottom")
s3 <- htmlwidgets::onRender(s, JS("function(el, x, data){console.log(this)}"))
s3



# Example: alter survey_json
showQuestionNumber <- function(survey, on = TRUE) {
  s <- jsonlite::fromJSON(survey$x$survey_json)
  if(on) {
    s$showQuestionNumbers <- "on"
  } else {
    s$showQuestionNumbers <- "off"
  }
  survey$x$survey_json <- jsonlite::toJSON(s, auto_unbox = TRUE)
  survey
}

s %>% showQuestionNumber(on = TRUE)
s %>% showQuestionNumber(on = FALSE)

showProgressBar <- function(survey, position = c("off", "top", "bottom", "both")) {
  position <- match.arg(position)
  s <- jsonlite::fromJSON(survey$x$survey_json)
  s$showProgressBar <- position
  survey$x$survey_json <- jsonlite::toJSON(s, auto_unbox = TRUE)
  survey
}

s %>% showProgressBar(position = "off")
s %>% showProgressBar(position = "both")
