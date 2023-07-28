#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st='vta: volta - modern (2023) node version mgmt.'
cmd='volta'

if [ "$1" = -h ]; then
    "$command_name ( $command_execute)"
    exit
fi

# check if  npm install -g npm-check-updates installed,
# ask if want to install it if not.
if ! command -v volta &>/dev/null; then
    echo "volta could not be found"
    echo "install volta (curl https://get.volta.sh | bash ) y/n?"
    read -r install_npm
    if [ "$install_npm" == 'y' ] || [ "$install_npm" == 'Y' ]; then
        curl https://get.volta.sh | bash
        echo "volta should be installed now. try v again."
    else
        exit
    fi
fi

ki-spread "$@"
# echo ""
klog "$cmd $*"
