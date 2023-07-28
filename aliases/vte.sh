#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st='vte'
cmd='npm init vite'
applicable=''
 
if [ "$1" = -h ]; then
"$command_name ( $command_execute)"
 exit
fi
echo ''
echo "vite create project. creates a dir of Project name..."
ki-spread "$@"
klog "$cmd $*"
echo "or Now run ki way, : n/pn/y install "
