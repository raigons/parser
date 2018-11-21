#!/usr/bin/env bash

#build ruby image
IMAGE_NAME="my/ruby"
TAG="2.5.3"

docker build -f infra/docker/ruby/Dockerfile -t ${IMAGE_NAME}:${TAG} infra/docker/ruby/.

#build app
docker build -f infra/docker/app/Dockerfile -t 'whatsapp-parser' .
