#!/bin/bash
docker build -t hello-go:scratch -f Dockerfile.scratch . 

docker images | grep hello-go
