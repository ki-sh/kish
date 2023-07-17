#!/bin/bash
# cd "$(dirname "$0")"
# source ./lib/actions.sh
# source ./lib/colors.sh

source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="gc"
cmd="git commit -m "
applicable=".git"

#
# [ "$1" = '.' ] && set  -- " ./ ."
# "commit message" getting broken up. leading to :
# error: pathspec '123' did not match any file(s) known to git

if [ "$1" = '-h' ]; then
    printf "${IYel}"
    echo "$st ($cmd) filters: $applicable must be present in dirs."
    printf "${Whi}"
    # echo "eg: $st branch .    # git branch on currrent dir only. "
    #  echo "eg: $st branch myapp/. -only myapp. "
    echo "gc - git commit."
    echo "no need for quotes. saves SHIFT-' twice. :)"
    echo "examples:"
    echo "gc issue #39 spondiknik wooferdoofer97"
    echo "#specific dir example:"
    echo "gc apps/acme/. issue #39 spondiknik wooferdoofer97"

    exit
fi

ki-spread "$@"
klog "$cmd $*"