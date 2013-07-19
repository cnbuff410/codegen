// Author: likunarmstrong@gmail.com

// Package main xxx
package main

import (
	"appengine"
	"fmt"
	//"html/template"
	"io/ioutil"
	"net/http"
	"strings"
)

func init() {
	http.HandleFunc("/", testHandler)
	http.HandleFunc("/upload", uploadFileHandler)
}

func testHandler(w http.ResponseWriter, r *http.Request) {
	c := appengine.NewContext(r)
	r.ParseForm()

	if r.Method == "GET" {
		c.Infof("path", r.URL.Path)
		c.Infof("scheme", r.URL.Scheme)
		fmt.Fprintf(w, "Hello world!")
	}
	/*
		t := template.Must(template.ParseFiles("templates/main.html"))

		if err := t.Execute(w, nil); err != nil {
			http.Error(w, err.Error(),
				http.StatusInternalServerError)
			return
		}
	*/
}

func check(err error, c appengine.Context) {
	if err != nil {
                http.Error(w, err.Error(), http.StatusInternalServerError)
		c.Errorf("%v", err)
	}
}
func serve404(w http.ResponseWriter) {
        w.WriteHeader(http.StatusNotFound)
        w.Header().Set("Content-Type", "text/plain; charset=utf-8")
        fmt.Fprintln(w, "Not Found")
}
