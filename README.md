codegen
=======

A handy template code generating tool.

There are two kinds of template files, one is used to indicate filetype, e.g.,
go.tpl or py.tpl. The other is used to indicate application specific file template, e.g., test-go.tpl

Therefore, there are two ways to generate file template

- If you want to generate a file with sepcific type, provide a full file name with suffix, the suffix will be matched with
corresponding template file. For example:

>"codegen -g test.py"
>
>will be matched with
>
>"py.tpl"
>
>and generated as
>
>"test.py"

- If you want to generate a spcific file, like a yaml file for go appengine, provide the name of template, the generated file will have suffix which is
the last part of the template filename separated by dash. For example:

>"codegen -g test-go.tpl"
>
>will be generated as
>
>"test.go"


### Setup

To test it out, use

go get -u github.com/cnbuff410/codegen (-u flag for "update")

Then

codegen -h

### TODO

Regex match
