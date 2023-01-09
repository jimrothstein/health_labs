#
library(shiny)
### Only run this example in interactive R sessions
if (interactive()) {
  # table example
  #
  the_file  <- "~/code/health_labs/DATA/legacy/2021_03_19_FINAL_CLEAN.csv" #
  df  <- read.csv(the_file)
  shinyApp(
    ui = fluidPage(
      fluidRow(
        column(12,
          tableOutput('table')
        )
      )
    ),
    server = function(input, output) {
      output$table <- renderTable(df)
    }
  )
}
