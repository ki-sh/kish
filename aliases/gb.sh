#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="gb"
cmd="git branch "
applicable=".git"

# todo: substite -l for --long  grr - nice to have.

if [ "$1" = '-h' ]; then
    printf "${IYel}"
    echo "$st ($cmd) filters: $applicable must be present in dirs."
    printf "${Whi}"
    echo "eg: $st . -currrent dir"
    echo "eg: $st myapp/. -only myapp"
    echo "eg: $st  -no params - all first level dirs that are git repos."
    echo "defaults to -s (short format) use --long to override."
    echo "using $st script at: ~/.kish/$st.sh)"
    exit
fi

ki-spread "$@"
klog "$cmd $*"