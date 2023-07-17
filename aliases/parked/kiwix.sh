#!/bin/bash

# cmd for documentation only
cmd="Unsets active workspace filter for all commands."

if [[ -e ".kirc" ]]; then
    echo "active_workspace=nooperation" >.strc
    echo "ki workspace filter unset."
fi
