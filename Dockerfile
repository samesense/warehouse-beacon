# Dockerfile extending the generic Go image with application files for a
# single application.

# https://stackoverflow.com/questions/50707946/docker-for-golang-application
FROM gcr.io/google-appengine/golang:1.8
#FROM gcr.io/gcpug-container/appengine-go:1.13
#FROM golang:1.9.6-alpine3.7
RUN apt-get update; apt-get install -y git
#RUN apk add --no-cache git

COPY ./appengine /go/src/app
RUN go get github.research.chop.edu/evansj/warehouse-beacon/beacon
RUN cd /go/src/app/ && go-wrapper install -tags appenginevm

# FROM golang:1.9.6-alpine3.7
# WORKDIR /go/src/app
# COPY . .
# RUN apk add --no-cache git
# RUN go-wrapper download   # "go get -d -v ./..."
# RUN go-wrapper install    # "go install -v ./..."

# #final stage
# FROM alpine:latest
# RUN apk --no-cache add ca-certificates
# COPY --from=builder /go/bin/app /app
# ENTRYPOINT ./app
# LABEL Name=cloud-native-go Version=0.0.1
# EXPOSE 3000