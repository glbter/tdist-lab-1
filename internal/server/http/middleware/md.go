package middleware

import (
	"net/http"
	"time"

	"go.uber.org/zap"
)

type Middleware struct {
	Logger *zap.Logger
}

func (m *Middleware) LoggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		m.Logger.Info("incoming request", zap.String("URI", r.RequestURI))

		start := time.Now()
		next.ServeHTTP(w, r)

		m.Logger.Info("request finished",
			zap.String("took", time.Since(start).String()),
		)
	})
}
