package main

import (
	"fmt"
	"net/http"
	"os"

	"github.research.chop.edu/evansj/warehouse-beacon/beacon"
)

const (
	project  = "GOOGLE_CLOUD_PROJECT"
	bqTable  = "GOOGLE_BIGQUERY_TABLE"
	authMode = "AUTHENTICATION_MODE"
)

func main() {
	server := beacon.Server{
		ProjectID: os.Getenv(project),
		TableID:   os.Getenv(bqTable),
		AuthMode:  serverAuthMode(),
	}

	if server.ProjectID == "" {
		panic(fmt.Sprintf("environment variable %s must be specified", project))
	}
	if server.TableID == "" {
		panic(fmt.Sprintf("environment variable %s must be specified", bqTable))
	}

	mux := http.NewServeMux()
	server.Export(mux)

	http.HandleFunc("/", mux.ServeHTTP)
}

func serverAuthMode() beacon.AuthenticationMode {
	switch os.Getenv(authMode) {
	case "service":
		return beacon.ServiceAuth
	case "user":
		return beacon.UserAuth
	default:
		panic(fmt.Sprintf("missing or invalid value for variable %s", authMode))
	}
}
