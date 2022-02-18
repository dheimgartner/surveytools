devtools::load_all()

rm(list = ls())

ui <- fluidPage(
  actionButton("button", "Next Page"),
  surveyOutput("survey1"),
  actionButton("complete1", "Complete Survey 1"),
  surveyOutput("survey2"),
  actionButton("complete2", "Complete Survey 2"),
)


server <- function(input, output, session) {
  survey1 <-
    survey() %>%
    addNewPage("page1") %>%
    addNewQuestion("text") %>%
    title("What's your name?") %>%
    name("name") %>%
    onValueChanged(question_name = "name", tracking = "on") %>%
    addNewPage("page2") %>%
    addNewQuestion("text") %>%
    title("How old are you?") %>%
    name("age") %>%
    onValueChanged(question_name = "age", tracking = "on") %>%
    showNavigationButtons(show = FALSE) %>%
    answersOnComplete()

  survey2 <-
    survey() %>%
    addNewPage("page1") %>%
    addNewQuestion("text") %>%
    title("What's your name?") %>%
    name("name") %>%
    onValueChanged(question_name = "name", tracking = "on") %>%
    addNewPage("page2") %>%
    addNewQuestion("text") %>%
    title("How old are you?") %>%
    name("age") %>%
    onValueChanged(question_name = "age", tracking = "on") %>%
    showNavigationButtons(show = TRUE) %>%
    answersOnComplete()

  output$survey1 <- renderSurvey(survey1)
  output$survey2 <- renderSurvey(survey2)

  observeEvent(input$button, {
    nextPage("survey1")
  })

  observeEvent(input$survey1_answersOnComplete, {
    answers1 <<- input$survey1_answersOnComplete
  })

  observeEvent(input$survey2_answersOnComplete, {
    answers2 <<- input$survey2_answersOnComplete
  })

  observeEvent(input$survey1_name_onValueChanged, {
    cat("`survey1 name` value changed to", input$survey1_name_onValueChanged, "\n")
  })

  observeEvent(input$survey1_age_onValueChanged, {
    cat("`survey1 age` value changed to", input$survey1_age_onValueChanged, "\n")
  })

  observeEvent(input$survey2_name_onValueChanged, {
    cat("`survey2 name` value changed to", input$survey2_name_onValueChanged, "\n")
  })

  observeEvent(input$survey2_age_onValueChanged, {
    cat("`survey2 age` value changed to", input$survey2_age_onValueChanged, "\n")
  })
}


shinyApp(ui, server)







SURVEY <- preStudy::survey

library(shiny)

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "slate"),
  actionButton("button", "Next Page"),
  # actionButton("stop_tracking", "Stop Tracking"),
  surveyOutput("blobb")
)


server <- function(input, output, session) {
  my_survey <-
    survey(SURVEY) %>%
    onValueChanged(question_name = "gender", tracking = "on") %>%
    onValueChanged(question_name = "lonely", tracking = "on") %>%
    answersOnComplete()

  output$blobb <- renderSurvey(my_survey)
  observeEvent(input$button, {
    nextPage("blobb")
  })

  # TODO: remove onValueChanged event listener in case "off"!
  observeEvent(input$stop_tracking, {
    onValueChanged("blobb", question_name = "gender", tracking = "off")
  })

  observeEvent(input$blobb_answersOnComplete, {
    answers <<- input$blobb_answersOnComplete
  })

  observeEvent(input$blobb_gender_onValueChanged, {
    cat("`gender` value changed to", input$blobb_gender_onValueChanged, "\n")
  })

  observeEvent(input$blobb_lonely_onValueChanged, {
    cat("`lonely` value changed to", input$blobb_lonely_onValueChanged, "\n")
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
