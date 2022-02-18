library(shiny)

devtools::load_all()

rm(list = ls())


# multilanguage: does not work...
s <-
  survey() %>%
  locale("de") %>%
  addNewPage("page") %>%
  addNewQuestion("text") %>%
  title(list(default = "Was ist Ihr Lieblingsessen", en = "What's your favourite food?")) %>%
  name("favourite_language") %>%
  toJSON()
s


ui <- fluidPage(
  surveyOutput("survey1"),
  actionButton("complete1", "Complete Survey 1"),
  surveyOutput("survey2"),
  actionButton("complete2", "Complete Survey 2"),
)


server <- function(input, output, session) {
  survey1 <-
    survey() %>%
    locale("de") %>%
    showQuestionNumbers("off") %>%

    addNewPage("page1") %>%
    addNewQuestion("text") %>%
    title("What's your name?") %>%
    name("name") %>%
    placeHolder("Your name") %>%
    inputType("text") %>%
    onValueChanged(name = "name", tracking = "on") %>%

    addNewPage("page2") %>%
    addNewQuestion("text") %>%
    title("How old are you?") %>%
    name("age") %>%
    inputType("number") %>%
    size(10) %>%
    min(18) %>%
    minErrorText("Du bist zu jung!") %>%
    max(30) %>%
    maxErrorText("Du bist zu alt!") %>%
    requiredIf("{name} == Daniel") %>%
    requiredErrorText("blobb") %>%
    onValueChanged(name = "age", tracking = "on") %>%
    showNavigationButtons("bottom") %>%

    addNewQuestion("radiogroup") %>%
    title("What's your gender?") %>%
    name("gender") %>%
    choices(list(list(value = 1, text = "male"), list(value = 2, text = "female"))) %>%
    otherText("Other") %>%
    otherPlaceHolder("Bitte geben Sie an") %>%
    noneText("This is a none item") %>%

    addNewQuestion("dropdown") %>%
    title("Where do you come frome?") %>%
    name("country") %>%
    choices(list(list(value = "CH", text = "Switzerland"),
                 list(value = "DE", text = "Deutschland"))) %>%

    answersOnComplete() %>%
    toJSON()

  survey2 <-
    survey() %>%
    locale("en") %>%
    addNewPage("page1") %>%
    addNewQuestion("text") %>%
    title("What's your name?") %>%
    name("name") %>%
    onValueChanged(name = "name", tracking = "on") %>%
    addNewPage("page2") %>%
    addNewQuestion("text") %>%
    title("How old are you?") %>%
    name("age") %>%
    onValueChanged(name = "age", tracking = "on") %>%
    showNavigationButtons("top") %>%
    answersOnComplete() %>%
    toJSON()

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
