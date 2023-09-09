library(tidyverse)
library(dplyr)
library(ggplot2)
library(shiny)


set.seed(1234)
pop_income <- rnorm(1000, 10000,1500)

# set true parameter
para_pop <- 10000

store_ci <- function(i, n, conf_level) {
  sample1 <- sample(pop_income, n)
  xbar <- mean(sample1)
  s <- sd(sample1)
  moe <- qt(1 - (1 - conf_level)/2,df=n-1)*s/sqrt(n)
  data.frame(
    x_lower = xbar - moe,
    x_upper = xbar + moe
  )
}

shinyApp(
  ui <- fluidPage(
    h4("Generate Multiple Confidences"),
    
    # h4(selectInput("conf_level", "",
    #   choices = c(
    #     "99%" = 0.99,
    #     "95%" = 0.95,
    #     "80%" = 0.80
    #   ),
    #   selected = 0.95, width = "50%"
    # )),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        numericInput("n_samp",
                     "Sample size for a single sample: (pls input a number between 1 and 100)",
                     min = 1,
                     max = 100,
                     value = 100
        ),
        
        hr(),
        
        numericInput("conf_level",
                     "Confidence level",
                     min = 0.01,
                     max = 0.99,
                     value = 0.95,
                     step = 0.05
        ),
        
        hr(),
        
        radioButtons("n_ci",
                     "Number of confidence intervals:",
                     choices = c(10, 20, 50),
                     selected = 20, inline = TRUE
        ),
        
        actionButton("go", "Go")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput("ci_plot")
      )
    )
  ),
  
  server <- function(input, output) {
    
    # create df_ci when go button is pushed
    df_ci <- eventReactive(input$go, {
      map_dfr(1:input$n_ci, function(x) store_ci(x, n = input$n_samp, conf_level = input$conf_level)) %>%
        mutate(
          y_lower = 1:input$n_ci,
          y_upper = 1:input$n_ci,
          esti = (x_lower + x_upper)/2,
          capture_p = ifelse(x_lower < para_pop & x_upper > para_pop, "Yes", "No")
        )      
    })
    
    # plot df_ci
    output$ci_plot <- renderPlot({
      ggplot(df_ci(), aes (x = esti, y = y_upper, color = capture_p)) +
        geom_errorbar(aes(xmin = x_lower, xmax = x_upper), width = 0.8, size = 1.5) +
        geom_point(aes(x = esti, y = y_upper, color = capture_p),size = 5) +
        geom_vline(xintercept = para_pop, color = "black", size =1.2, linetype = "dashed") +
        labs(
          y = "", x = "Confidence intervals",
          color = "Does the interval capture the true population parameter?") +
        theme(legend.position = "bottom") + 
        theme(axis.title=element_text(size=16)) +
        scale_color_manual(breaks = c("Yes", "No"), values=c("cyan3", "red"))
    })
    
  },   # ends server part
  options = list(height = 700)
)


