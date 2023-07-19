#!/bin/bash
source "$HOME/.kish/lib/ki.sh"
source "$HOME/.kish/lib/klog.sh"

cmd="show this generated help / kipower any command. "


ki "$@"
klog "$cmd $*"
