#!/bin/sh

# build file for Docker container
NAME="woejood/liatrio-api"
TAG="1.0.0"

docker build ../../app/ -t $NAME:$TAG #--label $NAME:$TAG

docker tag $NAME:$TAG "${NAME}:latest"
docker push $NAME:$TAG
docker push "${NAME}:latest"

#docker run --name $NAME:$TAG -p 5000:5000 -d $NAME:$TAG