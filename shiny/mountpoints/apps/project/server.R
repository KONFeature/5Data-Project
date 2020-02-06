# Prepare SparkR (define the bin location on the current system)
Sys.setenv(SPARK_HOME = "/opt/spark-2.4.4-bin-hadoop2.7")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"), .libPaths()))

# Import libs
library(jsonlite)
library(shiny)
library(highcharter)
library(SparkR)
library(dplyr)
library(jsonlite)
library(dplyr)
library(tidyr)
library(plyr)

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



####################
# PREPARATION DU DF
####################

# Fetch students from mongo
students <- SparkR::read.df("", source = "mongo")
students <- SparkR::filter(students, students$id < 1000)
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
  index <- index + 1
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
      if (year != 'A.Sc.1' && index == 1) {
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

      if (year != 'A.Sc.2' && index == 2) {
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

      if (year != 'B.Sc.' && index == 3) {
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
        index <- index + 1
      }

      if (year != 'M.Sc.1' && index == 4) {
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

      if (year != 'M.Sc.2' && index == 5) {
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

  if (!('A.Sc.1' %in% abbrevation)) {
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

  if (!('A.Sc.2' %in% abbrevation)) {
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

  if (!('B.Sc.' %in% abbrevation)) {
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

  if (!('M.Sc.1' %in% abbrevation)) {
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

  if (!('M.Sc.2' %in% abbrevation)) {
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

  row <- cbind(abbrevation, afterHighSchool, country, campus, full_name, apprenticeship, start_date, end_date, ects)
  df_course <- rbind(df_course, row)
  # SparkR::drop(row)
}

# Ajout du df de courses au df global
df_all <- cbind(df_all, df_course)
# Suppression de l'ancienne colonne
df_all$courses <- NULL

# Arrange some cols and aggregate some data
df_all <- df_all %>%
  mutate(graduated = replace_na(graduated, FALSE),
    course_was_left = replace_na(course_was_left, FALSE),
    A.Sc.1_ects = as.numeric(A.Sc.1_ects), # Convertie les credit ECTS en numeric
    A.Sc.2_ects = as.numeric(A.Sc.2_ects),
    B.Sc._ects = as.numeric(B.Sc._ects),
    M.Sc.1_ects = as.numeric(M.Sc.1_ects),
    M.Sc.2_ects = as.numeric(M.Sc.2_ects),
    A.Sc.1_ects = replace_na(A.Sc.1_ects, 0), # Remplace les NA des crédits en 0
    A.Sc.2_ects = replace_na(A.Sc.2_ects, 0),
    B.Sc._ects = replace_na(B.Sc._ects, 0),
    M.Sc.1_ects = replace_na(M.Sc.1_ects, 0),
    M.Sc.2_ects = replace_na(M.Sc.2_ects, 0), 
    last_country = ifelse(!is.na(M.Sc.2_country), M.Sc.2_country, # Ajoute le dernier pays de l'utilisateur
                    ifelse(!is.na(M.Sc.1_country), M.Sc.1_country, 
                      ifelse(!is.na(B.Sc._country), B.Sc._country, 
                        ifelse(!is.na(A.Sc.2_country), A.Sc.2_country, 
                          ifelse(!is.na(A.Sc.1_country), A.Sc.1_country, NA))))),
    last_campus = ifelse(!is.na(M.Sc.2_campus), M.Sc.2_campus, # Ajoute le dernier campus de l'utilisateur
                    ifelse(!is.na(M.Sc.1_campus), M.Sc.1_campus, 
                      ifelse(!is.na(B.Sc._campus), B.Sc._campus, 
                        ifelse(!is.na(A.Sc.2_campus), A.Sc.2_campus, 
                          ifelse(!is.na(A.Sc.1_campus), A.Sc.1_campus, NA)))))) %>%
    mutate(sum_ects = rowSums(.[grep("_ects", names(.))], na.rm = TRUE)) # Calcul la somme des ECTS

####################
# PREPARATION DU GRAPH
####################

# Calculate the var we want for the value box
count_students <- nrow(df_all)
count_grad_students <- nrow(df_all[df_all$graduated == TRUE,])
count_left_students <- nrow(df_all[df_all$course_was_left == TRUE,])
ratio_students_graduate <- count_grad_students / count_students * 100
ratio_students_left <- count_left_students / count_students * 100

# Some group for easy plot
discovery_reason <- df_all %>%
  dplyr::count(university_discovery_reason) %>%
  dplyr::arrange(desc(n))
leaving_reason <- df_all %>%
  dplyr::count(course_leaving_reason) %>%
  head(., 5L) %>%
  dplyr::arrange(desc(n))

####################
# LANCEMENT DU SERVEUR
####################

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
      paste0(format(ratio_students_graduate,, digits = 2), "%"),
      "Ratio of gradueted students",
      icon = icon("percentage"),
      color = "yellow"
    )
  })
  output$valueStudentsLeftRatio <- renderValueBox({
    valueBox(
      paste0(format(ratio_students_left, digits = 2), "%"),
      "Ratio of students who left",
      icon = icon("percentage"),
      color = "red"
    )
  })
  output$plotDiscoveryReason <- renderHighchart({
    highchart() %>%
      hc_chart(type = "column") %>%
      hc_xAxis(categories = discovery_reason$university_discovery_reason) %>%
      hc_add_series(discovery_reason$n,
                    name = "Student from", showInLegend = FALSE)
  })
  output$plotLeavingReason <- renderHighchart({
    highchart() %>%
      hc_chart(type = "column") %>%
      hc_xAxis(categories = leaving_reason$course_leaving_reason) %>%
      hc_add_series(leaving_reason$n,
                    name = "Student leaved", showInLegend = FALSE)
  })

  ####################
  # TABLE
  ####################
  output$table <- renderDataTable(head(df_all), options = list(scrollX = TRUE))

  ####################
  # Dynamic graph
  ####################

  output$testStr <- renderPrint({
    input$column_axis_x
  })

  output$dynamicPlot <- renderHighchart({
    df_filtered <- df_all
    # Check for filter
    graduated_filter <- as.logical(input$graduated_select)
    leave_filter <- as.logical(input$leave_select)
    if(!is.na(graduated_filter)) {
      df_filtered <- df_filtered[df_filtered$graduated == graduated_filter,]
    }
    if(!is.na(leave_filter)) {
      df_filtered <- df_filtered[df_filtered$course_was_left == leave_filter,]
    }

    # Group & arrange df
    df_filtered <- df_filtered %>%
      dplyr::count(df_filtered[[input$column_axis_x]]) %>%
      dplyr::arrange(desc(n))

    # Generate graph
    highchart() %>%
      hc_chart(type = "column") %>%
      hc_xAxis(categories = df_filtered[[input$column_axis_x]]) %>%
      hc_add_series(df_filtered$n,
                    name = "Count", showInLegend = FALSE)
  })

})


# Close the spark connection
# sparkR.session.stop()
