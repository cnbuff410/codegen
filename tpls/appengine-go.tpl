package main

import (
	"appengine"
	"fmt"
	//"html/template"
	"io/ioutil"
	"net/http"
	"strings"
)

const (
	FILE_KEY = "FILE"
)

func init() {
	http.HandleFunc("/", testHandler)
	http.HandleFunc("/upload", uploadFileHandler)
}

func testHandler(w http.ResponseWriter, r *http.Request) {
	/*
		t := template.Must(template.ParseFiles("templates/main.html"))

		if err := t.Execute(w, nil); err != nil {
			http.Error(w, err.Error(),
				http.StatusInternalServerError)
			return
		}
	*/

	c := appengine.NewContext(r)
	r.ParseForm()

	if r.Method == "GET" {
		c.Infof("path", r.URL.Path)
		c.Infof("scheme", r.URL.Scheme)
		fmt.Fprintf(w, "Hello world!")
	} else {
		c.Infof("Form is %v", r.Form)
		c.Infof("Header is %v", r.Header)
		for k, v := range r.Form {
			c.Infof("key:", k)
			c.Infof("val:", strings.Join(v, ""))
		}
		fmt.Fprintf(w, "OK,")
	}
}

func uploadFileHandler(w http.ResponseWriter, r *http.Request) {
	c := appengine.NewContext(r)
	r.ParseMultipartForm(32 << 20) // About 30 MB
	file, handler, err := r.FormFile(FILE_KEY)
	check(err, c)
	defer file.Close()
	fmt.Fprintf(w, "%v", handler.Header)
	content, err := ioutil.ReadAll(file)
	check(err, c)
	c.Infof("The content of file is %v\n", string(content))
	fmt.Fprintf(w, "OK,")
	/*
		f, err := os.OpenFile("./test/"+handler.Filename, os.O_WRONLY|os.O_CREATE, 0666)
		defer f.Close()
		io.Copy(f, file)
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
