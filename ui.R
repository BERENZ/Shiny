#### shiny

library(shiny)

### User Interface
shinyUI(fluidPage(
  titlePanel("Wyniki badania satysfakcji"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Stwórz podsumowania wyników dla każdego przedmiotu
               według wydziału, roku oraz semestru"),
      
      uiOutput("choose_division"),
      
      uiOutput("choose_year"),
      
      uiOutput("choose_sem"),
      
      uiOutput("choose_course")
      ),
    
    mainPanel(
      plotOutput("satisf")
    )
  )
))



