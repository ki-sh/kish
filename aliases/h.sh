#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="h"
cmd="gh "
applicable=".git"
# for most like pr create : want allowable .git
#  maybe a preferable? to avoid slash dotting.
#  optionally - inspect the command to decide ie pr create -required,
#  create a new repo - not so much!

[ "$1" = '-h' ] &&
    echo "h ( $cmd ) shortcut script ~/.kish/h.sh" &&
    echo 'first param optional: relative directory to run git operation on.' &&
    exit

ki-spread "$@"
klog "$cmd $*"
