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

	fileNameErrMsg = "Not a valid file name.\n" +
		"Either the file name is not recognizable or the template for " +
		"this file type is not supplied"
)

var (
	genName string
	isList  bool
	tplDir  string
	srcFile string
	dstFile string
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
	tplFullPathList := make([]string, 0)

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

		// A slice to store templates only valid when user provide full file name
		tplSuffixList := make([]string, 0)
		// A slice to store templates can be directly used by -g
		tplFullNameList := make([]string, 0)
		filepath.Walk(tplRoot, func(path string, fileinfo os.FileInfo, _ error) error {
			if fileinfo.IsDir() || !strings.EqualFold(filepath.Ext(path), ".tpl") {
				return nil
			}
			fName := strings.Split(filepath.Base(path), ".")[0]
			if strings.Contains(fName, "-") {
				tplFullNameList = append(tplFullNameList, fName)
			} else {
				tplSuffixList = append(tplSuffixList, fName)
			}
			tplFullPathList = append(tplFullPathList, path)
			return nil
		})

		fmt.Println("\nUse full template name showing below after -g to generate:")
		for _, n := range tplFullNameList {
			fmt.Printf("* %s\n", n)
		}

		fmt.Println("\nUse YOUROWNNAME + template file type showing below after -g to generate:")
		for _, n := range tplSuffixList {
			fmt.Printf("* %s\n", n)
		}

		fmt.Println("\nPut new templates into folder:")
		fmt.Println(tplRoot)
		fmt.Printf("\n")
	}

	// Generate templates if needed
	if len(genName) > 0 {
		templateNames := make([]string, 0)
		err := filepath.Walk(tplRoot,
			func(path string, f os.FileInfo, err error) error {
				fmt.Println(path)
				if err != nil {
					fmt.Println(err)
					return err
				}
				if f.IsDir() {
					// Root dir, ignore
					return nil
				}
				templateNames = append(templateNames, filepath.Base(path))
				return nil
			})
		if err != nil {
			fmt.Println("Something wrong with template library, " +
				"are you sure you set it up already?")
			return
		}

		// If a real file name is provided, pick template based on suffix
		nameComponents := strings.Split(genName, ".")
		if len(nameComponents) == 2 {
			// Probably a complete file name with suffix
			suffix := nameComponents[1]
			for _, v := range templateNames {
				v = strings.Split(v, ".")[0]
				if v == suffix {
					srcFile = tplRoot + "/" + v + ".tpl"
					dstFile = "./" + genName
					break
				}
			}
		} else if len(nameComponents) == 1 {
			if !strings.Contains(nameComponents[0], "-") {
				fmt.Printf("\n")
				fmt.Println("Oops, looks like you are trying to generate a file of specific type?")
				fmt.Println("If so, please provide a full filename with suffix, e.g., my.go")
				fmt.Printf("\n")
				return
			}
			for _, v := range templateNames {
				if v == genName+".tpl" {
					srcFile = tplRoot + "/" + genName + ".tpl"
					nameItems := strings.Split(genName, "-")
					dstFile = "./" + strings.Join(nameItems[:len(nameItems)-1],
						"-") + "." + nameItems[len(nameItems)-1]
					break
				}
			}
		} else {
			fmt.Println(fileNameErrMsg)
			return
		}

		// Provided file name is not supported
		if len(dstFile) == 0 {
			fmt.Println(fileNameErrMsg)
			return
		}

		// Write into file
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
