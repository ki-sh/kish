#!/bin/bash
source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"
source "$HOME/.kish/lib/colors.sh"

st='nup checks npm package dependencies'
cmd='npm-check-updates'

if [ "$1" = -h ]; then
    "$command_name ( $command_execute)"
    exit
fi

# check if  npm install -g npm-check-updates installed,
# ask if want to install it if not.
if ! command -v npm-check-updates &>/dev/null; then
    echo "npm-check-updates  could not be found"
    echo "install npm-check-updates (npm i -g npm-check-updates ) y/n?"
    read -r install_npm
    if [ "$install_npm" == 'y' ] || [ "$install_npm" == 'Y' ]; then
        npm i -g npm-check-updates
        echo "installed npm-check-updates"
    else
        exit
    fi
fi

ki-spread "$@"
echo "Please ignore 'ncu -u', you can use 'n i dir(s)'"
klog "$cmd $*"
