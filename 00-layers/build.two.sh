#!/bin/bash
docker build -t hello-python:two -f Dockerfile.two . 

docker images | grep hello-python
