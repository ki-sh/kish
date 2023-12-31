#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="y"
cmd="yarn"
applicable="package.json"

if [ "$1" = '-h' ]; then
    printf "${IYel}"
    echo "$st ($cmd) filters: $applicable must be present in dirs."
    printf "${Whi}"
    exit
fi

ki-spread "$@"
klog "$cmd $*"
