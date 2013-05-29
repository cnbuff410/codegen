codegen
=======

A handy template code generating tool.

Suffix of generated file is the last part of the template filename separated by
dash. For example:

"xxx-go.tpl"

will be generated as

"xxx.go"

### Setup

To test it out, use

    go get -u github.com/cnbuff410/codegen (-u flag for "update")

Then

    codegen -h

### TODO

Enable regex match
