# Dockerize-R-shiny-app
An example of dockerized R shiny app

## Prerequisite 
- Install Docker Desktop and create a docker acount 
- Run Docker Desktop (make sure you have switched to Linux containers even if you are on Windows OS). Ensure to set up proxies paramaeters if necessary . Note that proxies parameters must also be set at the beginining of Dockerfile using ENV command (ex : ENV http_proxy "http://...")
- Go to the terminal ( cmd commmand ) and use cd command to locate to the host directoty of the shiny app (that directory must  app.R including ui and server parts and of course the Dockerfile)


# Create docker image using the following command :
	docker build --file=./Dockerfile --tag=shinydockerapp .


#### At this point, suppose your image is now shinydockerapp 

# Run docker container using the following command :
	docker run -d -p 3838:3838 -e DISABLE_AUTH=true shinydockerapp 
	
- At this point, you should be able to access the shiny App using the following url : IPv4:3838 ( use ipconfing function on the terminal rto know you IPv4 adress)

# Run this command line to stop the container :
	docker stop shinydockerapp

# Run this command line to start the container :
	docker start shinydockerapp


# Run this command line to remove the container :
	docker rm shinydockerapp

# Run this command line to list exisiting containers
  docker container ls 


### Please note that all this commands can directly be done inside Docker Desktop Dashboard
