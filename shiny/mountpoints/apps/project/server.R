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

# Register this SparkDataFrame as a temporary view, needed to run sql queries
createOrReplaceTempView(students, "students")

# Calculate the var we want for the value box
test_sql <- sql("SELECT COUNT(*) as count FROM students")
count_students <- count(students)
count_grad_students <- count(filter(students, students$graduated == TRUE))
count_left_students <- count(filter(students, students$course_was_left == TRUE))
ratio_students_graduate <- count_grad_students / count_students * 100
ratio_students_left <- count_left_students / count_students * 100

# Some group for easy plot
discovery_reason <- 
  summarize(groupBy(students, students$university_discovery_reason), count = n(students$university_discovery_reason))
discovery_reason <- head(arrange(discovery_reason, desc(discovery_reason$count)), 10L)
leaving_reason <- 
  summarize(groupBy(students, students$course_leaving_reason), count = n(students$course_leaving_reason))
leaving_reason <- head(arrange(leaving_reason, desc(leaving_reason$count)), 9L)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$testStr <- renderPrint({
    test_sql
  })

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
  output$plotDiscoveryReason <- renderHighchart({
    highchart() %>%
      hc_chart(type = "column") %>%
      hc_xAxis(categories = discovery_reason$university_discovery_reason) %>%
      hc_add_series(discovery_reason$count,
                    name = "Student from", showInLegend = FALSE)
  })
  output$plotLeavingReason <- renderHighchart({
    highchart() %>%
      hc_chart(type = "column") %>%
      hc_xAxis(categories = leaving_reason$course_leaving_reason) %>%
      hc_add_series(leaving_reason$count,
                    name = "Student from", showInLegend = FALSE)
  })

  ####################
  # TABLE
  ####################
  output$table <- renderDataTable(head(students))


})


# Close the spark connection
# sparkR.session.stop()
