#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="l"
cmd="ls -1 --color"
applicable="any"
# inapplicable="node_modules etc todo"

if [ "$1" = '-h' ]; then
   echo 'l (ls short and colorful! (ls -1 --color) shortcut script ~/.kish/l.sh)' &&
      echo 'warning: filtered only to dirs that have $applicable'
   exit
fi


ki-spread "$@"
klog "$cmd $*"
