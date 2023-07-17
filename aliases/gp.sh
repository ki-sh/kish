#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="gp"
cmd="git push"
applicable=".git"

if [ "$1" = '-h' ]; then
    echo "push ( $cmd ) shortcut script ~/.kish/n.sh" &&
        echo 'first param optional: relative directory to run git operation on.' &&
        exit
fi

ki-spread "$@"
klog "$cmd $*"
