#/bin/bash
# =====================================================================================================================

# Check sudo
if [ $EUID -ne 0 ]; then
    echo -e "[ERR] Please run this script with 'sudo'"
    exit
fi

curr_dir_path=$(pwd)
script_path=$(readlink -f "$0")
script_dir_path=$(dirname "${script_path}")

update_target_script_file="${script_path}/Scripts/.bash_aliases"
update_target_fzf_file="${script_path}/Extensions/fzf_mgen"

if [[ -e "${update_target_script_file}" ]]; then 
    cp -a "${update_target_script_file}" "${HOME}"
    source ${HOME}/.bashrc
fi

if [[ -e "${update_target_fzf_file}" ]]; then
    cp -a "${update_target_fzf_file}" /usr/bin
fi

cd ${HOME}
mv ${script_dir_path} ${HOME}/.MgenScript

echo -e "=============================="
echo -e "[DONE] Install MgenScript Done"
echo -e "=============================="
cd ${curr_dir_path}
