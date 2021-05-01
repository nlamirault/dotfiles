#!/usr/bin/env bash

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

# Usage:
# set -x			# activate debugging from here
# w
# set +x			# stop debugging from here

# set -e
# set -x
# set -v

if [ -d "${HOME}/.config/shells_vendor" ]; then
    for file in $(/bin/ls "${HOME}"/.config/shells_vendor/*.sh); do
        # echo ${file}
        # shellcheck source=/dev/null
        [ -r "${file}" ] && . "${file}";
    done
fi

if [ -d "${HOME}/.config/bashrc.d" ]; then
    for file in $(/bin/ls "${HOME}"/.config/bashrc.d/*.bashrc); do
        # echo ${file}
        # shellcheck source=/dev/null
        [ -r "${file}" ] && . "${file}";
    done
fi

if [ -d "${HOME}/.config/shrc.d" ]; then
    for file in $(/bin/ls "${HOME}"/.config/shrc.d/*.shrc); do
        # echo ${file}
        # shellcheck source=/dev/null
        [ -r "${file}" ] && . "${file}";
    done
fi

# Load local configuration
# shellcheck source=/dev/null
[ -r "${HOME}"/.local.bashrc ] && . "${HOME}"/.local.bashrc

# Load secret or personal configuration (PERSONAL_DIR loaded from path.shrc)
if [ -d "${PERSONAL_DIR}"/bashrc.d ]; then
    for file in $(/bin/ls "${PERSONAL_DIR}"/bashrc.d/*.bashrc); do
        # echo ${file}
        # shellcheck source=/dev/null
        [ -r "${file}" ] && . "${file}";
    done
fi



if [[ "$-" == *x* ]]; then
  echo "DEBUG MODE is ON ========================== Bash setup finished."
fi

complete -C /home/nicolas/bin/aliyun aliyun
complete -C /usr/local/lib/kzenv/versions/3.5.0/kustomize kustomize

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# BEGIN ANSIBLE MANAGED BLOCK: asdf
if [ -e "$HOME/.asdf/asdf.sh" ]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
fi
# END ANSIBLE MANAGED BLOCK: asdf
