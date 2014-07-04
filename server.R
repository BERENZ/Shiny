### calculations

library(shiny)
library(ggplot2)

### load data
load('InputData.RData')

# grapphics to be plotted

shinyServer(function(input, output) {
  
  output$choose_division <- renderUI({

    division <- unique(titles$Wydział)
    
    # Create the checkboxes and select them all by default
    selectInput("division", "Wybierz wydział", 
                       choices  = division,
                       selected = division)
  })
  
  output$choose_year <- renderUI({
    
    
    year <- unique(titles[titles$Wydział==input$division,'Rok_Studiów'])
    
    # Create the checkboxes and select them all by default
    selectInput("year", "Wybierz rok studiów", 
                choices  = year,
                selected = year)
  })
  
  output$choose_sem <- renderUI({
    
    
    sem <- unique(titles[titles$Wydział==input$division & 
                           titles$Rok_Studiów==input$year,'Semestr'])
    
    # Create the checkboxes and select them all by default
    selectInput("sem", "Wybierz semestr", 
                choices  = sem,
                selected = sem)
  })
  
  output$choose_course <- renderUI({
    
    
    course <- unique(titles[titles$Wydział==input$division & 
                            titles$Rok_Studiów==input$year & 
                            titles$Semestr==input$sem,'Przedmiot'])
    
    # Create the checkboxes and select them all by default
    selectInput("course", "Wybierz przedmiot", 
                choices  = course,
                selected = course)
  })
  
  output$satisf <- renderPlot({
    p<-ggplot(data=subset(results, 
                          Wydział == input$division & 
                          Rok_Studiów==input$year & 
                            Semestr == input$sem & 
                            Przedmiot==input$course), 
              aes(x=variable,
                  y=Percent,
                  fill=value,
                  group=value)) + 
      ### specifying that barplot should be plotted
      geom_bar(stat='identity',colour='black') + 
      ### labels on the bars rounded to integer
      geom_text(aes(x=variable,
                    y=pos,
                    label=round(Percent))) + 
      ### change fill colour
      scale_fill_brewer(palette='Greens',
                        name='Odpowiedź') + 
      ### changing orientation from vertical to horizontal
      coord_flip() + 
      ### black and white background
      theme_bw() + 
      ### title
      ggtitle(titles[titles$Przedmiot==input$course,'Label']) +
      ### labels
      ylab('Procent odpowiedzi') +
      xlab('') 
    plot(p)
  })
})

