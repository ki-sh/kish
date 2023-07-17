#!/bin/bash
source "$HOME/.kish/lib/util.sh"
 st="oyt"
 cmd="open(youtube) search-term"
 qkey="search_query"

cmdurl youtube/results "$@"
echo "open $url"

open --url "$url"

