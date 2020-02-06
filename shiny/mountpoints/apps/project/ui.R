# Libs to imports
library(listviewer)
library(shiny)
library(httr)
library(highcharter)
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
      id="currentTab",
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Table", tabName = "table", icon = icon("table")),
      menuItem("Filtered charts", tabName = "filtered_chart", icon = icon("chart-bar"))
    )
    # Selectors

  ),

  # Content of the page
  dashboardBody(

    # Tab part
    tabItems(
      ####################
      # DASHBOARD
      ####################
      tabItem(
        tabName="dashboard",
    
        # Value row
        fluidRow(
          valueBoxOutput("valueStudentsCount", width = 4),
          valueBoxOutput("valueStudentsGraduatedCount", width = 4),
          valueBoxOutput("valueStudentsLeftCount", width = 4),
          valueBoxOutput("valueStudentsGraduatedRatio", width = 6),
          valueBoxOutput("valueStudentsLeftRatio", width = 6),
          textOutput("testStr")
        ),

        # Plot row
        fluidRow(
          box(
            title = "Supinfo discover reason",
            width = 6,
            status = "info",
            solidHeader = TRUE,
            "Better way used by Supinfo to attract students",
            highchartOutput("plotDiscoveryReason")
          ),
          box(
            title = "Supinfo leaving reason",
            width = 6,
            status = "warning",
            solidHeader = TRUE,
            "Worth cause why students leave Supinfo",
            highchartOutput("plotLeavingReason")
          )
        )

        # Some basic chart ? Graduation / year etc ; Better way student discover the school ? 
      ),

      ####################
      # TABLE
      ####################
      tabItem(
        tabName="table",

        fluidRow(
          box(
            title = "Table with all the students data",
            width = 12,
            status = "success",
            solidHeader = TRUE,
            "Just all the data we have on supinfo students",
            dataTableOutput('table')
          )
        )
      ),

      ####################
      # FILTERED CHART
      ####################
      tabItem(
        tabName="filtered_chart",

        # Input row
        fluidRow(
          box(
            title = "Filter on for the graph below",
            width = 4,
            status = "info",
            solidHeader = TRUE,
            "Some filter on the input data used to display the below graph",
            dateRangeInput("birthdate_range",
              h5("Birthdate range")),
            selectInput("graduated_select", 
              h5("Student graduated"),
              choices = list("No filter" = 0,
                              "Graduated" = 1,
                              "Not graduated" = 2), selected = 0),
            selectInput("leave_select", 
              h5("Student left"),
              choices = list("No filter" = 0,
                              "Left" = 1,
                              "Not left" = 2), selected = 0)
          ),
          box(
            title = "Wich column to display on the graph",
            width = 4,
            status = "success",
            solidHeader = TRUE,
            "Select the axis of the graph to display",
            selectInput("column_axis_y", 
              h5("Axe Y"),
              choices = list("Count" = 0,
                              "Mean" = 1), selected = 0),
            selectInput("column_axis_x", 
              h5("Axe X"),
              choices = list("Discovery reason" = 0,
                              "Leaving reason" = 1,
                              "Last country" = 2,
                              "Last campus" = 3,
                              "ECTS Count" = 4), selected = 0)
          )
        )
      )
    )
  )
)
