#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"

st="kdry"
cmd="see dry run output for any ki-spread command. "

 if [ $# -eq 0 ]; then
 echo "error - no params"
 echo "usage: kdry cmd options"
 exit
 fi

# aliases only work in 'interactive mode.' so call fn directly
cmd=$1
shift #remove first param (cmd)

echo "${YELLOW}Ki Dry run (kdry cmd params) ${NORMAL}"
ki_spread_dry "$@"

