# Shiny app to read and display data from Google Sheet
library(shiny)
library(DT)
library(googlesheets4)

# Spreadsheet ID and the single tab we care about
SS_ID  <- "16PRB17uBRtferrNyVSPKHCyelTNW4I6m2bMaTcsgo7s"
SS_TAB <- "ALL - LABS"

# Auth: opens a browser once, then reuses the cached token
gs4_auth()

ui <- fluidPage(
  titlePanel("Google Sheet Data"),
  mainPanel(
    DTOutput("sheet_data")
  )
)

server <- function(input, output) {
  output$sheet_data <- renderDT({
    tryCatch({
      df <- read_sheet(SS_ID, sheet = SS_TAB)
      datatable(df)
    }, error = function(e) {
      validate(paste("Failed to read data from Google Sheet:", e$message))
    })
  })
}

shinyApp(ui, server)
