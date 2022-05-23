#!/bin/bash

# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
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

ZELLIJ_LAYOUTS="${HOME}/.config/zellij"

function zellij_layout() {
    local choice=$1

    local layout="${ZELLIJ_LAYOUTS}/${choice}.yaml"
    if [ -f "${layout}" ]; then
        zellij -l "${layout}"
    else
        echo "Zellij layout not found: ${layout}"
    fi
}

zellij=$1
[ -z "${zellij}" ] && echo "Zellij layout satisfied" && exit 1
zellij_layout "${zellij}"
