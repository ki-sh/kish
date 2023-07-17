#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st='hrcl'
cmd='gh repo clone'
applicable=''

if [ "$1" = -h ]; then
    "$command_name ( $command_execute)"
    exit
fi
ki-spread "$@"
klog "$cmd $*"
