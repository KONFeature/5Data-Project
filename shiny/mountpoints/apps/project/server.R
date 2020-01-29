# Import them
library(shiny)

# set system variables ----
# - location of Spark on master node;
# - add sparkR package directory to the list of path to look for R packages
Sys.setenv(SPARK_HOME="/opt/spark-2.4.4-bin-hadoop2.7")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))

# Test a sparkR server
library(SparkR)
my_spark <- sparkR.session(
 master="spark://master:7077",
 sparkConfig=list(),
 appName="data-projects"
)


# test <- read.text("s3a://adhoc.analytics.data/README.md")
# head(collect(test))


sparkR.session.stop()

# Open spark connection
# library(sparklyr)
# sc <- spark_connect(master = "spark://localhost:7077")

# # check the spark connection
# connection_is_open(sc)

# # Test random file load from spark
# test <- spark_read_csv(sc, "test", "s3a://adhoc.analytics.data/README.md")
# test

# # Close spark connection
# spark_disconnect_all()

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
