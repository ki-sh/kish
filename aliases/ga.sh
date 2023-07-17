#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"

st="ga"
cmd="git add -v "
applicable=".git"

# might want a warning /dry run here.
# as can affect a lot of files.
# if gs .
# probably mean:
#  gs ./ .
# todo - retain other args @see itch.sh p1substitite

# [ "$1" = '.' ] && set  -- " ./ ."

if [ "$1" = '-h' ]; then
    echo "ga ( $cmd)" &&
        echo "shortcut script ~/.kish/ga.sh" &&
        echo "ga  adds . on dirs which are git initialised (have .git folder)"
    echo "dont add the extra dot yourself"
    exit
fi
klog "$cmd $*"
ki-spread "$@"
# show status after add:
$HOME/.kish/gs.sh "@"
