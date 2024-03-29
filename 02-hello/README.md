## O2-Hello

```bash
docker build -t hello-02 .

docker history --format "table {{.CreatedBy}}\t{{.Size}}" hello-02
docker images | grep hello-02

docker run -d -p 7070:8080 --name hello-02-container --rm hello-02
# I'm listening on the 8080 http port, I map the host 7070 port of the host on the container port
```
> - Open http://localhost:6060


docker history hello-02