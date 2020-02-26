# Dockerfile extending the generic Go image with application files for a
# single application.
FROM gcr.io/google-appengine/golang:1.8
RUN apt-get update; apt-get install -y git

COPY ./appengine /go/src/app
RUN go get github.research.chop.edu/evansj/warehouse-beacon
RUN go-wrapper install -tags appenginevm
