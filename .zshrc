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

if [ -d "${HOME}/.config/shrc.d" ]; then
    for file in $(/bin/ls ${HOME}/.config/shrc.d/*.shrc); do
        # shellcheck source=/dev/null
        . ${file};
    done
fi

if [ -d "${HOME}/.config/shells_vendor" ]; then
    for file in $(/bin/ls "${HOME}"/.config/shells_vendor/*.sh); do
        # echo ${file}
        # shellcheck source=/dev/null
        [ -r "${file}" ] && . "${file}";
    done
fi

if [ -d "${HOME}/.config/zshrc.d" ]; then
    for file in $(/bin/ls ${HOME}/.config/zshrc.d/*.zshrc); do
        # echo "${file}"
        # shellcheck source=/dev/null
        . ${file};
    done
fi

if [ -d "${HOME}/.config/work.d" ]; then
    for file in $(/bin/ls ${HOME}/.config/work.d/*.sh); do
        # echo "${file}"
        # shellcheck source=/dev/null
        . ${file};
    done
fi

# Load local configuration
[ -f ${HOME}/.local.zshrc ] && . ${HOME}/.local.zshrc

# Load secret or personal configuration (PERSONAL_DIR loaded from path.shrc)
if [ -d "${PERSONAL_DIR}/zshrc.d" ]; then
    for file in $(/bin/ls ${PERSONAL_DIR}/zshrc.d/*.zshrc); do
        # echo ${file}
        # shellcheck source=/dev/null
        [ -r "${file}" ] && . "${file}";
    done
fi

# https://www.freedesktop.org/wiki/Software/xdg-user-dirs/
[ -f ${XDG_CONFIG_HOME}/user-dirs.dirs ] && source ${XDG_CONFIG_HOME}/user-dirs.dirs

if [[ "$-" == *x* ]]; then
  echo "DEBUG MODE is ON ========================== Zsh setup finished."
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -F /home/nicolas/bin/aliyun aliyun
autoload -U +X bashcompinit && bashcompinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"

# BEGIN ANSIBLE MANAGED BLOCK: asdf
if [ -e "$HOME/.asdf/asdf.sh" ]; then
  source $HOME/.asdf/asdf.sh
  source $HOME/.asdf/completions/asdf.bash
fi
# END ANSIBLE MANAGED BLOCK: asdf

# Setup rustup, cargo path
[[ -f /home/nicolas/.rustrc ]] && source /home/nicolas/.rustrc

export PATH="$HOME/.poetry/bin:$PATH"
