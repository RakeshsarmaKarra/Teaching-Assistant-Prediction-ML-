library(tidyverse)
library(rpart)
library(leaps)
library(c3)
library(shinyWidgets)
library(plotly)
library(shiny)
library(bslib)  # For theming
library(corrplot)  # For correlation plots
library(neuralnet)  # For ANN model

# Define the UI
ui <- fluidPage(
  theme = bs_theme(bootswatch = "lux"),  # Apply a modern theme
  titlePanel(
    div(
      style = "text-align:center; padding:20px;",
      h1("TA Eligibility Predictor", style = "font-weight:bold; color:#2C3E50; font-family:'Times New Roman';"),
      h4("Predict your chances of becoming a Teaching Assistant", style = "color:#7F8C8D; font-family:'Times New Roman';")
      
    )
  ),
  sidebarLayout(
    sidebarPanel(
      width = 4,
      div(
        style = "background-color:#ECF0F1; padding:20px; border-radius:8px;",
        textInput("Student_Name", label=div("Student's Name", style = "font-weight:bold; color:#34495E;"), value=""),
        sliderInput("GPA", label=div("GPA", style = "font-weight:bold; color:#34495E;"), value=2, min=2, max=4, step=0.1),
        selectInput("Semester", label=div("Select your Current Semester", style = "font-weight:bold; color:#34495E;"), 
                    choices=c("1"="Freshman", "2"="Sophomore", "3"="Junior", "4"="Senior")),
        numericInput("No_of_LORs", label=div("Number of LORs", style = "font-weight:bold; color:#34495E;"), value=0),
        numericInput("Professional_Experience", label=div("Professional Experience (years)", style = "font-weight:bold; color:#34495E;"), value=0),
        numericInput("Projects_outside_of_academics", label=div("Projects outside of Academics", style = "font-weight:bold; color:#34495E;"), value=0),
        actionButton("submitbutton", label="Submit", class = "btn-primary btn-lg btn-block")
      )
    ),
    
    mainPanel(
      width = 8,
      tabsetPanel(
        tabPanel(
          "Model Results",
          tabsetPanel(
            tabPanel(
              "Eligibility", 
              div(style = "margin-top:20px;",
                  htmlOutput("res"),
                  style = "text-align:center; font-size:1.5em; font-weight:bold;"
              )
            ),
            tabPanel(
              "Probability Score", 
              div(style = "margin-top:20px;", 
                  plotlyOutput("gauge1"),
                  style = "text-align:center;"
              )
            )
          )
        ),
        tabPanel(
          "Model Interpretation Graphs",
          tabsetPanel(
            tabPanel(
              "Correlation Plot", 
              div(style = "margin-top:20px;", 
                  plotOutput("correlation_plot"),
                  style = "text-align:center;"
              )
            ),
            tabPanel(
              "ANN Model", 
              div(style = "margin-top:20px;", 
                  plotOutput("ann_plot"),
                  style = "text-align:center;"
              )
            )
          )
        )
      )
    )
  )
)

# Define the server logic
server <- function(input, output) {
  submit_clicked <- reactiveVal(FALSE)
  
  data_preparation <- reactive({
    data <- read.csv("C:/Rakesh/Rcourse/TA_candidates_dataset.csv")
    data <- data.frame(data)
    
    data$Semester <- as.numeric(data$Semester)
    
    data_num <- subset(data, select = -c(Name, Professional_Experience))
    data_corr <- cor(data_num)
    
    set.seed(2)
    data_model <- data_num
    data_num2 <- data_model[,c("TA_RESULT", "PROF_EXP_POINTS", "GPA_points", "Number_of_LORs", "Projects_Outside_Academics")]
    indices <- sample(nrow(data_num2), 0.7 * nrow(data_num2))
    train_data <- data_num2[indices,]
    test_data <- data_num2[-indices,]
    
    set.seed(125)
    ann_model <- neuralnet(TA_RESULT ~ PROF_EXP_POINTS + GPA_points + Number_of_LORs + Projects_Outside_Academics, 
                           data=train_data, hidden=6, err.fct="ce", linear.output=FALSE)
    
    list(ann_model = ann_model, data_corr = data_corr)
  })
  
  observeEvent(input$submitbutton, {
    submit_clicked(TRUE)
  })
  
  output$res <- renderText({
    req(submit_clicked())
    
    model_data <- data_preparation()
    ann_model <- model_data$ann_model
    
    if (sum(submit_clicked()) > 0) {
      res_data <- data.frame(PROF_EXP_POINTS = input$Professional_Experience,
                             GPA_points = input$GPA, 
                             Number_of_LORs = input$No_of_LORs, 
                             Projects_Outside_Academics = input$Projects_outside_of_academics)
      
      if (nrow(res_data) > 0) {
        results_rak <- predict(ann_model, res_data, type = "response")
        res_data$predicted_outcome <- round(results_rak)
        
        if(res_data$predicted_outcome == 1){
          return(paste("<span style=\"color:green\">", input$Student_Name, 
                       ", you will get a call from advisor Zaiba!</span>"))
        } else {
          return(paste("<span style=\"color:red\">", input$Student_Name, 
                       ", you won't get a call from advisor Zaiba.</span>"))
        }
      } else {
        "Please provide input data to make predictions."
      }
    } else {
      "Please submit input data to make predictions."
    }
  })
  
  output$gauge1 <- renderPlotly({
    req(input$submitbutton)
    
    model_data <- data_preparation()
    ann_model <- model_data$ann_model
    
    if (sum(submit_clicked()) > 0) {
      res_data <- data.frame(PROF_EXP_POINTS = input$Professional_Experience,
                             GPA_points = input$GPA, 
                             Number_of_LORs = input$No_of_LORs, 
                             Projects_Outside_Academics = input$Projects_outside_of_academics)
      
      if (nrow(res_data) > 0) {
        results_rak <- predict(ann_model, res_data, type = "response")
        predicted_outcome_probability <- round(results_rak, digits = 3)
        res_data$predicted_outcome <- round(results_rak)
        
        fig <- plot_ly(
          domain = list(x = c(0, 1), y = c(0, 1)),
          value = predicted_outcome_probability,
          title = list(text = paste("Probability: ", predicted_outcome_probability),
                       font = list(size = 20)),
          type = "indicator",
          mode = "gauge+number"
        )
        
        fig <- fig %>%
          layout(
            margin = list(l = 20, r = 30, t = 50),
            title = list(y = 2)
          )
        
        return(fig)
      }
    }
  })
  
  output$correlation_plot <- renderPlot({
    model_data <- data_preparation()
    data_corr <- model_data$data_corr
    
    # Correlation plot for selected variables
    vars_to_plot <- c("Semester", "PROF_EXP_POINTS", "GPA_points", "Number_of_LORs", 
                      "Projects_Outside_Academics", "TA_RESULT")
    
    corrplot(data_corr[vars_to_plot, vars_to_plot], method = "color", type = "upper", 
             addCoef.col = "black", tl.cex = 1, tl.srt = 45)
  })
  
  output$ann_plot <- renderPlot({
    model_data <- data_preparation()
    ann_model <- model_data$ann_model
    
    plot(ann_model, width = 10, height = 8)
  })
  # Inside the server function
  
  output$ann_plot <- renderPlot({
    model_data <- data_preparation()
    ann_model <- model_data$ann_model
    
    # Plotting the ANN model
    plot(ann_model, width = 10, height = 8)  # This will generate and display the ANN model graph
  })
  
}

shinyApp(ui = ui, server = server)
