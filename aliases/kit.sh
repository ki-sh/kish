#!/usr/bin/env bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"

st="kit"
cmd="ki minimalist test runner "


if [ "$1" == "-h" ]; then
    cat "$HOME/.kish/lib/kit.help.txt"
    exit
fi 
# if %1 exists (folder/glob)  ;then
#  else
# cd $KISHDIR/aliases
#  fi

# $KISHCOREDIR/src/lib/kit.sh "$@"

cmd="$KISHCOREDIR/src/lib/kit.sh"
ki-spread "$@"
klog "$cmd $*"
