#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="g"
cmd="git"
applicable=""

if [ "$1" = '-h' ]; then
    printf "${IYel}"
    echo "$st ($cmd) filters: $applicable must be present in dirs."
    printf "${Whi}"
    # echo "eg: $st branch .    # git branch on currrent dir only. "
    #  echo "eg: $st branch myapp/. -only myapp. "
    echo "eg: $st branch -no location param - all first level dirs that are git repos."
    echo "using $st script at: ~/.kish/$st.sh)"
    exit
fi


ki-spread "$@"
klog "$cmd $*"