#!/bin/bash
docker build -t hello-go:golang -f Dockerfile.golang . 

docker images | grep hello-go
