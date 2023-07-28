#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

# cmd='kgrep recursivly search: dir string '
# grep -rn 'apps' -e 'acme' --exclude-dir={.git,node_modules}
# dir=$1
# shift
cmd="grep -rn $1 -e \"$2\"  --color --exclude-dir=.git --exclude-dir=node_modules"
# cmd='grep -rnw "$1" -e "$2"'
 
if [ "$1" = -h ]; then
echo "kgrep {path to search in} {pattern}  "
 exit
fi

# ki-spread "$@"
echo "${YELLOW}cmd: $cmd ${NORMAL}"

eval "$cmd"

klog "$cmd $*"
