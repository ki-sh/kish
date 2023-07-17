#!/bin/bash
source "$HOME/.kish/lib/util.sh"
st="o"
cmd="least typing browsing ever"

if [ "$1" = '-h' ] || [ ${#1} -eq 0 ]; then
    echo $st $cmd
    echo "examples:" &&
        echo "o google cats" &&
        echo "o google.co.uk cats" &&
        echo "o google/maps london" &&
        echo "o duckduckgo look ma no pesky quotes needed for search term!" &&
        echo "o github/reactjs/react.dev/issues 6038"
    echo "o duckduckgo\?df=y within last year search (tech moves fast)"
    echo "o google/maps/dir/St+Jean-Pied-du-Port/leon+spain #map directions from to "

    echo "explanation:" &&
        echo "opens your default web browser with:" &&
        echo "[defaults to https://] [domain name]  [defaults to .com] [/path/s] [\? queryterm=value&...] [params 2... -> (?q= param 2...]"
    echo "Ctl-w (cmd-w mac) is you friend! closes last opened tab"
    exit
fi

qkey="q"

cmdurl "$@"
echo "open $url"
open --url "$url"

# function urlencode() {
#     # urlencode <string>

#     old_lc_collate=$LC_COLLATE
#     LC_COLLATE=C

#     local length="${#1}"
#     for (( i = 0; i < length; i++ )); do
#         local c="${1:$i:1}"
#         case $c in
#             [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
#             *) printf '%%%02X' "'$c" ;;
#         esac
#     done

#     LC_COLLATE=$old_lc_collate
# }
