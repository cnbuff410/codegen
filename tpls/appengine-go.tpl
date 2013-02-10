package main

import (
	"html/template"
	"net/http"
)

func init() {
	http.HandleFunc("/", testHandler)
}

func testHandler(w http.ResponseWriter, r *http.Request) {
	t := template.Must(template.ParseFiles("templates/main.html"))

	if err := t.Execute(w, nil); err != nil {
		http.Error(w, err.Error(),
			http.StatusInternalServerError)
		return
	}
}
