FROM arm64v8/golang:latest AS builder
RUN mkdir /app
WORKDIR /app
RUN mkdir ./bin
COPY ./ ./
RUN go build -o ./bin/trist ./

FROM arm64v8/alpine:latest

COPY --from=builder /app/bin/trist /app

EXPOSE 8080
