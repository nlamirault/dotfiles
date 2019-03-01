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

if [ -d ${HOME}/.config/zshrc.d ]; then
    for file in $(/bin/ls ${HOME}/.config/zshrc.d/*.zshrc); do
        . ${file};
    done
fi

if [ -d ${HOME}/.config/shrc.d ]; then
    for file in $(/bin/ls ${HOME}/.config/shrc.d/*.shrc); do
        . ${file};
    done
fi

# Load local configuration
[ -f ${HOME}/.local.zshrc ] && . ${HOME}/.local.zshrc

# Load secret or personal configuration (PERSONAL_DIR loaded from path.shrc)
if [ -d "${PERSONAL_DIR}/zshrc.d" ]; then
    for file in $(/bin/ls ${PERSONAL_DIR}/zshrc.d/*.zshrc); do
        # echo ${file}
        [ -r "${file}" ] && . "${file}";
    done
fi

