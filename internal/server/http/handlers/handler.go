package handlers

import (
	"go.uber.org/zap"
)

type Handlers struct {
	logger *zap.Logger
}

func NewHandler(logger *zap.Logger) *Handlers {
	return &Handlers{
		logger: logger,
	}
}
