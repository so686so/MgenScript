#!/bin/bash

# Check user
if [ $EUID -eq 0 ]; then
    echo -e "[ERR] Please run this script without 'sudo'"
    exit
fi

current_dir=$(pwd)
script_path=$(readlink -f "$0")

cd $(dirname ${script_path})

sudo cp -a "./Scripts/.bash_aliases" "${HOME}/"
source ${HOME}/.bash_aliases

sudo cp -a "./Extensions/fzf_mgen" /usr/bin

cd ${current_dir}

echo "=================="
echo "[DONE] Update Done"
echo "=================="
