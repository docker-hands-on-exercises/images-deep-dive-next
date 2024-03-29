
```bash
docker build -t hello-python:one -f Dockerfile.one . 

docker history --format "table {{.CreatedBy}}\t{{.Size}}" hello-python:one
docker images | grep hello-python

docker build -t hello-python:two -f Dockerfile.two . 

docker history --format "table {{.CreatedBy}}\t{{.Size}}" hello-python:two
docker images | grep hello-python
```

