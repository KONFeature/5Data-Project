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
          valueBoxOutput("valueStudentsCount"),
          valueBoxOutput("valueStudentsGraduatedCount"),
          valueBoxOutput("valueStudentsLeftCount"),
          valueBoxOutput("valueStudentsGraduatedRatio"),
          valueBoxOutput("valueStudentsLeftRatio")
        ),

        # Plot row
        fluidRow(
          plotOutput("plotFamousDiscoveryRease")
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
        h1("test filtered_chart")
      )
    )
  )
)
