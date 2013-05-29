/*
 * Codegen: A handy template code generating tool.
 *
 * Author: likunarmstrong@gmail.com
 */

package main

import (
	"bufio"
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
)

const (
	listUsage      = "List all options"
	genUsage       = "Generate template"
	dirUsage       = "Specify the location of template folder"
	configFileName = "/.codegen"
)

var (
	genName string
	isList  bool
	tplDir  string
)

func init() {
	flag.BoolVar(&isList, "l", false, listUsage)
	flag.StringVar(&genName, "g", "", genUsage)
	flag.StringVar(&tplDir, "d", "", dirUsage)
}

func main() {
	flag.Parse()
	if flag.NFlag() == 0 {
		flag.Usage()
		return
	}

	configFilePath := os.Getenv("HOME") + configFileName
	tplList := make([]string, 0)

	// Check if path to template is being set
	if len(tplDir) == 0 {
		if _, err := os.Stat(configFilePath); os.IsNotExist(err) {
			fmt.Printf("Please set the path to your templates by using option -d\n")
			return
		}
	} else {
		tplDir, _ = filepath.Abs(tplDir)
		ioutil.WriteFile(configFilePath, []byte(tplDir), 0644)
	}

	// Get the path to template folder
	configFile, err := os.Open(configFilePath)
	defer configFile.Close()
	if err != nil {
		fmt.Printf("Error in reading config file: %s", configFilePath)
	}
	reader := bufio.NewReader(configFile)
	line, _, _ := reader.ReadLine()
	tplRoot := string(line)

	// Show list of available templates if needed
	if isList {
		fmt.Println("Available templates:")
		fmt.Println("====================")
		filepath.Walk(tplRoot, func(path string, fileinfo os.FileInfo, _ error) error {
			if fileinfo.IsDir() || !strings.EqualFold(filepath.Ext(path), ".tpl") {
				return nil
			}
			fmt.Println("* " + strings.Split(filepath.Base(path), ".")[0])
			tplList = append(tplList, path)
			return nil
		})

		fmt.Println("\nPut new templates into folder:")
		fmt.Println(tplRoot)
	}

	// Generate templates if needed
	if len(genName) > 0 {
		srcFile := tplRoot + "/" + genName + ".tpl"
		nameItems := strings.Split(genName, "-")
		dstFile := "./" + strings.Join(nameItems[:len(nameItems)-1],
			"-") + "." + nameItems[len(nameItems)-1]
		src, err := os.Open(srcFile)
		check(err)
		dest, err := os.Create(dstFile)
		check(err)
		_, err = io.Copy(dest, src)
		check(err)
	}
}

// Only used when explicit error checking is not needed.
func check(e error) {
	if e != nil {
		panic(e)
	}
}
