#!/bin/bash

set -eu

#Check bundler depend
bundle check || bundle true

<<<<<<< HEAD
#Check dependance of Yarn
=======
#Check Yarn depend
>>>>>>> modify_docker
yarn check --integrity --silent || true

exec "$@"

services:
  app:
    environment:
    #Disable Spring in app container
    - DISABLE_SPRING=1

  # Spring Server
  spring:
   build: .

   command: spring server
   entrypoint: /docker-entrypoint-spring.sh

   #Remove process normally
    init: true

   #Run "spring status" and "spring stop" normally
    pid: host

    environment:
      - SPRING_SOCKET=/tmp/spring/spring.sock

    volumes:
      - .:/app
      #Use node_modules from images
      - /app/node_modules
      - spring-tmp:/tmp/spring

volumes:
 #Volume shared with Spring's tmp file
 spring-tmp:
