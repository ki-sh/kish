#!/bin/bash
# shopt -s expand_aliases
# source "$HOME/.kish/aliases.sh"
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="y"
cmd="yarn run"
applicable="package.json"

if [ "$1" = '-h' ]; then
    printf "${IYel}"
    echo "yarn run dir(s)  dir(s)/files any_other_command_args_not_files_or_dirs"
    printf "${Whi}"
    exit
fi

ki-spread "$@"
klog "$cmd $*"
