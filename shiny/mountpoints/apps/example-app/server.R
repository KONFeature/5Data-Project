library(ggvis)
library(dplyr)

# Set up handles to database tables on app start
data <- iris

axis_vars <- c(
  "Tomato Meter" = "Meter",
  "Numeric Rating" = "Rating",
  "Number of reviews" = "Reviews",
  "Dollars at box office" = "BoxOffice",
  "Year" = "Year",
  "Length (minutes)" = "Runtime"
)


function(input, output, session) {
  
  # Filter the movies, returning a data frame
  movies <- reactive({
    # Due to dplyr issue #318, we need temp variables for input values
    slider1 <- input$slider1Title
    minslider2 <- input$slider2Title[1]
    maxslider2 <- input$slider2Title[2]

    
    # Apply filters
    m <- data %>%
      filter(
        Param1 >= slider1,
        Param2 >= minslider2,
        Param2 <= maxslider2,
      ) %>%
      arrange(filter_data)
    
    # Optional: filter by select
    if (input$selectTitle != "All") {
      select <- paste0("%", input$selectTitle, "%")
      m <- m %>% filter(Select %like% select)
    }
    # Optional: filter by director
    if (!is.null(input$inputTitle) && input$inputTitle != "") {
      InputTitle <- paste0("%", input$inputTitle, "%")
      m <- m %>% filter(InputTitle %like% inputTitle)
    }

    
    m <- as.data.frame(m)
  })
  
  # A reactive expression with the ggvis plot
  vis <- reactive({
    # Lables for axes
    xvar_name <- names(axis_vars)[axis_vars == input$xvar]
    yvar_name <- names(axis_vars)[axis_vars == input$yvar]
    
    # Normally we could do something like props(x = ~BoxOffice, y = ~Reviews),
    # but since the inputs are strings, we need to do a little more work.
    xvar <- prop("x", as.symbol(input$xvar))
    yvar <- prop("y", as.symbol(input$yvar))
    
    movies %>%
      ggvis(x = xvar, y = yvar) %>%
      layer_points(size := 50, size.hover := 200,
                   fillOpacity := 0.2, fillOpacity.hover := 0.5,
                   stroke = ~has_oscar, key := ~ID) %>%
      add_axis("x", title = xvar_name) %>%
      add_axis("y", title = yvar_name) %>%
      set_options(width = 500, height = 500)
  })
  
  vis %>% bind_shiny("plot1")
  
  output$n_movies <- renderText({ nrow(movies()) })
}