#!/bin/bash
# ================================================================= #
#                  ╔╦╗┌─┐┌─┐┌┐┌   ╔═╗┌─┐┬─┐┬┌─┐┌┬┐                  #
#                  ║║║│ ┬├┤ │││   ╚═╗│  ├┬┘│├─┘ │                   #
#                  ╩ ╩└─┘└─┘┘└┘───╚═╝└─┘┴└─┴┴   ┴                   #
# ----------------------------------------------------------------- #
# * This file is shell script bundle for 'MgenSolutions'            #
# ----------------------------------------------------------------- #
# * Version     : 1.0.0                                             #
# * Last Update : 23-11-27                                          #
# * Author      : So Byung Jun                                      #
# ================================================================= #
GitAddress="https://github.com/so686so/MgenScript.git"              #
# ================================================================= #


# ================================================================= #
# Global Define : ACCOUNT
# ================================================================= #
USER_ID=$(whoami)
USER_PW=
# ================================================================= #


# ================================================================= #
# Global Define : ENVIRONMENT
# ================================================================= #
SCRIPT_BASE_DIR="${HOME}/MgenScript"
SCRIPT_ABS_PATH="${HOME}/.bash_aliases"
SCRIPT_FILENAME=$( basename "${SCRIPT_ABS_PATH}" )
SCRIPT_DIR_NAME=$( dirname  "${SCRIPT_ABS_PATH}" )
# ----------------------------------------------------------------- #
DEFAULT_DOCKER=raid
# ----------------------------------------------------------------- #
PROCESS_SEARCH_APP_LIST=("UVES" "RAID" "glances" "nvtop")
PROCESS_SEARCH_KEY_LIST=("mono" "node" "PID")
PROCESS_SEARCH_EXT_LIST=("\.sh$" "\.exe$" "\.py$" "\.js$")
PROCESS_IGRNOE_KEY_LIST=("grep" "vi" "vscode" "${SCRIPT_FILENAME}" "rabbitmq" "mysqld")
# ----------------------------------------------------------------- #
DRAW_LINE_MAX_LEN=100
# ----------------------------------------------------------------- #
FZF_SETTINGS="--height 50% --reverse --cycle \
              --bind=ctrl-space:preview-page-down"
# ----------------------------------------------------------------- #
USE_256_COLORS=Y
# ----------------------------------------------------------------- #
ESC=$'\033'
# ----------------------------------------------------------------- #
EVENT_KEYPUT=33
EVENT_SIGINT=130
# ----------------------------------------------------------------- #
ERROR_SETOPT=50
ERROR_PASSWD=51
ERROR_GET_SU=52
ERROR_INSTALL=53
ERROR_NO_FZF=54
# ================================================================= #


# ================================================================= #
# Global Define : COLORS
# ================================================================= #
# color functions
_clr_()     { echo $ESC'['$1'm'; }
_clr_256_() { echo $ESC'[38;5;'$1'm'; }
# ----------------------------------------------------------------- #
# 8-bit colors
cRST=`_clr_ 00`; cBLD=`_clr_ 01`; cDIM=`_clr_ 02`; 
cLNE=`_clr_ 04`;
cBLK=`_clr_ 30`; cRED=`_clr_ 31`; cGRN=`_clr_ 32`; 
cYLW=`_clr_ 33`; cBLU=`_clr_ 34`; cMGT=`_clr_ 35`; 
cSKY=`_clr_ 36`; cWHT=`_clr_ 37`
bBLK=`_clr_ 40`; bRED=`_clr_ 41`; bGRN=`_clr_ 42`; 
bYLW=`_clr_ 43`; bBLU=`_clr_ 44`; bMGT=`_clr_ 45`; 
bSKY=`_clr_ 46`; bWHT=`_clr_ 47`
cGRY=`_clr_ 90`; cB_R=`_clr_ 91`; cB_Y=`_clr_ 93`
cB_B=`_clr_ 94`; cB_W=`_clr_ 97`
# ----------------------------------------------------------------- #
# 256-bit colors
if [[ "${USE_256_COLORS}" = "Y" ]]; then
c256_GRN_00=`_clr_256_ 82`; c256_GRN_01=`_clr_256_ 84`
c256_BLU_00=`_clr_256_ 75`; c256_BLU_01=`_clr_256_ 69`
c256_PUP_00=`_clr_256_ 189`
# ----------------------------------------------------------------- #
# 'MgenSolutions' Logo colors
cLOGO_00="${c256_GRN_00}"; cLOGO_01="${c256_GRN_01}"
cLOGO_02="${c256_BLU_00}"; cLOGO_03="${c256_BLU_01}"
cLOGO_04="${c256_PUP_00}"
else
unset cLOGO_00; unset cLOGO_01
unset cLOGO_02; unset cLOGO_03
unset cLOGO_04
fi
# ================================================================= #


# ================================================================= #
# Global Define : LOG PREFIX & SUFFIX
# ================================================================= #
RUN="${cBLD}[ ${cGRN}RUN${cRST} ${cBLD}]${cRST}"
TRY="${cBLD}[ ${cYLW}TRY${cRST} ${cBLD}]${cRST}"
SET="${cBLD}[ ${cBLU}SET${cRST} ${cBLD}]${cRST}"
ERR="${cBLD}[ ${cRED}ERR${cRST} ${cBLD}]${cRST}"
FIN="${cBLD}[ ${cSKY}FIN${cRST} ${cBLD}]${cRST}"
# ================================================================= #


# ================================================================= #
# Only Internal Use Function ( '__func()' name formatting )
# ================================================================= #
function __show_logo() { # Print Mgensolutions logo
    echo -e "   ╔╦╗┌─┐┌─┐┌┐┌  ╔═╗┌─┐┬─┐┬┌─┐┌┬┐"
    echo -e "   ║║║│ ┬├┤ │││  ╚═╗│  ├┬┘│├─┘ │ "
    echo -e "   ╩ ╩└─┘└─┘┘└┘──╚═╝└─┘┴└─┴┴   ┴ "
}

function __show_co_logo_colorful() { # show 'MGEN_Solutions' logo colorful
    if [[ -n "$1" ]]; then echo -e; fi
    echo -e " ${cLOGO_00}╔${cLOGO_01}╦${cLOGO_02}╗╔${cLOGO_03}═╗╔═╗╔╗╔  ╔═╗┌─┐┬  ┬ ┬┌┬┐┬┌─┐┌┐┌┌─┐${cLOGO_04}  (주)엠젠솔루션 ${cRST}"
    echo -e " ${cLOGO_00}║${cLOGO_01}║${cLOGO_02}║║${cLOGO_03} ╦║╣ ║║║  ╚═╗│ ││  │ │ │ ││ ││││└─┐${cLOGO_04}   AI BigData Research Institute ${cRST}"
    echo -e " ${cLOGO_00}╩${cLOGO_01} ${cLOGO_02}╩╚${cLOGO_03}═╝╚═╝╝╚╝──╚═╝└─┘┴─┘└─┘ ┴ ┴└─┘┘└┘└─┘${cLOGO_04}   www.mgensolutions.kr ${cRST}"
    if [[ -n "$1" ]]; then echo -e; fi
}

function __get_console_w() { # Get current console width
    echo -e $(stty size | cut -d ' ' -f 2)
}

function __get_console_h() { # Get current console height
    echo -e $(stty size | cut -d ' ' -f 1)
}

function __get_option_line_num() { # Get target options line number in this script file
    # It only works argument count 1 ( target option key )
    if [[ $# -eq 1 && -e "${SCRIPT_ABS_PATH}" ]]; then
        # Get target options line text
        local _target_opt=$(cat ${SCRIPT_ABS_PATH} | grep -na "^$1=")
        # If option search success ( grep result exists )
        if [[ -n "${_target_opt}" ]]; then
            echo -e "${_target_opt}" | awk -F ':' '{print $1}'
            return 0
        else
            return $ERROR_SETOPT
        fi
    fi
    return $ERROR_SETOPT
}

function __set_option() { # Set option in this script
    # Check Arg count
    if [[ $# -ne 2 ]]; then
        echo -e "${ERR} __set_option <option name> <option value>"
        return
    fi

    # Check Exist Option
    local _target_line=$(__get_option_line_num $1)
    if [[ $_target_line -eq 0 ]]; then
        return
    fi

    # Change Option
    sed -i "${_target_line}s/.*/$1=$2/g" ${SCRIPT_ABS_PATH}
    source "${SCRIPT_ABS_PATH}" > /dev/null
}

function __is_run_target_process() { # Check target process is running
    if [[ $# -ne 1 ]]; then
        echo -e "False"
        return
    fi

    if [[ $(sudo ps aux | grep "$1" | grep -v grep | wc -l) -gt 0 ]]
    then echo -e "True"
    else echo -e "False"
    fi
}

function __check_installed_package() { # check target package installed
	$1 --version &>/dev/null
}

function __check_git_remote_url_reachable() { # Returns 0 if $1 is a reachable git remote url
    __check_installed_package "git" && git ls-remote "$GitAddress" CHECK_GIT_REMOTE_URL_REACHABILITY >/dev/null 2>&1
}

function __password_check() { # When initialize script & run command, check password is valid and save
    # get saved pw value
    local _p_in=${USER_PW}

    # Check Part
    if [[ -n $_p_in ]]; then
        # use command require sudo
        echo "$_p_in" | sudo -S grep ${USER_ID} /etc/shadow > /dev/null 2>&1
        local _ret_val=$?
        # is success?
        if   [[ $_ret_val -eq 0 ]]; then
            return 0
        elif [[ $_ret_val -gt 0 && "$1" = "CHECK_ONCE" ]]; then
            return $ERROR_PASSWD
        fi
    fi

    # If password wrong, Correction password
    while [ true ];
    do
        # Get new password input
        echo -en "${TRY} Please input password ( Current registered : $_p_in ) => "
        read -s _p_in
        echo -e

        # Check Repeat
        echo "$_p_in" | sudo -S grep ${USER_ID} /etc/shadow > /dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            # If check pass, save password this script
            __set_option USER_PW $_p_in
            return 0
        fi
    done
}

function __get_keystroke_direct() { # Get keystroke direct
    # read keys each byte
    read -s -n 1        _key_0 > /dev/null; if [[ "$_key_0" = $ESC ]]; then
    read -s -n 1 -t 0.1 _key_1 > /dev/null; if [[ "$_key_1" = "["  ]]; then
    read -s -n 1 -t 0.1 _key_2 > /dev/null; 

    case "$_key_2" in
    A) echo "UP"    ;;
    B) echo "DOWN"  ;;
    C) echo "RIGHT" ;;
    D) echo "LEFT"  ;;
    *) echo "UNKN"  ;;
    esac;

    else echo -e "$_key_1"; return $EVENT_KEYPUT; fi;
    else echo -e "$_key_0"; return $EVENT_KEYPUT; fi
}

function __check_selected() { # Visualize selected menu
    if [[ $1 = $2 ]];
    then echo -e "${cRST}${cSKY} > ${bWHT}${cBLK}"
    else echo -e "${cRST}   "
    fi
}

function __restore_stty() { # cursor blink on & activate echo
    # cursor blink on
    printf "$ESC[?25h";
    # if input, print console
    stty echo
    # comeback setting SIGINT
    trap -- SIGINT
}

function __stop_stty() { # cursor blink off & disable echo
    # cursor blink off
    printf "$ESC[?25l";
    # if input, print ignore
    stty -echo
    # if SIGINT, restore stty settings
    trap __restore_stty SIGINT
}

function __remove_ascii_escape_words() { # remove for example, ${cRST}
    sed 's/\x1[bB]\[[0-9;]*m//g' | sed "s/$ESC\[[0-9;]*m//g"
}

function __draw_line() { # draw seperator line
    local _line_word="-"
    local _line_expl=""

    # Get line word option setting : Default "-"
    if [[ $# -ge 1 ]]; then
        local _arg_first="$1"
        # If first argument length > 1, it set as 'explain'
        if [[ ${#_arg_first} -gt 1 ]]; then
            _line_expl=" [ $_arg_first ] "
        # else, it set as 'line word'
        else
            _line_word="$_arg_first"
        fi
    fi
    if [[ $# -eq 2 ]]; then
        _line_expl=" [ $2 ] "
    fi

    # Check draw line limit
    local _total_line_len=$( __get_console_w )
    if [[ $_total_line_len -ge $DRAW_LINE_MAX_LEN ]]; then
        _total_line_len=$DRAW_LINE_MAX_LEN
    fi

    # Adjust draw line length
    local _line_expl_len=${#_line_expl}
    local _line_len=$(( $_total_line_len - $_line_expl_len ))

    # Make draw line
    local _full_line=""
    for i in $( seq $_line_len ); do
        _full_line="${_full_line}${_line_word}"
    done

    # draw
    echo -e "${_full_line}${_line_expl}"
}

function __select_menu() { # select index given menu using '__get_keystroke_direct'
    # for draw
    local _min_menu=1;
    local _max_menu=$#;

    # for select
    local _selected=1;
    local _key_inpt="";

    # for print
    local _max_str_len=$DRAW_LINE_MAX_LEN
    local _current_csw=$(__get_console_w)
    local _elipsis_len=5

    # Line skipping correction
    if [[ $_max_str_len -gt ${_current_csw} ]]; then
        _max_str_len=$(( ${_current_csw} - ${_elipsis_len} ))
    fi
    
    # cursor blink off & disable echo
    __stop_stty

    __draw_line = 
    while [[ true ]]; 
    do
        for (( i=1; i<=$#; i++ )); do
            local _line=${!i}
            if [[ ${#_line} -ge $_max_str_len ]]; then
                local _len=$(( ${_max_str_len} - ${_elipsis_len} ))
                printf "$ESC[2K$(__check_selected $i $_selected) %.${_len}s... ${cRST}\r\n" "${!i}";
            else
                printf "$ESC[2K$(__check_selected $i $_selected) %s ${cRST}\r\n" "${!i}";
            fi
        done

        __draw_line -
        printf "$ESC[2K * Use ${cB_Y}Arrow key${cRST} to select and input '${cB_B}Enter${cRST}' to select, Cancel '${cB_R}Ctrl+C${cRST}'\n";
        __draw_line =

        # Wait Key Input
        _key_inpt=$(__get_keystroke_direct);
        local _ret_val=$?

        # Enter key input
        if   [[ $_ret_val -eq $EVENT_SIGINT ]]
        then __restore_stty; return $EVENT_SIGINT
        elif [[ $_ret_val -eq $EVENT_KEYPUT ]]
        then break
        fi
        
        # Check input key
        if   [[ $_key_inpt = "UP"   || $_key_inpt = "LEFT"  ]];
        then _selected=$( expr $_selected - 1 );
        elif [[ $_key_inpt = "DOWN" || $_key_inpt = "RIGHT" ]];
        then _selected=$( expr $_selected + 1 );
        fi
        
        # correction if overflow
        if   [[ $_selected -lt $_min_menu ]];
        then _selected=${_max_menu};
        elif [[ $_selected -gt $_max_menu ]];
        then _selected=${_min_menu};
        fi
        
        # move cursor pointer upper
        printf "$ESC[$( expr $# + 3 )A";
    done

    # cursor blink on & activate echo
    __restore_stty

    # return selected index => It can get out scope '$?'
    return `expr ${_selected} - 1`;
}

function __get_all_register_container_name() { # Get all container name
    # check saved password exists
    if [[ ! -n "${USER_PW}" ]]; then
        echo -e " "; return $ERROR_GET_SU
    fi
    # check password valid
    if ! __password_check "CHECK_ONCE"; then
        echo -e " "; return $ERROR_GET_SU
    fi

    echo ${USER_PW} | sudo -S true
    local _container_list=$(sudo docker ps -a --format 'table {{.Names}}' | awk 'NR > 1 {printf "%s ", $1}')
    echo -e "${_container_list}"
    return 0
}

function __is_valid_registered_container_name() { # check vaild container name
    sudo docker ps -a --format 'table {{.Names}}' | grep "^$1$" > /dev/null
}

function __select_docker_container() { # Select one of the currently created containers
    local _select_container=""
    local _continaer_log_file_name_prev="${SCRIPT_DIR_NAME}/.current_continaer_for_mgen_script_non_sort.log"
    local _continaer_log_file_name_goal="${SCRIPT_DIR_NAME}/.current_continaer_for_mgen_script.log"

    if __is_valid_registered_container_name $1
    then
        _select_container=$1
    else
        if [[ -n $1 ]]; then
            echo -e "${ERR} ${cSKY}$1${cRST} is not valid docker container name, you can select :"
        fi

        # Get currently created container containes current stopped
        sudo docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}' | \
            awk 'NR > 1 {printf "%-20s %-30s", $1, $2; for (i=3; i<=NF; i++) printf "%s ", $i; printf "\n" }' \
            > ${_continaer_log_file_name_prev}

        # Sort :: Current activated conatiners higher
        {
            grep    "Up" ${_continaer_log_file_name_prev} | sort
            grep -v "Up" ${_continaer_log_file_name_prev}
        } > ${_continaer_log_file_name_goal}

        # Make List for '__select_menu'
        local _container_list=()
        while read line; do
            _container_list+=("$(echo -e "$line")")
        done < $_continaer_log_file_name_goal

        # remove used files
        sudo rm $_continaer_log_file_name_prev
        sudo rm $_continaer_log_file_name_goal

        # select one container
        __select_menu "${_container_list[@]}" 
        local _ret_val=$?

        # check SIGINT
        if [[ $_ret_val -eq $EVENT_SIGINT ]]; then
            echo -e "${SET} You press '${cB_R}Ctrl+C${cRST}', script cancled."
            return $EVENT_SIGINT
        fi

        # It returns 'container_name image_name status'
        _select_container=$(echo ${_container_list[${_ret_val}]} | awk '{print $1}')
    fi

    local _is_start_container=$(sudo docker ps --format 'table {{.Names}}' | grep ^${_select_container}$)
    # Check select container activated
    if [[ ! -n ${_is_start_container} ]]; then
        echo -en "${TRY} Conatiner ${cSKY}${_select_container}${cRST} Not Started, start ... "
        sudo docker start ${_select_container}
    fi

    # change 'DEFAULT_DOCKER'
    __set_option DEFAULT_DOCKER ${_select_container}
}

function __get_more_recent_edit_file() { # determine which of two files was most recently modified
    local _file_1=$1
    local _file_2=$2

    if [[ -e "$_file_1" && -e "$_file_2" ]]; then
        # Get the modification time in seconds since the epoch for each file
        local _time_1=$(stat -c %Y "$_file_1")
        local _time_2=$(stat -c %Y "$_file_2")

        # Compare modification times
        if   [[ "$_time_1" -gt "$_time_2" ]]; then echo "$_file_1"
        elif [[ "$_time_1" -lt "$_time_2" ]]; then echo "$_file_2"
        else echo "$_file_1"
        fi
    else
        echo "FILE_NONE"
    fi
}

function __show_process_list() { # Show Filter Process list
    local _search_words=""
    local _ignore_words="-v -w"

    # Add search words from 'PROCESS_SEARCH_APP_LIST'
    for eachWord in ${PROCESS_SEARCH_APP_LIST[@]}; do
        _search_words="${_search_words} -e ${eachWord}"
    done

    # Add search words from 'PROCESS_SEARCH_KEY_LIST'
    for eachWord in ${PROCESS_SEARCH_KEY_LIST[@]}; do
        _search_words="${_search_words} -e ${eachWord}"
    done

    # Add search words from 'PROCESS_SEARCH_EXT_LIST'
    for eachWord in ${PROCESS_SEARCH_EXT_LIST[@]}; do
        _search_words="${_search_words} -e ${eachWord}"
    done

    # Add ignore words from 
    for eachWord in ${PROCESS_IGRNOE_KEY_LIST[@]}; do
        _ignore_words="${_ignore_words} -e ${eachWord}"
    done

    # get cpu core for devide %cpu
    local _cpu_core=$(cat /proc/cpuinfo | grep -c processor 2>/dev/null)

    # Get processes
    local _output=$(ps -aux | grep ${_search_words} | grep ${_ignore_words})

    # Print Title
    echo -en "${cB_B}"
    echo -e "${_output}" | awk 'NR < 2 {printf"   %-14s %-8s %-8s ", $2, $3, $4; for (i=11; i<=NF; i++) printf "%s ", $i; printf "\n"}'
    echo -en "${cRST}"

    # Print Details
    if expr "$_cpu_core" + 0 > /dev/null; then
        echo -e "${_output}" | __remove_ascii_escape_words | \
        awk -v SPLIT="$_cpu_core" 'NR > 1 {printf"   %-14s %-8.2f %-8.2f ", $2, $3 / SPLIT, $4; for (i=11; i<=NF; i++) printf "%s ", $i; printf "\n"}'
    else
        echo -e "${_output}" | __remove_ascii_escape_words | \
        awk 'NR > 1 {printf"   %-14s %-8.2f %-8.2f ", $2, $3, $4; for (i=11; i<=NF; i++) printf "%s ", $i; printf "\n"}'
    fi
}

function __simplify_shell_login() { # hide shell login (motd)
    __password_check && echo ${USER_PW} | sudo -S true
    if [[ -d /etc/update-motd.d ]]; then
        sudo chmod -x /etc/update-motd.d/*
        __show_co_logo_colorful "SAPCE" | sudo tee /etc/motd > /dev/null
    fi
}

function __install_mgen_script() { # install mgenScript files & extensions
    if [[ ! -d "${SCRIPT_BASE_DIR}/Scripts" ]]; then
        echo -e "${ERR} Install failed => \"${cSKY}${SCRIPT_BASE_DIR}/Scripts${cRST}\" directory not exists"
        return $ERROR_INSTALL
    fi

    local _password=${USER_PW}
    local _updated_file="${SCRIPT_BASE_DIR}/Scripts/.bash_aliases"
    local _check_recent="$(__get_more_recent_edit_file "${SCRIPT_ABS_PATH}" "${_updated_file}")"

    # CHECK :: .bash_aliases
    if [[ "${_check_recent}" = "${_updated_file}" ]]; then
        echo -e "${RUN} INSTALL :: ${_updated_file} -> ${SCRIPT_ABS_PATH}"
        sudo cp -a "${_updated_file}" "${HOME}"
        source ${SCRIPT_ABS_PATH} > /dev/null
    fi

    # CHECK :: .bash_completion
    local _completion_file="${SCRIPT_BASE_DIR}/Scripts/.bash_completion"
    if [[ -e "${_completion_file}" ]]; then
        echo -e "${RUN} INSTALL :: ${_completion_file} -> ${HOME}/.bash_completion"
        sudo cp -a "${_completion_file}" "${HOME}"
    fi

    local _fzf_install_path="/usr/bin"
    local _fzf_mg_file_path="${SCRIPT_BASE_DIR}/Extensions"

    # CHECK :: fzf_mgen
    if [[ -d "${_fzf_mg_file_path}" ]]; then
        if [[ -e "${_fzf_mg_file_path}/fzf_mgen" && ! -e "${_fzf_install_path}/fzf_mgen" ]]; then
            echo -e "${RUN} INSTALL :: ${_fzf_mg_file_path}/fzf_mgen -> ${_fzf_install_path}"
            sudo cp -a "${_fzf_mg_file_path}/fzf_mgen" "${_fzf_install_path}"
        fi
    fi

    # backup origin passwd
    __set_option USER_PW "${_password}"
    # renewal shell login prompt
    __simplify_shell_login
    # apply update
    source ${SCRIPT_ABS_PATH} > /dev/null
}

function __upload_script_to_git() { # upload to git
    local _cur_dir=$(pwd)

    if __check_git_remote_url_reachable; then
        # Check directory
        if [[ ! -d "${SCRIPT_BASE_DIR}" ]]; then
            echo -e "${ERR} Upload failed => \"${cSKY}${SCRIPT_BASE_DIR}${cRST}\" directory not exists"
            return 1
        fi

        local _ssh_key_file="${SCRIPT_BASE_DIR}/.git_ssh_key"
        # Check ssh gen token
        if [[ ! -e "${_ssh_key_file}" ]]; then
            echo -e "${ERR} Git Access Token not exist..."
            return 1
        fi

        cd ${SCRIPT_BASE_DIR}
        local _token="$(cat ${_ssh_key_file})"
        local _remote_url=$(git remote get-url origin)

        __password_check && echo ${USER_PW} | sudo -S true

        # 토큰을 사용하는지 확인
        if [[ "$_remote_url" = *"$_token"* ]]; then
            echo -e "${SET} Remote URL already contains a token."
        else
            # GitHub 사용자 이름과 액세스 토큰
            local _github_username="so686so"
            local _github_token="${_token}"

            # 새로운 토큰을 추가한 URL로 변경
            local _new_remote_url=$(echo "$_remote_url" | sed "s/https:\/\/.*github.com/https:\/\/$_github_username:$_github_token@github.com/")

            # 변경된 URL을 Git에 적용
            sudo git remote set-url origin $_new_remote_url

            echo -e "${SET} Remote URL updated with the token."
        fi

        echo -en "${SET} Commit Message : "
        read _commit_message

        sudo git commit -am "${_commit_message}"
        sudo git push

        echo -e "${FIN} Upload done"
    else
        echo -e "${ERR} Git unreachable..."
    fi
}

# ================================================================= #
# Script Aliases Functions ( 'MGEN_func()' name formatting )
# ================================================================= #
function MGEN_show_script_summary() { # Show Total Script Aliases
    local _summary=$( cat  ${SCRIPT_ABS_PATH}       | \
                      grep "functio[nN]"            | \
                      sed  "s/functio[nN].*() {//g" | \
                      sed  "s/\[/\[ \\${cSKY}/g"    | \
                      sed  "s/\]/\\${cRST} \] :/g"  | \
                      grep "\["                     | \
                      awk  -F "#" '{printf("%s\\n", $2)}' )

    __draw_line '~' SUMMARY; echo -en "${_summary}" | awk -F':' '{printf "%-27s %s\n", $1, $2}'
    __draw_line '~'        ; echo -en " # ${cLNE}${cB_Y}Usage${cRST} ==> 'mgen ${cSKY}{COMMAND}${cRST} <args...>'\n"
    __draw_line '~'
}

function MGEN_show_current_status() { # [. | stat] Show current run docker container / storage / process

    echo ${USER_PW} | sudo -S clear
    
    __draw_line =
    __show_co_logo_colorful

    # buffer for get command result
    local _cmd_out=""

    __draw_line - DOCKER
    if [[ $(__get_console_w) -ge ${DRAW_LINE_MAX_LEN} ]]; then
        _cmd_out=$(sudo docker ps -a --format \
        'table \b   {{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}' 2>/dev/null)
    else
        _cmd_out=$(sudo docker ps -a --format \
        'table \b   {{.Names}}\t{{.Image}}\t{{.Status}}' 2>/dev/null)
    fi
    if [[ $? -eq 0 ]]; then
        if [[ ! -n ${_cmd_out} ]]; then
            echo -e "${ERR} Get Docker Status Failed"
        else
            # Title
            echo -e "${cB_B}${_cmd_out}${cRST}" | head -1
            # Activated Container
            echo -e "${_cmd_out}"           | \
                grep Up                     | \
                sed  "s/^/${cWHT}${cBLD}/g" | \
                sed  "s/$/${cRST}/g"        | \
                sed  "s/   ${DEFAULT_DOCKER} / ${cGRN}>${cWHT} ${DEFAULT_DOCKER} /" | \
                sed  "s/Up/${cWHT}${cLNE}Up/g" | \
                awk  '{printf "%s\n", $0}'
            # Non-Activated
            echo -e "${_cmd_out}"           | \
                grep Exited                 | \
                sed  "s/^/${cWHT}${cDIM}/g" | \
                sed  "s/$/${cRST}/g"        | \
                sed  "s/   ${DEFAULT_DOCKER} / ${cRED}>${cWHT}${cDIM} ${DEFAULT_DOCKER} /" | \
                awk  '{printf "%s\n", $0}'
        fi
    fi

    __draw_line - STORAGE
    _cmd_out=$(df -h | awk '{printf "%-14s %-8s %-8s %-8s %-8s ", $1, $2, $3, $4, $5; for (i=6; i<=NF; i++) printf "%s ", $i; printf "\n"}')
    echo -e "   ${cB_B}${_cmd_out}" | head -1 && echo -en "${cRST}"
    echo -e "   ${_cmd_out}" | sort -rh -k3 | grep [0-9][GT] | grep -v "grep" | awk -F"#" '{print "   " $1}'

    __draw_line - PROCESS
    __show_process_list
    __draw_line =
}

function MGEN_check_n_kill() { # [kill] Show current processes & kill target
    local _find_pid=$1
    local _find_str=$1

    # None input search word
    if [[ $# -eq 0 ]]; then
        local _processes_log_file_name="${SCRIPT_DIR_NAME}/.current_process_list_for_mgen_script.log"
        local _full_log_list=()

        if [[ $(__show_process_list | wc -l) -lt 2 ]]; then
            __draw_line 
            echo -e "${RUN} There are NO target programs"
            __draw_line
            echo -en " APPS | "; echo -e "${PROCESS_SEARCH_APP_LIST[@]}" | awk '{for (i=1; i<=NF; i++) printf"<%s> ", $i; printf "\n"}'
            echo -en " KEYS | "; echo -e "${PROCESS_SEARCH_KEY_LIST[@]}" | awk '{for (i=1; i<=NF; i++) printf"<%s> ", $i; printf "\n"}'
            echo -en " EXTS | "; echo -e "${PROCESS_SEARCH_EXT_LIST[@]}" | awk '{for (i=1; i<=NF; i++) printf"<%s> ", $i; printf "\n"}'
            __draw_line
            return
        fi

        __show_process_list | __remove_ascii_escape_words | awk 'NR > 1 {print $0}' > ${_processes_log_file_name}
        while IFS= read -r line; do
            _full_log_list+=("$(echo -e "$line" | awk '{printf " %-8d :: ", $1; for (i=4; i<=NF; i++) printf "%s ", $i; printf "\n"}')")
        done <  ${_processes_log_file_name}
        sudo rm ${_processes_log_file_name}

        echo -e; __draw_line SELECT_KILL_PROCESS
        echo -e "     PID      || COMMAND"

        local _process_list=()
        for i in "${!_full_log_list[@]}"; do
            _process_list+=("${_full_log_list[$i]}")
        done

        __select_menu "${_process_list[@]}"
        local _ret_val=$?

        # check SIGINT
        if [[ $_ret_val -eq $EVENT_SIGINT ]]; then
            echo -e "${SET} You press '${cB_R}Ctrl+C${cRST}', script cancled."
            return $EVENT_SIGINT
        fi
        local _selected_process=$(echo ${_process_list[${_ret_val}]})

        _find_pid=$(echo $_selected_process | awk -F"::" '{print $1}')
        _find_str=$(echo $_selected_process | awk -F"::" '{print "\b"$2}')
    elif [[ $# -eq 1 ]]; then
        echo -en "${SET} Search Word : ${cYLW}${_find_str}${cRST}"
    fi

    local _kill_targets=$(__show_process_list | __remove_ascii_escape_words | grep $_find_pid | awk '{print $1}' | sort -u)
    local _kill_tgt_cnt=$(__show_process_list | __remove_ascii_escape_words | grep $_find_pid | awk '{print $1}' | sort -u | wc -l)

    if [[ $_kill_tgt_cnt -eq 0 ]]; then
        echo -e
        echo -e "${FIN} Total Found Targets : ${_kill_tgt_cnt}"
        return
    fi

    # Show kill process candidates
    echo -e
    __draw_line - PROCESS_CANDIDATES
    __show_process_list | __remove_ascii_escape_words | awk '{printf " %-8s :: ", $1; for (i=4; i<=NF; i++) printf "%s ", $i; printf "\n"}' | grep "$_find_pid"

    # check delete process exactly
    __draw_line -
    echo -en ${SET} "If you don't want kill Process, ${cSKY}Ctrl+C${cRST}\n"
    echo -en ${SET} "If you want above process list, press ${cSKY}Enter${cRST} => "

    # read confirm key
    read confirmDelete
    sudo kill -9 ${_kill_targets}

    # print Done
    echo -e ${FIN} "Kill All Process : ${cYLW}$_kill_tgt_cnt${cRST}"
}

function MGEN_run_bash_target_container() { # [docker bash] Run /bin/bash target container
    __select_docker_container $1
    if [[ $? -eq $EVENT_SIGINT ]]; then 
        return
    fi
    local _selected_container=${DEFAULT_DOCKER}

    echo -e ${SET} "Try exec bash, Docker '${_selected_container}'"
    sudo docker exec -it ${_selected_container} /bin/bash
}

function MGEN_run_ssh_target_container() { # [docker ssh] Run ssh target container
    __select_docker_container $1
    if [[ $? -eq $EVENT_SIGINT ]]; then 
        return
    fi
    local _selected_container=${DEFAULT_DOCKER}

    local _ssh_config_path="/etc/ssh/sshd_config"
    local _port_num="None"
    local _is_activated_port_num=$(sudo docker exec ${_selected_container} cat ${_ssh_config_path} | grep ^Port | wc -l )
    if [[ $_is_activated_port_num -gt 0 ]]; then
        _port_num=$(sudo docker exec ${_selected_container} cat ${_ssh_config_path} | grep ^Port | awk -F' ' '{print $2}')
    fi

    local _permit_root_login="False"
    local _is_activated_permit=$(sudo docker exec ${_selected_container} cat ${_ssh_config_path} | grep ^PermitRootLogin | wc -l )
    if [[ $_is_activated_permit -gt 0 ]]; then
        _permit_root_login="True"
    fi

    echo -en "${SET} Input Target SSH PORT ( Current : ${_port_num} ) => "
    read _target_port

    if [[ -n ${_target_port} ]]; then
        _port_num=$_target_port
    fi

    # check number
    if [[ ${_port_num} =~ ^[0-9]+$ ]]; then
        if [[ ${_port_num} -lt 100 ]]; then
            echo -e "${ERR} Port Number Must Upper than 100 ( Current : ${_port_num} )"
            return
        elif [[ ${_port_num} -ge 65536 ]]; then
            echo -e "${ERR} Port Number Must Lower than 65536 ( Current : ${_port_num} )"
            return
        fi
    fi

    # Change root passwd in docker container
    sudo docker exec -it ${_selected_container} sh -c "echo "root:${USER_PW}" | chpasswd"

    # Change ssh port
    if [[ $_is_activated_port_num -eq 0 ]]; then
        sudo docker exec ${_selected_container} sed -i "s/#Port 22/Port ${_port_num}/" ${_ssh_config_path}
    else
        sudo docker exec ${_selected_container} sed -i "/Port [0-9]\+/s/.*/Port ${_port_num}/" ${_ssh_config_path}
    fi

    # Change permit root login
    sudo docker exec ${_selected_container} sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' ${_ssh_config_path}

    __draw_line - SSH_CONNECT
    local _is_not_run=$(sudo docker exec ${_selected_container} service ssh status | grep "not running" | wc -l )
    if [[ $_is_not_run -eq 1 ]]; then
        sudo docker exec ${_selected_container} service ssh start
    else
        sudo docker exec ${_selected_container} service ssh restart
    fi

    __draw_line - CONNECT_INFO
    echo -e "${SET} Container : ${_selected_container}"
    echo -e "${SET} ID        : root"
    echo -e "${SET} PW        : ${USER_PW}"
    echo -e "${SET} PORT      : ${_port_num}"

    __draw_line - SSH_STATUS
    sudo docker exec ${_selected_container} service ssh status
    __draw_line
}

function MGEN_get_camera_list() { # [cam] get camera list each service
    local _BASE_XML_PATH="${HOME}/monitoring/setup/cameraConfig"
    local _UVES_XML_PATH="${_BASE_XML_PATH}/config555.xml"
    local _RAID_XML_PATH="${HOME}/compose_raid/setting/RAID/cam_list.xml"

    local _target_xml_path=
    # Check whether any of the target services are currently running
    if   [[ "$(__is_run_target_process UVES)" == "True" ]]; then
        _target_xml_path="${_UVES_XML_PATH}"
    elif [[ "$(__is_run_target_process RAID)" == "True" ]]; then
        _target_xml_path="${_RAID_XML_PATH}"
    # When no services are running
    else
        echo; __draw_line =
        echo -e " * Select Target Service"

        local _service_list=( "Origin(UVES)" "Renewal(RAID)" "Others" )

        __select_menu "${_service_list[@]}"
        local _ret_val=$?

        # check SIGINT
        if [[ $_ret_val -eq $EVENT_SIGINT ]]; then
            echo -e "${SET} You press '${cB_R}Ctrl+C${cRST}', script cancled."
            return $EVENT_SIGINT
        fi

        local _select_service=$(echo ${_service_list[${_ret_val}]})

        if   [[ "${_select_service}" == "Origin(UVES)" ]]; then
            _target_xml_path="${_UVES_XML_PATH}"
        elif [[ "${_select_service}" == "Renewal(RAID)" ]]; then
            _target_xml_path="${_RAID_XML_PATH}"
        else
            local _camera_config_xmls="${SCRIPT_DIR_NAME}/.camera_config_xmls.log"
            sudo ls ${_BASE_XML_PATH} -a | grep ".xml$" > ${_camera_config_xmls}

            local _config_list=()
            while read line; do
                _config_list+=("$(echo -e "$line")")
            done <  ${_camera_config_xmls}
            sudo rm ${_camera_config_xmls}

            __draw_line =
            echo -e "${SET} Search Path : ${_BASE_XML_PATH}"
            
            __select_menu "${_config_list[@]}"
            local _ret_val=$?

            # check SIGINT
            if [[ $_ret_val -eq $EVENT_SIGINT ]]; then
                echo -e "${SET} You press '${cB_R}Ctrl+C${cRST}', script cancled."
                return $EVENT_SIGINT
            fi

            _target_xml_path="${_BASE_XML_PATH}/${_config_list[${_ret_val}]}"
        fi
    fi

    # file exist check
    if [[ ! -f $_target_xml_path ]]; then
        echo -e ${ERR} "{ $_target_xml_path } is Not Exist File"
        return
    fi

    local _xml_line_list=($(cat ${_target_xml_path} | grep -n "suffix" | grep -v "pusher" | awk -F":" '{print $1}'))
    local _cam_count=1

    echo; __draw_line
    echo -e "| XML | ${_target_xml_path}"
    __draw_line
    echo -e "| IDX | CamID | URL"
    __draw_line
    for _each_cam in ${_xml_line_list[@]}; do
        local _cam=$(awk "NR==${_each_cam}" ${_target_xml_path} | awk -F">" '{print $2}' | awk -F"<" '{print $1}')
        local _uri_line=`expr ${_each_cam} + 1`
        local _uri=$(awk "NR==${_uri_line}" ${_target_xml_path} | awk -F">" '{print $2}' | awk -F"<" '{print $1}')

        printf "| %-3s | %5s | %-60s\n" $_cam_count $_cam $_uri
        _cam_count=`expr ${_cam_count} + 1`
    done
    __draw_line; echo
}

function MGEN_uni_check_program_memory() { # [mem] Check memory usage

    local _find_pid=
    local _find_str=

    # None input search word
    local _processes_log_file_name="${SCRIPT_DIR_NAME}/.current_process_list_for_mgen_script.log"
    local _full_log_list=()

    __show_process_list | __remove_ascii_escape_words | awk 'NR > 1 {print $0}' > ${_processes_log_file_name}
    while IFS= read -r line; do
        _full_log_list+=("$(echo $line | awk '{printf " %-8s :: ", $1; for (i=4; i<=NF; i++) printf "%s ", $i; printf "\n"}')")
    done <  $_processes_log_file_name
    sudo rm $_processes_log_file_name

    __draw_line
    echo -e "     PID      || COMMAND"

    local _process_list=()
    for i in "${!_full_log_list[@]}"; do
        _process_list+=("${_full_log_list[$i]}")
    done

    __select_menu "${_process_list[@]}"
    local _ret_val=$?

    # check SIGINT
    if [[ $_ret_val -eq $EVENT_SIGINT ]]; then
        echo -e "${SET} You press '${cB_R}Ctrl+C${cRST}', script cancled."
        return $EVENT_SIGINT
    fi
    local _selected_process=$(echo ${_process_list[${_ret_val}]})

    # Get PID selected process
    _find_pid="$(echo -en "$_selected_process" | awk -F"::" '{print $1}' | awk -F' ' '{print $1}')"
    _find_str="$(echo -en "$_selected_process" | awk -F"::" '{print "\b"$2}')"

    echo; __draw_line
    echo -e " MEMORY CHECK :: ${cSKY}${_find_str}${cRST}"
    __draw_line

    local _target="/proc/${_find_pid}/status"

    local _init_mem=$(cat ${_target} | grep VmRSS | awk -F":" '{print $2}' | awk -F" " '{print $1}')
    local _mem_unit=$(cat ${_target} | grep VmRSS | awk -F":" '{print $2}' | awk -F" " '{print $2}')
    local _hour_mem=${_init_mem}

    local _check_min=0
    local _total_min=0
    local _total_hrs=0
    local _curr_time=$(date '+%m-%d %H:%M')

    while [[ true ]]
    do
        _total_min=`expr $_total_min + 1`
        _check_min=`expr $_check_min + 1`
        _check_min=`expr $_check_min % 60`

        if [[ ! -f "${_target}" ]]; then
            echo; __draw_line '~' FILE_NOT_FIND
            echo -e "[ $(date '+%m-%d %H:%M') ] ${ERR} ${_find_str} ( ${_target} ) Is Terminated"
            __draw_line '~' FILE_NOT_FIND ; echo
            break
        fi

        # Each 1 Hour
        if [[ ${_check_min} -eq 0 ]]; then
            _total_hrs=`expr $_total_hrs + 1`
            __draw_line; echo
            echo; __draw_line
            echo -e " AFTER ${_total_hrs} HOURS"
            __draw_line
            _hour_mem=$(cat ${_target} | grep VmRSS | awk -F":" '{print $2}' | awk -F" " '{print $1}')
        fi

        _curr_time=$(date '+%m-%d %H:%M')
        local _curr_mem=$(cat ${_target} | grep VmRSS | awk -F":" '{print $2}' | awk -F" " '{print $1}')

        if [[ $? -gt 0 ]]; then
            echo -e "${ERR} Read Memory Failed. Check Memory Finished."
            return
        fi

        local _total_mem_subs=`expr $_curr_mem - $_init_mem`
        local _hours_mem_subs=`expr $_curr_mem - $_hour_mem`
        local _total_mem_avrg=`expr $_total_mem_subs / $_total_min`

        if [[ $? -gt 0 ]]; then
            echo -e "${ERR} Read Memory Failed. Check Memory Finished."
            return
        fi

        local _show_line=$(echo -e "[ ${_curr_time} ] ${_curr_mem} ${_mem_unit} < ${_total_mem_avrg} ${_mem_unit}/min >" )

        if [[ $_hours_mem_subs -lt 0 ]]
        then _show_line=$(echo -e "${_show_line} ( [1HR] ${_hours_mem_subs} ${_mem_unit}" )
        else _show_line=$(echo -e "${_show_line} ( [1HR] +${_hours_mem_subs} ${_mem_unit}" )
        fi
        if [[ $_total_mem_subs -lt 0 ]]
        then _show_line=$(echo -e "${_show_line} [TOT] ${_total_mem_subs} ${_mem_unit} )" )
        else _show_line=$(echo -e "${_show_line} [TOT] +${_total_mem_subs} ${_mem_unit} )" )
        fi

        echo -e ${_show_line}
        # Check each 60 seconds
        sleep 60
    done
}

function MGEN_update_script() { # [update] Update MgenScript

    echo -e "${RUN} MgenScript Update Start..."
    # remember current dirs
    local _cur_dir=$(pwd)

    # Download from github
    if __check_git_remote_url_reachable; then
        # Check directory
        if [[ ! -d "${SCRIPT_BASE_DIR}" ]]; then
            echo -e "${ERR} Update failed => \"${cSKY}${SCRIPT_BASE_DIR}${cRST}\" directory not exists"
            return
        fi
        # git pull 'MgenScript'
        echo -e "${TRY} Download MgenScript update files..."
        cd ${SCRIPT_BASE_DIR}

        sudo mv "${SCRIPT_BASE_DIR}/install_scripts.sh" "${SCRIPT_BASE_DIR}/.install.sh.backup"
        sudo git pull > /dev/null

        if [[ -e "${SCRIPT_BASE_DIR}/install_scripts.sh" ]]; then
            sudo rm "${SCRIPT_BASE_DIR}/.install.sh.backup"
        else
            sudo mv "${SCRIPT_BASE_DIR}/.install.sh.backup" "${SCRIPT_BASE_DIR}/install_scripts.sh"
        fi
    fi

    if __install_mgen_script; then
        echo -e "${FIN} Update Done"
    fi

    cd ${_cur_dir}
}

function MGEN_cd_using_fzf() { # [cd] cd command with fuzzing find
    if [[ ! -e "/usr/bin/fzf_mgen" ]]; then
        echo -e "${ERR} you use 'mgen cd' but 'fzf_mgen' not exists"
        return $ERROR_NO_FZF
    fi

    local _pre_dir=$(pwd)
    local _mov_dir=

    # Set search start directory
    if   [[ "$1" = "." ]];          then _mov_dir="${_pre_dir}"
    elif [[ -e "$1" ]];             then _mov_dir="$1"
    elif [[ -e "${_pre_dir}/$1" ]]; then _mov_dir="${_pre_dir}/$1"
    else                                 _mov_dir="${HOME}"
    fi

    # check target is directory
    if [[ ! -d $_mov_dir ]]; then
        _mov_dir=$(dirname ${_move_dir})
    fi

    # check permission change directory
    cd ${_mov_dir}
    if [[ $? -gt 0 ]]; then
        echo -e "${ERR} Change Directory to ${cYLW}${_mov_dir}${cRST} Failed..."
        cd ${_pre_dir}
        return
    fi
    echo -e "${SET} Search Start Point : ${cSKY}${_mov_dir}${cRST}"

    # Ignore SIGINT(ctrl + c)
    trap "" SIGINT
    local _select_file=$( fzf_mgen ${FZF_SETTINGS} \
                          --preview 'if file -b {} | grep -q text; then cat {}; else echo "Not a text file"; fi' \
                          --header "[ Preview Scroll Down : ctrl + space ]" )

    if [[ -n "${_select_file}" ]]; then
        cd $(dirname ${_select_file})
    else
        cd ${_pre_dir}
    fi
    # Restore SIGINT(ctrl + c)
    trap -- SIGINT
}

function MGEN_SCRIPT_TOOL() { # MgenSolutions Script Tool Management Function
    # Check passwd & set sudo permission
    __password_check && echo ${USER_PW} | sudo -S true

    # Run Tool
    if   [[ $# -eq 0 ]]; then
        MGEN_show_script_summary
    elif [[ $# -gt 0 ]]; then
        case $1 in

            .|stat|status)
                MGEN_show_current_status | more
                ;;

            kill)
                MGEN_check_n_kill $2
                ;;

            docker)
                if   [[ "$2" == "bash" ]]; then
                    MGEN_run_bash_target_container $3
                elif [[ "$2" == "ssh" ]]; then
                    MGEN_run_ssh_target_container $3
                else
                    MGEN_show_script_summary | more
                fi
                ;;

            cam)
                MGEN_get_camera_list
                ;;

            mem)
                MGEN_uni_check_program_memory
                ;;

            bash)
                MGEN_run_bash_target_container $2
                ;;

            ssh)
                MGEN_run_ssh_target_container $2
                ;;

            update)
                MGEN_update_script
                ;;

            cd)
                MGEN_cd_using_fzf $2
                ;;
        esac
    fi
}
alias mgen='MGEN_SCRIPT_TOOL'
alias uni='MGEN_SCRIPT_TOOL'
alias mg='MGEN_SCRIPT_TOOL'

# ================================================================ #
#                          Global Aliases                          #
# ================================================================ #

alias sc='f() { 
    source ~/.bashrc > /dev/null; echo -e "${FIN} Source ~/.bashrc Complete "; 
    }; f'

alias gl="gl() {
        __draw_line;
        sudo git log --color --pretty=format:'%<(2)%C(bold blue)[%>(16) %cr ]%C(reset) - %<(9)%s %C(bold green)/ %an %C(reset)'; 
        __draw_line;
    }; gl"

# ================================================================ #
#                               SET                                #
# ================================================================ #
stty -ixon # Prevent Screen Pause by 'Ctrl + S'

function _login_prompt() { #
    __draw_line = MAIN_STORAGE
    local _cmd_out=$(df -h | awk '{printf "%-14s %-8s %-8s %-8s %-8s ", $1, $2, $3, $4, $5; for (i=6; i<=NF; i++) printf "%s ", $i; printf "\n"}')
    echo -e "   ${cB_B}${_cmd_out}" | head -1 && echo -en "${cRST}"
    echo -e "   ${_cmd_out}" | sort -rh -k3 | grep [0-9][GT] | grep -v "grep" | head -1 | awk -F"#" '{print "   " $1}'

    __draw_line - PROCESS
    __show_process_list
    __draw_line =
}; _login_prompt