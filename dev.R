ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "slate"),
  surveyOutput("blobb")
)


server <- function(input, output, session) {
  my_survey <- survey(surveyjR::SURVEY$cancellation)
  output$blobb <- renderSurvey(my_survey)
}


shinyApp(ui, server)
