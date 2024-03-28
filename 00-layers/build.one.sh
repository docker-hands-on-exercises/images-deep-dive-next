#!/bin/bash
docker build -t hello-python:one -f Dockerfile.one . 

docker images | grep hello-python
