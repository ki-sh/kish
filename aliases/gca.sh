#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="gca"
cmd="git commit --amend --no-edit"
applicable=".git"

[ "$1" = '-h' ] &&
    echo "gca ( $cmd ) shortcut script ~/.kish/gca.sh" &&
    echo 'first param optional: relative directory to run git operation on.' &&
    exit

ki-spread "$@"
klog "$cmd $*"
