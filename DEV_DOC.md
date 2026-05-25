## This file must describes how a developer can:

### Set up the environment from scratch (prerequisites, configuration files, secrets).

- To set up a working docker enviromnment from scratch within this project you must install the following dependencies:
* docker 
* git 
* wget 
* make 
* curl

### Build and Launch the project using the Makefile and Docker Compose.

This Projects uses docker-compose to manage and run the docker containers and docker compose is managed using makefile with te following commands. 

* make down

- Stops containers and removes containers, networks, volumes, and images created by up.
By default, the only things removed are:
    Containers for services defined in the Compose file.
    Networks defined in the networks section of the Compose file.
    The default network, if one is used.

* make up
Builds, (re)creates, starts, and attaches to containers for a service.
Unless they are already running, this command also starts any linked services.

### Use relevant commands to manage the containers and volumes.

* make build 
Services are built once and then tagged

* make ps
Lists containers for a Compose project, with current status and exposed ports.

* make logs
Displays log output from services

### Identify where the project data is stored and how it persists.

The data of this project is stored within the ~/data/ directory and each service has its information stored in a child directory wiht the name of the corresponding service.