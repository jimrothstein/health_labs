# Shiny app to read and display data from Google Sheet (read-only)
library(shiny)

# Google Sheet export URL (read-only CSV)
sheet_url <- "https://docs.google.com/spreadsheets/d/16PRB17uBRtferrNyVSPKHCyelTNW4I6m2bMaTcsgo7s/export?format=csv&gid=1272825971"

ui <- fluidPage(
  titlePanel("Google Sheet Data"),
  mainPanel(
    tableOutput("sheet_data")
  )
)

server <- function(input, output) {
  output$sheet_data <- renderTable({
    tryCatch({
      df <- read.csv(sheet_url, stringsAsFactors = FALSE, check.names = FALSE)
      df
    }, error = function(e) {
      validate(paste("Failed to read data from Google Sheet:", e$message))
    })
  })
}

shinyApp(ui, server)
