library(shiny)
library(ggplot2)


# It defines the user interface, the HTML webpage that humans interact with. 

ui <- fluidPage(
  
  tags$h3("Dot plot generator. Simón Vélez"),
  
  selectInput(inputId = "x", label = "X Axis", choices = names(mtcars), selected = "mpg"),
  
  selectInput(inputId = "y", label = "Y Axis", choices = names(mtcars), selected = "hp"),
  
  plotOutput(outputId = "dotPlot")
  
)


# It specifies the behavior of our app by defining a server function.

server <- function(input, output){
  
  data <- reactive({mtcars})
  
  output$dotPlot <- renderPlot({
    ggplot(data = data(), aes_string(x = as.factor(input$x), y = input$y)) + 

      geom_dotplot(binaxis = 'y', stackdir = "centerwhole", binwidth = 30, fill = "white", stroke = 2) + 
      
      theme_classic()
    
  })
  
}

# Construct and start a Shiny application from UI and server.

shinyApp(ui = ui, server = server)
