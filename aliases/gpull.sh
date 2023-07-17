#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="gpull"
cmd="git pull"
applicable=".git"

[ "$1" = '-h' ] &&
    echo "pull ( $cmd ) shortcut script ~/.kish/n.sh" &&
    echo 'first param optional: relative directory to run git operation on.' &&
    exit

ki-spread "$@"
klog "$cmd $*"
