FROM golang:1.20-bullseye AS build
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /hello-world

FROM debian:bullseye-slim AS release
WORKDIR /
COPY --from=build /hello-world /hello-world
EXPOSE 8080
ENTRYPOINT ["/hello-world"]