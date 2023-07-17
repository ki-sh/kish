#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="pn"
cmd="pnpm run"
applicable="package.json"

[ "$1" = '-h' ] &&
    echo "pn ( $cmd ) shortcut script ~/.kish/pn.sh" &&
    exit

ki-spread "$@"
source "$HOME/.kish/lib/klog.sh"
