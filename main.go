package main

import (
	"fmt"
	"log"
	"net/http"

	"go.uber.org/zap"

	router "github.com/glbter/trist/internal/server/http"
)

func main() {
	log.Println("Starting service")

	logger, _ := zap.NewProduction()

	r, err := router.NewRouter(logger)
	if err != nil {
		log.Fatal(fmt.Errorf("initialize router: %w", err))
	}

	log.Println("Initialized successfully")

	logger.Info("Start HTTP server")

	if err := http.ListenAndServe(fmt.Sprintf(":%v", 8080), r); err != nil {
		log.Fatalf("failed to listen http: %v", err)
	}
}
