library(shiny)
library(data.table)
### Only run this example in interactive R sessions
if (interactive()) {
  # table example
  #
  the_file  <- "~/code/health_labs/DATA/legacy/2021_03_19_FINAL_CLEAN.csv" #
  the_file  <- read.csv(the_file)
long  <- data.table(the_file, key=c("Date", "Test_Name"))


# remove duplicates
long  <- unique(long, by=1:2)

wide = dcast(long, Date ~ Test_Name, value.var = "Test_Result")



  shinyApp(
    ui = fluidPage(
      fluidRow(
        column(12,
          tableOutput('table')
        )
      )
    ),
    server = function(input, output) {
      output$table <- renderTable(wide)
    }
  )
}
