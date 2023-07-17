#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="n"
cmd="npm "
# applicable="package.json"

[ "$1" = '-h' ] &&
    echo "n ( $cmd ) shortcut script ~/.kish/n.sh" &&
    echo 'first param optional: relative directory to run npm operation on.' &&
    exit

ki-spread "$@"
klog "$cmd $*"
