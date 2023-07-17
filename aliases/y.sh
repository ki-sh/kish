#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st="y"
cmd="yarn"
applicable="package.json"

if [ "$1" = '-h' ]; then
    printf "${IYel}"
    echo "$st ($cmd) filters: $applicable must be present in dirs."
    printf "${Whi}"
    # echo "eg: $st branch .    # git branch on currrent dir only. "
    #  echo "eg: $st branch myapp/. -only myapp. "
    echo "eg: $st start    -no location param - all first level dirs having a $applicable"

    echo "eg: $st ../myapp update  -this is fine, can ../ navigate."
    echo "eg: $st . start  -explicitly in the current directory only. "
    echo "eg: $st myapp/. start   -only in myapp (as long as has $applicable)"
    echo "using $st script at: ~/.kish/$st.sh) -edit in your fork and y kish/. update"
    exit
fi

ki-spread "$@"
klog "$cmd $*"
