#!/usr/bin/env bash

# Copyright (C) 2016-2019 Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# # Colors for man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'


function colors_ls() {
    local style=$1
    for COLOR in {0..255}
    do
        for STYLE in $style
        do
            TAG="\033[${STYLE};${COLOR}m"
            STR="${STYLE};${COLOR}"
            echo -ne "${TAG}${STR}${NONE}  "
        done
        echo
    done
}

function colors_foreground_ls() {
    local FOREGROUND_STYLE="38;5"
    colors_ls $FOREGROUND_STYLE
}

function colors_background_ls() {
    local BACKGROUND_STYLE="48;5"
    colors_ls $BACKGROUND_STYLE
}

