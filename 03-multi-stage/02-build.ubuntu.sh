#!/bin/bash
docker build -t hello-go:ubuntu -f Dockerfile.ubuntu .

docker images | grep hello-go
