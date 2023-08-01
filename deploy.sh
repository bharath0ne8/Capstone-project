#!/bin/bash

if [[ $GIT_BRANCH == dev ]]; then
    cd react
    chmod +x build.sh
    ./build.sh
    docker login --username="$docker_username" --password="$docker_password"
    echo "$docker_password" | docker login -u "$docker_username" --password-stdin
    docker image tag react:v1 "$docker_username/dev:v1"
    docker image push "$docker_username/dev:v1"
elif [[ $GIT_BRANCH == master ]]; then
    cd react
    chmod +x build.sh
    ./build.sh
    docker login --username="$docker_username" --password="$docker_password"
    echo "$docker_password" | docker login -u "$docker_username" --password-stdin
    docker image tag react:v1 "$docker_username/prod:v1"
    docker image push "$docker_username/prod:v1"
else
    echo "Deployment is failure"
fi

 # Make the shell script executable
  chmod +x build.sh

  # Build and run the Docker containers using Docker Compose
  ./build.sh

  # Optional: Stop and remove any previously running containers to clean up
  docker-compose down

  # Start the Docker containers in the background
  docker-compose up -d
EOF
