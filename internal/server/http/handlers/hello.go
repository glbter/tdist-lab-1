package handlers

import (
	"fmt"
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
)

var (
	helloRequestsTotal = promauto.NewCounter(prometheus.CounterOpts{
		Name: "http_hellos_total",
		Help: "The total number of requests",
	})
)

func (h *Handlers) Hello(w http.ResponseWriter, r *http.Request) {
	const indexHTML = `
<!doctype html>
<html lang="uk-UA">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Hello Go world</title>
        <style>
            body {
                background-color: black;
                color: white;
            }
        </style>
    </head>
    <body>
        <p>Привіт, Світ!</p>
    </body>
</html>
`

	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	fmt.Fprint(w, indexHTML)

	helloRequestsTotal.Inc()
}
