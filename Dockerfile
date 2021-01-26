# get shiny serves plus tidyverse packages image
FROM rocker/shiny-verse:latest
ENV http_proxy "http://eau.grand.lyon@gateway.veolia.zscaler.net:9400/"
ENV https_proxy "http://eau.grand.lyon@gateway.veolia.zscaler.net:9400/"
# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev 

RUN apt install -y openjdk-8-jdk
RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
RUN export PATH=$PATH:$JAVA_HOME/bin
RUN java -version
RUN R CMD javareconf
RUN apt-get install -y libudunits2-dev
RUN apt-get install -y libgdal-dev
RUN apt-get install -y libjq-dev
# install R packages required 
# (change it dependeing on the packages you need)
################
#install R packages
################
RUN R -e "getwd()"

RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('htmltools')"
RUN R -e "install.packages('zoo')"
RUN R -e "install.packages('xts')"
RUN R -e "install.packages('dygraphs')"

# copy the app to the image
COPY ./ /srv/shiny-server/

# select port
EXPOSE 3838

# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server
# run app
# run app on container start
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app.R', host = '0.0.0.0', port = 3838)"]
#CMD ["./usr/bin/shiny-server.sh"]