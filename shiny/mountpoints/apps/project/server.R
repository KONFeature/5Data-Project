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

students <- SparkR::filter(students,students$id < 10000)

df <- as.data.frame(students)

# Separation de contact en email et phone
email <- list()
phone <- list()
index <- 1
for (i in df$contact) {
  for (t in i[1]) {
    email[index] <- t
  }
  for (u in i[2]) {
    phone[index] <- u
  }
  index <- index +1

}
# Creation du df avec tous les contacts
df_contact <- cbind(email, phone)

# Ajout du df de contact au df global
df_all <- cbind(df, df_contact)
# Suppression de l'ancienne colonne
df_all$contact <- NULL

#Drop des df qui ne servent plus
# SparkR::drop(df_contact)
# SparkR::drop(df)
# Spark::drop(students)

# Separation des courses
df_course <- list()
for (i in df$courses) {
  afterHighSchool <- list()
  abbrevation <- list()
  country <- list()
  campus <- list()
  full_name <- list()
  apprenticeship <- list()
  start_date <- list()
  end_date <- list()
  ects <- list()
  index <- 1
  
  for (t in i) {
    for (year in t[1]) {
      if(year != 'A.Sc.1' && index == 1) {
        A.Sc.1 = 'A.Sc.1'
        A.Sc.1_afterHighSchool = NA
        A.Sc.1_country = NA
        A.Sc.1_campus = NA
        A.Sc.1_full_name = NA
        A.Sc.1_apprenticeship = NA
        A.Sc.1_start_date = NA
        A.Sc.1_end_date = NA
        A.Sc.1_ects = NA
        abbrevation <- cbind(abbrevation, A.Sc.1)
        afterHighSchool <- cbind(afterHighSchool, A.Sc.1_afterHighSchool)
        country <- cbind(country, A.Sc.1_country)
        campus <- cbind(campus, A.Sc.1_campus)
        full_name <- cbind(full_name, A.Sc.1_full_name)
        apprenticeship <- cbind(apprenticeship, A.Sc.1_apprenticeship)
        start_date <- cbind(start_date, A.Sc.1_start_date)
        end_date <- cbind(end_date, A.Sc.1_end_date)
        ects <- cbind(ects, A.Sc.1_ects)
        index <- index + 1
      }
      if(year != 'A.Sc.2' && index == 2) {
        A.Sc.2 = 'A.Sc.2'
        A.Sc.2_afterHighSchool = NA
        A.Sc.2_country = NA
        A.Sc.2_campus = NA
        A.Sc.2_full_name = NA
        A.Sc.2_apprenticeship = NA
        A.Sc.2_start_date = NA
        A.Sc.2_end_date = NA
        A.Sc.2_ects = NA
        abbrevation <- cbind(abbrevation, A.Sc.2)
        afterHighSchool <- cbind(afterHighSchool, A.Sc.2_afterHighSchool)
        country <- cbind(country, A.Sc.2_country)
        campus <- cbind(campus, A.Sc.2_campus)
        full_name <- cbind(full_name, A.Sc.2_full_name)
        apprenticeship <- cbind(apprenticeship, A.Sc.2_apprenticeship)
        start_date <- cbind(start_date, A.Sc.2_start_date)
        end_date <- cbind(end_date, A.Sc.2_end_date)
        ects <- cbind(ects, A.Sc.2_ects)
        index <- index + 1
      }
      if(year != 'B.Sc.' && index == 3) {
        B.Sc. = 'B.Sc.'
        B.Sc._afterHighSchool = NA
        B.Sc._country = NA
        B.Sc._campus = NA
        B.Sc._full_name = NA
        B.Sc._apprenticeship = NA
        B.Sc._start_date = NA
        B.Sc._end_date = NA
        B.Sc._ects = NA
        abbrevation <- cbind(abbrevation, B.Sc.)
        afterHighSchool <- cbind(afterHighSchool, B.Sc._afterHighSchool)
        country <- cbind(country, B.Sc._country)
        campus <- cbind(campus, B.Sc._campus)
        full_name <- cbind(full_name, B.Sc._full_name)
        apprenticeship <- cbind(apprenticeship, B.Sc._apprenticeship)
        start_date <- cbind(start_date, B.Sc._start_date)
        end_date <- cbind(end_date, B.Sc._end_date)
        ects <- cbind(ects, B.Sc._ects)
        index <- index +1
      }
      if( year != 'M.Sc.1' && index == 4) {
        M.Sc.1 = 'M.Sc.1'
        M.Sc.1_afterHighSchool = NA
        M.Sc.1_country = NA
        M.Sc.1_campus = NA
        M.Sc.1_full_name = NA
        M.Sc.1_apprenticeship = NA
        M.Sc.1_start_date = NA
        M.Sc.1_end_date = NA
        M.Sc.1_ects = NA
        abbrevation <- cbind(abbrevation, M.Sc.1)
        afterHighSchool <- cbind(afterHighSchool, M.Sc.1_afterHighSchool)
        country <- cbind(country, M.Sc.1_country)
        campus <- cbind(campus, M.Sc.1_campus)
        full_name <- cbind(full_name, M.Sc.1_full_name)
        apprenticeship <- cbind(apprenticeship, M.Sc.1_apprenticeship)
        start_date <- cbind(start_date, M.Sc.1_start_date)
        end_date <- cbind(end_date, M.Sc.1_end_date)
        ects <- cbind(ects, M.Sc.1_ects)
        index <- index + 1
      }
      if(year != 'M.Sc.2' && index == 5) {
        M.Sc.2 = 'M.Sc.2'
        M.Sc.2_afterHighSchool = NA
        M.Sc.2_country = NA
        M.Sc.2_campus = NA
        M.Sc.2_full_name = NA
        M.Sc.2_apprenticeship = NA
        M.Sc.2_start_date = NA
        M.Sc.2_end_date = NA
        M.Sc.2_ects = NA
        abbrevation <- cbind(abbrevation, M.Sc.2)
        afterHighSchool <- cbind(afterHighSchool, M.Sc.2_afterHighSchool)
        country <- cbind(country, M.Sc.2_country)
        campus <- cbind(campus, M.Sc.2_campus)
        full_name <- cbind(full_name, M.Sc.2_full_name)
        apprenticeship <- cbind(apprenticeship, M.Sc.2_apprenticeship)
        start_date <- cbind(start_date, M.Sc.2_start_date)
        end_date <- cbind(end_date, M.Sc.2_end_date)
        ects <- cbind(ects, M.Sc.2_ects)
        index <- index + 1
      }
      abbrevation <- cbind(abbrevation, year)
      colnames(abbrevation) <- abbrevation
    }
    for (yearAfterHighSchool in t[2]) {
      afterHighSchool <- cbind(afterHighSchool, yearAfterHighSchool)
      colnames(afterHighSchool) <- paste0(abbrevation, "_afterHighSchool")
    }
    
    for (countryName in t[5]) {
      country <- cbind(country, countryName)
      colnames(country) <- paste0(abbrevation, "_country")
    }
    for (campusName in t[4]) {
      campus <- cbind(campus, campusName)
      colnames(campus) <- paste0(abbrevation, "_campus")
    }
    for (year_full_name in t[8]) {
      full_name <- cbind(full_name, year_full_name)
      colnames(full_name) <- paste0(abbrevation, "_full_name")
    }
    for (is_apprenticeship in t[3]) {
      apprenticeship <- cbind(apprenticeship, is_apprenticeship)
      colnames(apprenticeship) <- paste0(abbrevation, "_apprenticeship")
    }
    for (started_date in t[10]) {
      start_date <- cbind(start_date, started_date)
      colnames(start_date) <- paste0(abbrevation, '_start_date')
    }
    for (ended_date in t[7]) {
      end_date <- cbind(end_date, ended_date)
      colnames(end_date) <- paste0(abbrevation, "_end_date")
    }
    for (nb_ects in t[6]) {
      ects <- cbind(ects, nb_ects)
      colnames(ects) <- paste0(abbrevation, "_ects")
    }
    index <- index + 1
  }
  if(!( 'A.Sc.1' %in% abbrevation)) {
    A.Sc.1 = 'A.Sc.1'
    A.Sc.1_afterHighSchool = NA
    A.Sc.1_country = NA
    A.Sc.1_campus = NA
    A.Sc.1_full_name = NA
    A.Sc.1_apprenticeship = NA
    A.Sc.1_start_date = NA
    A.Sc.1_end_date = NA
    A.Sc.1_ects = NA
    abbrevation <- cbind(abbrevation, A.Sc.1)
    afterHighSchool <- cbind(afterHighSchool, A.Sc.1_afterHighSchool)
    country <- cbind(country, A.Sc.1_country)
    campus <- cbind(campus, A.Sc.1_campus)
    full_name <- cbind(full_name, A.Sc.1_full_name)
    apprenticeship <- cbind(apprenticeship, A.Sc.1_apprenticeship)
    start_date <- cbind(start_date, A.Sc.1_start_date)
    end_date <- cbind(end_date, A.Sc.1_end_date)
    ects <- cbind(ects, A.Sc.1_ects)
  }
  if(!( 'A.Sc.2' %in% abbrevation)) {
    A.Sc.2 = 'A.Sc.2'
    A.Sc.2_afterHighSchool = NA
    A.Sc.2_country = NA
    A.Sc.2_campus = NA
    A.Sc.2_full_name = NA
    A.Sc.2_apprenticeship = NA
    A.Sc.2_start_date = NA
    A.Sc.2_end_date = NA
    A.Sc.2_ects = NA
    abbrevation <- cbind(abbrevation, A.Sc.2)
    afterHighSchool <- cbind(afterHighSchool, A.Sc.2_afterHighSchool)
    country <- cbind(country, A.Sc.2_country)
    campus <- cbind(campus, A.Sc.2_campus)
    full_name <- cbind(full_name, A.Sc.2_full_name)
    apprenticeship <- cbind(apprenticeship, A.Sc.2_apprenticeship)
    start_date <- cbind(start_date, A.Sc.2_start_date)
    end_date <- cbind(end_date, A.Sc.2_end_date)
    ects <- cbind(ects, A.Sc.2_ects)
  }
  if(!( 'B.Sc.' %in% abbrevation)) {
    B.Sc. = 'B.Sc.'
    B.Sc._afterHighSchool = NA
    B.Sc._country = NA
    B.Sc._campus = NA
    B.Sc._full_name = NA
    B.Sc._apprenticeship = NA
    B.Sc._start_date = NA
    B.Sc._end_date = NA
    B.Sc._ects = NA
    abbrevation <- cbind(abbrevation, B.Sc.)
    afterHighSchool <- cbind(afterHighSchool, B.Sc._afterHighSchool)
    country <- cbind(country, B.Sc._country)
    campus <- cbind(campus, B.Sc._campus)
    full_name <- cbind(full_name, B.Sc._full_name)
    apprenticeship <- cbind(apprenticeship, B.Sc._apprenticeship)
    start_date <- cbind(start_date, B.Sc._start_date)
    end_date <- cbind(end_date, B.Sc._end_date)
    ects <- cbind(ects, B.Sc._ects)
  }
  if(!( 'M.Sc.1' %in% abbrevation)) {
    M.Sc.1 = 'M.Sc.1'
    M.Sc.1_afterHighSchool = NA
    M.Sc.1_country = NA
    M.Sc.1_campus = NA
    M.Sc.1_full_name = NA
    M.Sc.1_apprenticeship = NA
    M.Sc.1_start_date = NA
    M.Sc.1_end_date = NA
    M.Sc.1_ects = NA
    abbrevation <- cbind(abbrevation, M.Sc.1)
    afterHighSchool <- cbind(afterHighSchool, M.Sc.1_afterHighSchool)
    country <- cbind(country, M.Sc.1_country)
    campus <- cbind(campus, M.Sc.1_campus)
    full_name <- cbind(full_name, M.Sc.1_full_name)
    apprenticeship <- cbind(apprenticeship, M.Sc.1_apprenticeship)
    start_date <- cbind(start_date, M.Sc.1_start_date)
    end_date <- cbind(end_date, M.Sc.1_end_date)
    ects <- cbind(ects, M.Sc.1_ects)
  }
  if(!( 'M.Sc.2' %in% abbrevation)) {
    M.Sc.2 = 'M.Sc.2'
    M.Sc.2_afterHighSchool = NA
    M.Sc.2_country = NA
    M.Sc.2_campus = NA
    M.Sc.2_full_name = NA
    M.Sc.2_apprenticeship = NA
    M.Sc.2_start_date = NA
    M.Sc.2_end_date = NA
    M.Sc.2_ects = NA
    abbrevation <- cbind(abbrevation, M.Sc.2)
    afterHighSchool <- cbind(afterHighSchool, M.Sc.2_afterHighSchool)
    country <- cbind(country, M.Sc.2_country)
    campus <- cbind(campus, M.Sc.2_campus)
    full_name <- cbind(full_name, M.Sc.2_full_name)
    apprenticeship <- cbind(apprenticeship, M.Sc.2_apprenticeship)
    start_date <- cbind(start_date, M.Sc.2_start_date)
    end_date <- cbind(end_date, M.Sc.2_end_date)
    ects <- cbind(ects, M.Sc.2_ects)
  }
  
  row <- cbind(abbrevation, afterHighSchool, country, campus, full_name, apprenticeship, start_date, end_date, ects )
  df_course <- rbind(df_course, row)
  # SparkR::drop(row)
}

# Ajout du df de courses au df global
df_all <- cbind(df_all, df_course)
# Suppression de l'ancienne colonne
df_all$courses <- NULL

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$schema <- renderPrint({
   
  })
  output$table <- renderDataTable(df_all)

  
  
  
})


# Close the spark connection
# sparkR.session.stop()
