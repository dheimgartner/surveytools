devtools::load_all()

SURVEY <- surveyjR::SURVEY$cancellation

library(shiny)

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "slate"),
  surveyOutput("blobb")
)


server <- function(input, output, session) {
  my_survey <- survey(SURVEY)
  output$blobb <- renderSurvey(my_survey)
}


shinyApp(ui, server)


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

s3 <- htmlwidgets::onRender(s, JS("function(el, x, data){this.showProgressBar = data}"), data = TRUE)
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

s %>% showQuestionNumber()


# Example: apply method from JS lib
addNewPage <- function(survey, page_name) {
  ## How can we access the survey object in a java script function?
  survey %>%
    # el is the whole html element
    # x is exactly what we pass in the survey() as x
    # data is data which can be passed to JS
    # this is the widget instance object
    htmlwidgets::onRender(JS("function(el, x, data) {this.s.addNewPage('blobb');}"))
}


addNewPage() <- function(survey, page_name) {
  message <- list(id = id, page_name = page_name)
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage("survey::addNewPage", message)
}



s %>% addNewPage(page_name = NULL)
