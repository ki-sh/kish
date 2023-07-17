#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="gpu"
cmd="git push --set-upstream origin "
applicable=".git"

# todo check a branchname given : pushnew [pathspec] branchname

if [ "$1" = '-h' ]; then
    echo "git push upstream ( $cmd )"
    echo "Easy way to push a new branch, without having to type  --set-upstream origin."
    echo "just do $>gpu branchname "
    exit
fi

ki-spread "$@"
klog "$cmd $*"
