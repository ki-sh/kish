#!/bin/bash
source "$HOME/.kish/lib/util.sh"
 st="oyt"
 cmd="open wikipedia search"
 qkey=""
 paths=$(join '_' $@)

url="https://en.wikipedia.org/wiki/$paths"
echo "open $url"

open --url "$url"

