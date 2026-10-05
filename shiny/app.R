# Shiny app to read, display, and append to a Google Sheet
library(shiny)
library(DT)
library(googlesheets4)

# Spreadsheet ID and the single tab we care about
SS_ID  <- "16PRB17uBRtferrNyVSPKHCyelTNW4I6m2bMaTcsgo7s"
SS_TAB <- "LABS - ALL"

# Fields of one row, in the order they appear in the sheet
LAB_FIELDS <- c("ID", "Date", "Test_Name", "Test_Result", "Code", "Comment",
                "Normal", "Where", "Purpose", "Exercise Level", "Allopurinol")

# Input id for field i, e.g. field 1 -> "f1"
field_id <- function(i) paste0("f", i)

# Auth: opens a browser once, then reuses the cached token
gs4_auth()

# One row of inputs, generated from LAB_FIELDS so labels and ids can't drift
lab_inputs <- function() {
  tagList(
    fluidRow(lapply(seq_along(LAB_FIELDS), function(i) {
      column(4, textInput(field_id(i), LAB_FIELDS[i]))
    })),
    actionButton("submit", "Save to sheet"),
    uiOutput("msg")
  )
}

ui <- fluidPage(
  titlePanel("Google Sheet Data"),
  mainPanel(
    DTOutput("sheet_data"),
    actionButton("toggle_add", "Add a row"),
    uiOutput("add_ui")
  )
)

server <- function(input, output) {

  # Bumped after each save to force a re-read of the sheet
  rv <- reactiveValues(refresh = 0)

  df <- reactive({
    rv$refresh
    tryCatch(read_sheet(SS_ID, sheet = SS_TAB),
             error = function(e) validate(paste("Failed to read data:", e$message)))
  })

  output$sheet_data <- renderDT({
    datatable(df())
  })

  output$add_ui <- renderUI({
    if (!input$toggle_add) return(NULL)
    tagList(h4("New row"), lab_inputs())
  })

  observeEvent(input$submit, {

    vals <- lapply(seq_along(LAB_FIELDS), function(i) input[[field_id(i)]])
    names(vals) <- LAB_FIELDS
    blanks <- vapply(vals, function(v) is.null(v) || !nzchar(v), logical(1))
    vals[blanks] <- list(NA)

    new_row <- as.data.frame(vals, stringsAsFactors = FALSE)

    tryCatch({
      sheet_append(SS_ID, new_row, sheet = SS_TAB)
      rv$refresh <- rv$refresh + 1
      output$msg <- paste0("Saved: ", vals[["ID"]])
    }, error = function(e) {
      output$msg <- paste("Failed:", conditionMessage(e))
    })
  })
}

shinyApp(ui, server)