FROM rocker/shiny:latest

# Update image
RUN apt update -y
RUN apt upgrade -y

# Install openJdk8
RUN apt install openjdk-8-jre -y

# Install missing libs for SparkR
RUN apt install libgit2-dev libssl-dev libssh2-1-dev libudunits2-dev libxml2-dev -y

# Download & extract spark
RUN wget  -O /opt/spark.tgz http://apache.crihan.fr/dist/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz
RUN tar zxvf /opt/spark.tgz -C /opt/
RUN export SPARK_HOME=/opt/spark-2.4.4-bin-hadoop2.7

# Install package 
RUN  echo 'install.packages(c("rjson", "SparkR", "ggvis", "dplyr", "devtools", "listviewer", "httr"), \
  repos="http://cran.us.r-project.org", \
  dependencies=TRUE)' > /tmp/packages.R \
  && Rscript /tmp/packages.R

EXPOSE 3838
CMD ["/usr/bin/shiny-server.sh"]