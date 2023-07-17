#!/bin/bash

# cmd for documentation only
cmd="Incept a vscode workspace file and filter on its directories for all ki commands."

if [[ -f ".kirc" ]]; then
    # set aw to $2 if it exists.
    if [[ -f "$1" ]]; then
        echo "active_workspace=$1" >.strc
        echo "st workspace filter set to $1"
        code "$1"
    else
        echo "not found. useage: kiwi vscode-workspace-file"
        echo "To turn off workspace filtering use: kiwix"
    fi
else
    echo 'no .strc settings file found in current dir.'
fi
exit
