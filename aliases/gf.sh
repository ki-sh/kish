#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st='gf'
cmd='git fetch --prune origin'
applicable=''
 
if [ "$1" = -h ]; then
"$command_name ( $command_execute)"
 exit
fi
ki-spread "$@"
klog "$cmd $*"
