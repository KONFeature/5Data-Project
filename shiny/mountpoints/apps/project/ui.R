# Libs to imports
library(listviewer)
library(shiny)
library(httr)
library(shinydashboard)

# UI part of the application
ui <- dashboardPage(
    # Apply green skin
  skin = "green",

    # Header of the page
  dashboardHeader(title = "Supinfo stats"),

    # Left menu
  dashboardSidebar(
    # Search form
    sidebarSearchForm(textId = "searchText", buttonId = "searchButton", label = "Search..."),
    # Tabs
    sidebarMenu(
      menuItem("Table", tabName = "table", icon = icon("table")),
      menuItem("Birth Date", tabName = "birth_date", icon = icon("birthday-cake"))
    )
    # Selectors

  ),

  # Content of the page
  dashboardBody(
    
    # Top row
    fluidRow(
      # Number of students
      valueBox(10 * 2, "Students", icon = icon("list-ol")),
      # Number of graduated students
      valueBox(10 * 2, "Graduated students", icon = icon("stamp"), color = "green"),
      # Percent of graduated students
      valueBox(10 * 2, "Ratio of gradueted students", icon = icon("percentage"), color = "yellow")
    ),

    # Tab part
    tabItems(
      # Table with all the data
      tabItem(
        tabName="table",

        h1("Table with all the data we got"),

        fluidRow(
          box(
            title = "Table of the data",
            width = 12,
            status = "success",
            solidHeader = TRUE,
            "Just all the data we have on supinfo students",
            dataTableOutput('table')
          )
        )
      ),


      tabItem(
        tabName="birth_date",
        h1("test birth_date")
      )
    )
  )
)
