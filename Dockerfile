# Dockerfile extending the generic Go image with application files for a
# single application.
# https://stackoverflow.com/questions/50707946/docker-for-golang-application
#FROM gcr.io/google-appengine/golang:1.8
#FROM gcr.io/gcpug-container/appengine-go:1.13
FROM golang:1.9.6-alpine3.7
#RUN apt-get update; apt-get install -y git
RUN apk add --no-cache git

COPY ./appengine /go/src/app
RUN go get github.research.chop.edu/evansj/warehouse-beacon/beacon
RUN go-wrapper install -tags appenginevm
