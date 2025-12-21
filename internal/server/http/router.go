package http

import (
	"github.com/go-chi/chi"
	"go.uber.org/zap"

	"github.com/prometheus/client_golang/prometheus/promhttp"

	"github.com/glbter/trist/internal/server/http/handlers"
	"github.com/glbter/trist/internal/server/http/middleware"
)

func NewRouter(logger *zap.Logger) (chi.Router, error) {

	md := &middleware.Middleware{Logger: logger}

	hs := handlers.NewHandler(logger)

	r := chi.NewRouter()
	r.Use(md.LoggingMiddleware)

	r.Route("/api", func(r chi.Router) {
		r.Get("/hello", hs.Hello)
	})

	r.Mount("/metrics", promhttp.Handler())

	return r, nil
}
