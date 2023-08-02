#!/bin/bash

docker_username: 'bharathsrinivasan'
docker_password: 'dckr_pat_wT2df4Kw2z-5bLCvtcHYOcENHHo'

if [[ $GIT_BRANCH == dev ]]; then
    cd Capstone-project
    chmod +x build.sh
    ./build.sh
    docker login --username="$docker_username" --password="$docker_password"
    echo "$docker_password" | docker login -u "$docker_username" --password-stdin
    docker tag capstone-app-image:v1 "$docker_username/dev:v1"
    docker push "$docker_username/dev:v1"
elif [[ $GIT_BRANCH == main ]]; then
    cd Capstone-project
    chmod +x build.sh
    ./build.sh
    docker login --username="$docker_username" --password="$docker_password"
    echo "$docker_password" | docker login -u "$docker_username" --password-stdin
    docker tag capstone-app-image:v1 "$docker_username/prod:v1"
    docker push "$docker_username/prod:v1"
else
    echo "Deployment is failure"
fi

