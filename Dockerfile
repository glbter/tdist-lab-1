FROM golang:latest AS builder
RUN mkdir /app
WORKDIR /app
RUN mkdir ./bin
COPY ./ ./
RUN go build -o ./bin/trist ./

FROM ubuntu:latest

RUN mkdir /app

COPY --from=builder /app/bin/trist /app

EXPOSE 8080
