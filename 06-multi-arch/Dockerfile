FROM --platform=$BUILDPLATFORM golang:1.22.1 as builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /app/
COPY main.go .
COPY go.mod .

RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -ldflags="-s -w" -o hello main.go

FROM --platform=$TARGETPLATFORM scratch
WORKDIR /app/
COPY --from=builder /app/hello /
CMD ["/hello"]

# docker run philippecharriere494/hello-go:multiarch