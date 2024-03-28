#!/bin/bash
docker buildx create --use
docker buildx build  --platform="linux/amd64,linux/arm64" --push -t philippecharriere494/hello-go:multiarch -f Dockerfile.multiarch .

docker images | grep hello-go


