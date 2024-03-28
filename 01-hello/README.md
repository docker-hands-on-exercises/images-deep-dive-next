## O1-Hello

```bash
docker build -t hello-01 .
docker run -d -p 6060:8080 --name hello-02-container --rm hello-01
# I'm listening on the 8080 http port, I map the host 6060 port of the host on the container port
```
> - Open http://localhost:6060

