FROM rocker/shiny:latest

# Install missing libs for SparkR
RUN apt update
RUN apt install libgit2-dev
RUN apt install libssl-dev
RUN apt install libssh2-1-dev
RUN apt install libudunits2-dev
RUN apt install libxml2-dev

#install package 
RUN  echo 'install.packages(c("rjson", "SparkR", "ggvis", "dplyr"), \
  repos="http://cran.us.r-project.org", \
  dependencies=TRUE)' > /tmp/packages.R \
  && Rscript /tmp/packages.R

EXPOSE 3838
CMD ["/usr/bin/shiny-server.sh"]