// Created by Kun Li(likunarmstrong@gmail.com) on xx/xx/xx.
// Copyright (c) 2014 Athlete Architect. All rights reserved.

// Package main xxx
package main

import (
	"appengine"
	"fmt"
	//"html/template"
	"io/ioutil"
	"net/http"
	"strings"
	"github.com/gorilla/mux"
)

func init() {
	r := mux.NewRouter()
	s := r.PathPrefix("/").Subrouter()
	s.HandleFunc("/", errorHandler(testHandler)).Methods("GET")
	http.Handle("/", s)
}

func testHandler(w http.ResponseWriter, r *http.Request) error {
	c := appengine.NewContext(r)
	r.ParseForm()

	c.Infof("path", r.URL.Path)
	c.Infof("scheme", r.URL.Scheme)
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
