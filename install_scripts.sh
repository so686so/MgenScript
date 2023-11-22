
function _get_more_recent_edit_file_() { # determine which of two files was most recently modified
    local _file_1=$1
    local _file_2=$2

    if [[ -e "$_file_1" && -e "$_file_2" ]]; then
        # Get the modification time in seconds since the epoch for each file
        local _time_1=$(stat -c %Y "$_file_1")
        local time_2=$(stat -c %Y "$_file_2")

        # Compare modification times
        if   [[ "$_time_1" -gt "$time_2" ]]; then echo "$_file_1"
        elif [[ "$_time_1" -lt "$time_2" ]]; then echo "$_file_2"
        else echo "$_file_1"
        fi
    fi
}

# =====================================================================================================================

# Check sudo
if [ $EUID -ne 0 ]; then
    echo -e "[ERR] Please run this script with 'sudo'"
    exit
fi

curr_dir_path=$(pwd)
script_path=$(readlink -f "$0")

update_target_script_file="${script_path}/Scripts/.bash_aliases"
origin_target_script_file="${HOME}/.bash_aliases"
update_target_fzf_file="${script_path}/Extensions/fzf_mgen"

if [[ -e "${update_target_script_file}" ]]; then 
    recent_script="$( _get_more_recent_edit_file_ "${origin_target_script_file}" "${update_target_script_file}" )"
    if [[ "${recent_script}" == "${update_target_script_file}" ]]; then
        cp -a "${update_target_script_file}" "${HOME}"
	source ${HOME}/.bashrc
    fi
fi

if [[ -e "${update_target_fzf_file}" ]]; then
    cp -a "${update_target_fzf_file}" /usr/bin
fi

echo -e "=============================="
echo -e "[DONE] Install MgenScript Done"
echo -e "=============================="
cd ${curr_dir_path}
