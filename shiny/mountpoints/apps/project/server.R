# Prepare SparkR (define the bin location on the current system)
Sys.setenv(SPARK_HOME = "/opt/spark-2.4.4-bin-hadoop2.7")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))

# Import libs
library(jsonlite)
library(shiny)
library(highcharter)
library(dplyr)
library(SparkR)

# Prepare list of config and package for the SparkR Session
sparkConfigList = list(
  spark.executor.memory = "1g",
  spark.mongodb.input.uri = "mongodb://mongo/data-projects.students?readPreference=primaryPreferred",
  spark.mongodb.output.uri = "mongodb://mongo/data-projects.students")

sparkPackageList = c("org.mongodb.spark:mongo-spark-connector_2.11:2.4.1")

# Init the sparkR session
my_spark <- sparkR.session(
 master = "spark://master:7077",
 sparkConfig = sparkConfigList,
 appName = "r-project",
 sparkPackages = sparkPackageList)

# Fetch students from mongo
students <- read.df("", source = "mongo")

# Calculate the var we want for the value box
count_students <- count(students)
count_grad_students <- count(filter(students, students$graduated == TRUE))
count_left_students <- count(filter(students, students$course_was_left == TRUE))
ratio_students_graduate <- count_grad_students / count_students * 100
ratio_students_left <- count_left_students / count_students * 100

# Some group for easy plot
discovery_reason <- 
  summarize(groupBy(students, students$university_discovery_reason), count = n(students$university_discovery_reason))
discovery_reason <- arrange(discovery_reason, desc(discovery_reason$count))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  ####################
  # DASHBOARD
  ####################

  # Create the render we need for this dashboard
  output$valueStudentsCount <- renderValueBox({
    valueBox(
      format(count_students, scientific = FALSE), "Students",
      icon = icon("list"),
      color = "purple"
    )
  })
  output$valueStudentsGraduatedCount <- renderValueBox({
    valueBox(
      format(count_grad_students, scientific = FALSE),
      "Graduated students",
      icon = icon("stamp"),
      color = "green"
    )
  })
  output$valueStudentsLeftCount <- renderValueBox({
    valueBox(
      format(count_left_students, scientific = FALSE),
      "Students who left",
      icon = icon("sign-out-alt"),
      color = "red"
    )
  })
  output$valueStudentsGraduatedRatio <- renderValueBox({
    valueBox(
      paste0(ratio_students_graduate, "%"),
      "Ratio of gradueted students",
      icon = icon("percentage"),
      color = "yellow"
    )
  })
  output$valueStudentsLeftRatio <- renderValueBox({
    valueBox(
      paste0(ratio_students_left, "%"),
      "Ratio of students who left",
      icon = icon("percentage"),
      color = "red"
    )
  })
  test_df <- head(discovery_reason)

  output$plotFamousDiscoveryRease <- renderHighchart({
    highchart() %>%
      hc_chart(type = "column", colorByPoint = TRUE) %>%
      hc_title(text = "A highcharter chart") %>%
      hc_xAxis(categories = test_df$university_discovery_reason) %>%
      hc_add_series(data = test_df$count,
                    name = "Count")
  })

  ####################
  # TABLE
  ####################
  output$table <- renderDataTable(head(students))


})


# Close the spark connection
# sparkR.session.stop()
