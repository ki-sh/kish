#!/bin/bash
source "$HOME/.kish/lib/util.sh"
source "$HOME/.kish/lib/klog.sh"
st="omap"
cmd="open google maps directions from/to"
qkey=""

if [ "$1" = '-h' ]; then
    echo "ga ( $cmd)" &&
        echo "omap kebabye beckenham" &&
        echo "omap islington london - isle of skye"
    exit
fi

IFS='-'
read -ra dashsplit <<<"$@"
IFS=' '


if [ ${#dashsplit[@]} -eq 2 ]; then
    paths="dir/${dashsplit[0]}/${dashsplit[1]}"
    paths=${paths//' '/'+'} 
fi
if [ ${#dashsplit[@]} -eq 1 ]; then
    paths="place/"$(join '+' "$@")
fi

url="https://google.com/maps/$paths"
echo "open $url"

open --url "$url"
klog "$cmd $*"
