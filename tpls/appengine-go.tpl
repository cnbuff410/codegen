// Created by Kun Li(likunarmstrong@gmail.com) on xx/xx/xx.
// Copyright (c) 2014 Stryd. All rights reserved.

// Package main xxx
package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"
	"github.com/gorilla/mux"

	"google.golang.org/appengine"
	"google.golang.org/appengine/log"
)

func init() {
	r := mux.NewRouter()
	s := r.PathPrefix("/").Subrouter()
	s.HandleFunc("/", errorHandler(testHandler)).Methods("GET")
	http.Handle("/", s)

	appengine.Main()
}

func testHandler(w http.ResponseWriter, r *http.Request) error {
    ctx := appengine.NewContext(r)
	log.Infof(ctx, "Serving the front page.")

	r.ParseForm()
	fmt.Fprintf(w, "Hello world!")
    return nil

	//return fmt.Errorf("invalid date")
	/*
		t := template.Must(template.ParseFiles("templates/main.html"))

		if err := t.Execute(w, nil); err != nil {
			http.Error(w, err.Error(),
				http.StatusInternalServerError)
			return
		}
	*/
}

func errorHandler(f func(http.ResponseWriter, *http.Request) error) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		err := f(w, r)
		if err != nil {
			c := appengine.NewContext(r)
			http.Error(w, err.Error(), http.StatusInternalServerError)
			c.Errorf("failed to handling %q: %v", r.RequestURI, err)
		}
	}
}
