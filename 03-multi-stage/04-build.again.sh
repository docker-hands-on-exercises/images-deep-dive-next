#!/bin/bash
docker build -t hello-go:again -f Dockerfile.again . 

docker images | grep hello-go
