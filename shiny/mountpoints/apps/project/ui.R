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
          valueBoxOutput("valueStudentsLeftRatio", width = 6)
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
          ),
          box(
            title = "Supinfo successfull region",
            width = 6,
            status = "primary",
            solidHeader = TRUE,
            "What is the most successfull country for supinfo",
            highchartOutput("plotEctsByRegion")
          ),
          box(
            title = "Supinfo students repartition",
            width = 6,
            status = "success",
            solidHeader = TRUE,
            "How many student are in each supinfo representend country",
            highchartOutput("plotApprentRegion")
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
            width = 6,
            status = "danger",
            solidHeader = TRUE,
            "Some filter on the input data used to display the below graph",
            selectInput("graduated_select", 
              h5("Student graduated"),
              choices = list("No filter" = NA,
                              "Graduated" = TRUE,
                              "Not graduated" = FALSE), selected = NA),
            selectInput("leave_select", 
              h5("Student left"),
              choices = list("No filter" = NA,
                              "Left" = TRUE,
                              "Not left" = FALSE), selected = NA)
          ),
          box(
            title = "Wich column to display on the graph",
            width = 6,
            status = "success",
            solidHeader = TRUE,
            "Select the axis and the type of the graph to display",
            selectInput("graph_type", 
              h5("Graph type"),
              choices = list("Column" = "column",
                              "Bar" = "bar",
                              "Line" = "line",
                              "Pie" = "pie",
                              "Tree Map" = "treemap",
                              "Funnel" = "funnel",
                              "Pyramid" = "pyramid"), selected = "column"),
            selectInput("graph_axis_x", 
              h5("Axe X"),
              choices = list("Graduated" = "graduated",
                              "Course was left" = "course_was_left",
                              "Discovery reason" = "university_discovery_reason",
                              "Leaving reason" = "course_leaving_reason",
                              "Last country" = "last_country",
                              "Last campus" = "last_campus"), selected = "graduated")
          )
        ),

        fluidRow(
          box(
            title = "Result chart",
            width = 12,
            status = "info",
            solidHeader = TRUE,
            highchartOutput("dynamicPlot")
          )
          # textOutput("testStr")
        )
      )
    )
  )
)
