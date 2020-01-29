# Import them
library(shiny)

# Prepare SparkR (define the bin location on the current system)
Sys.setenv(SPARK_HOME="/opt/spark-2.4.4-bin-hadoop2.7")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))

# Import sparkR lib
library(SparkR)

# Prepare list of config and package for the SparkR Session
sparkConfigList = list(
  spark.executor.memory="1g",
  spark.mongodb.input.uri="mongodb://mongo/data-projects.students?readPreference=primaryPreferred",
  spark.mongodb.output.uri="mongodb://mongo/data-projects.students")

sparkPackageList = c("org.mongodb.spark:mongo-spark-connector_2.11:2.4.1")

# Init the sparkR session
my_spark <- sparkR.session(
 master="spark://master:7077",
 sparkConfig=sparkConfigList,
 appName="r-project",
 sparkPackages = sparkPackageList)

 # Try to read data from mongo
students <- read.df("", source = "mongo")
print("Schema:")
printSchema(students)

# Close the spark connection
sparkR.session.stop()

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')    
  })
  
})
