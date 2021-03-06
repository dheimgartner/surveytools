library(shiny)

devtools::load_all()

rm(list = ls())

# infer from json...
survey <-
  survey() %>%
  locale("en") %>%
  showCompletedPage(FALSE) %>%
  showProgressBar("off") %>%

  addNewPage("single") %>%
  addNewQuestion("matrix") %>%
  title("Do you like...") %>%
  name("single") %>%
  rows(list(list(value = 1, text = "...pizza"), list(value = 2, text = "...ravioli"))) %>%
  columns(list(list(value = 1, text = "yes"), list(value = 0, text = "no"))) %>%
  track() %>%

  addNewPage("radio") %>%
  addNewQuestion("radiogroup") %>%
  title("What do you prefer?") %>%
  name("radio") %>%
  choices(list(list(value = "pizza", text = "Pizza"), list(value = "ravioli", text = "Ravioli"))) %>%
  onValueChanged() %>%

  answersOnComplete()

survey

ui <- fluidPage(
  surveyOutput("survey")
)

server <- function(input, output, session) {
  output$survey <- renderSurvey(survey)

  observeEvent(input$survey_single_track, {
    browser()
    test1 <<- input$survey_single_track
  })

  observeEvent(input$survey_radio_track, {
    test2 <<- input$survey_radio_track
  })
}

shinyApp(ui, server)





survey <-
  survey() %>%
  locale("en") %>%
  showQuestionNumbers("on") %>%
  showNavigationButtons("top") %>%
  showCompletedPage(FALSE) %>%
  showProgressBar("off") %>%

  addNewPage("page1") %>%
  addNewQuestion("text") %>%
  inputType("text") %>%
  title("What's your name?") %>%
  name("name") %>%

  addNewPage("page2") %>%
  addNewQuestion("text") %>%
  inputType("date") %>%
  title("What's your date of birth?") %>%
  name("birth_date") %>%

  addNewPage("page3") %>%
  addNewQuestion("html") %>%
  html(HTML("<h1>hello, world</h1><br><button id='action' type='button' class='btn btn-default action-button'>Action</button>"))
  # callback(JS("function(question){question.html = '<h1>hello, world!</h1>';}"), object = "question") %>%
  # callback(JS("function(){console.log('blobb');}"))

survey


ui <- fluidPage(
  HTML("<h1>hello, world</h1><br><button id='action' type='button' class='btn btn-default action-button'>Action</button>"),
  surveyOutput("survey")

)

server <- function(input, output, session) {
  output$survey <- renderSurvey(survey)
  observeEvent(input$action, {cat("action\n")})
}

shinyApp(ui, server)


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
  actionButton("complete1", "Complete Survey 1"),
  surveyOutput("survey1"),
  surveyOutput("survey2")
)


server <- function(input, output, session) {
  survey1 <-
    survey() %>%
    locale("de") %>%
    showQuestionNumbers("off") %>%
    showNavigationButtons("top") %>%

    addNewPage("page1") %>%
    addNewQuestion("text") %>%
    title("Wie heisst du?") %>%
    name("name") %>%
    placeHolder("Dein Name") %>%
    inputType("text") %>%
    onValueChanged() %>%

    addNewPage("page2") %>%
    addNewQuestion("text") %>%
    title("Wie alt bist du?") %>%
    name("age") %>%
    inputType("number") %>%
    size(10) %>%
    min(18) %>%
    minErrorText("Du bist zu jung!") %>%
    max(30) %>%
    maxErrorText("Du bist zu alt!") %>%
    requiredIf("{name} == Daniel") %>%
    requiredErrorText("Wir brauchen deine Angaben, Daniel!") %>%
    onValueChanged() %>%

    addNewPage("page3") %>%
    addNewQuestion("radiogroup") %>%
    title("Geschlecht") %>%
    name("gender") %>%
    choices(list(list(value = 1, text = "männlich"), list(value = 2, text = "weiblich"))) %>%
    otherText("Eigene Angabe") %>%
    otherPlaceHolder("Bitte geben Sie an") %>%
    noneText("None item") %>%
    onValueChanged() %>%

    addNewPage("page4") %>%
    addNewQuestion("dropdown") %>%
    title("Woher kommst du?") %>%
    name("country") %>%
    choices(list(list(value = "CH", text = "Schweiz"),
                 list(value = "DE", text = "Deutschland"))) %>%
    onValueChanged() %>%

    answersOnComplete() %>%
    completedHtml("<h1>Merci för Teilnahm</h1>")
    # getAllQuestions()
    # toJSON()

  survey2 <-
    survey() %>%
    locale("en") %>%

    addNewPage("page") %>%
    addNewQuestion("text") %>%
    title("What's your name?") %>%
    name("name") %>%
    onValueChanged() %>%

    addNewQuestion("text") %>%
    title("How old are you?") %>%
    name("age") %>%
    onValueChanged() %>%

    showNavigationButtons("bottom") %>%
    answersOnComplete() %>%
    showCompletedPage(FALSE)
    # toJSON()

  output$survey1 <- renderSurvey(survey1)
  output$survey2 <- renderSurvey(survey2)

  observeEvent(input$complete1, {
    doComplete("survey1")
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
  # actionButton("button", "Next Page"),
  surveyOutput("blobb")
)


server <- function(input, output, session) {
  my_survey <-
    survey(SURVEY) %>%
    onValueChanged(name = "gender") %>%
    onValueChanged(name = "lonely") %>%
    addNewPage("added") %>%
    addNewQuestion("text") %>%
    inputType("email") %>%
    name("Please, specify your mail adress") %>%
    answersOnComplete() %>%
    showQuestionNumbers("on") %>%
    showNavigationButtons("top") %>%
    showProgressBar("off") %>%
    showCompletedPage(TRUE)

  output$blobb <- renderSurvey(my_survey)

  # observeEvent(input$button, {
  #   nextPage("blobb")
  # })

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
