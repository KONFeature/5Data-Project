library(ggvis)

axis_vars <- c(
  "Tomato Meter" = "Meter",
  "Numeric Rating" = "Rating",
  "Number of reviews" = "Reviews",
  "Dollars at box office" = "BoxOffice",
  "Year" = "Year",
  "Length (minutes)" = "Runtime"
)

# For dropdown menu
actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

fluidPage(
  titlePanel("Title"),
  fluidRow(
    column(3,
           wellPanel(
             h4("Filter"),
             sliderInput("slider1Title", "de minumum à ?",
                         10, 300, 80, step = 10),
             sliderInput("slider2Title", "de ? à ?",
                         0, 800, c(0, 800), step = 1),
             selectInput("selectTitle", "Selection avec plusieurs choix",
                         c("All", "choix1", "choix2", "choix3")
             ),
             textInput("inputTitle", "inputTexte"),
           ),
           wellPanel(
             selectInput("xvar", "X-axis variable", axis_vars, selected = "Meter"),
             selectInput("yvar", "Y-axis variable", axis_vars, selected = "Reviews"),
           )
    ),
    # Nos graph et table
    column(9,
           ggvisOutput("plot1"),
    )
  )
)