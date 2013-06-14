codegen
=======

A handy template code generating tool.

There are two ways to generate file template

- If a full file name with suffix is provided, the suffix will be matched with
template file. For example:

>"test.py"
>
>will be generated as
>
>"py.tpl"

- If the name of template is provided(signal word), Suffix of generated file is
the last part of the template filename separated by dash. For example:

>"xxx-go.tpl"
>
>will be generated as
>
>"xxx.go"


### Setup

To test it out, use

    go get -u github.com/cnbuff410/codegen (-u flag for "update")

Then

    codegen -h

### TODO

Enable regex match
