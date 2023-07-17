#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="gco"
cmd="git checkout -b "
applicable=".git"

[ "$1" = '-h' ] &&
    echo "gco ( $cmd)" &&
    echo "shortcut script ~/.kish/gco.sh" &&
    exit

[ $# -eq 0 ] || [ "$1" == "-m" ] &&
    echo "Usage:" &&
    echo "gco feature/someexample [generates: git checkout -b feature/someexample] ( Note no -b needed ) 12 chars saved!" &&
    echo "gco path/ branchname [generates: git checkout -b path branchname]" &&
    exit

ki-spread "$@"
klog "$cmd $*"
