#!/bin/bash

current_dir=$(pwd)
script_path=$(readlink -f "$0")

cd $(dirname ${script_path})

sudo cp -a "./Scripts/.bash_aliases" "${HOME}"
sudo source ${HOME}/.bash_aliases

sudo cp -a "./Extensions/fzf_mgen" /usr/bin

cd ${current_dir}

echo "=================="
echo "[DONE] Update Done"
echo "=================="
