# Import them
library(shiny)

# Prepare SparkR (define the bin location on the current system)
Sys.setenv(SPARK_HOME="/opt/spark-2.4.4-bin-hadoop2.7")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))

# Import sparkR lib
library(SparkR)
library(jsonlite)
library(dplyr)
library(tidyr)
library (plyr)
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

students_paul <- SparkR::filter(students,students$first_name == "Paul")

df_paul <- slice(as.data.frame(students_paul),1:5)

email <- list()
phone <- list()
index <- 1
for (i in df_paul$contact) {
  for (t in i[1]) {
    email[index] <- t
  }
  for (u in i[2]) {
    phone[index] <- u
  }
  index <- index +1
  
}
df <- cbind(email, phone)

df_all <- cbind(df_paul, df)
df_all$contact <- NULL


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$schema <- renderPrint({

    
  })
  output$table <- renderDataTable(df_all)

  
  
  
})


# Close the spark connection
# sparkR.session.stop()
