# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"
# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
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
#
# SPDX-License-Identifier: Apache-2.0

# Usage:
# set -e
# set -x
# set -v

if [ -d "${HOME}/.config/shrc.d" ]; then
  for file in $(/bin/ls ${HOME}/.config/shrc.d/*.shrc); do
    # echo ${file}
    # shellcheck source=/dev/null
    . ${file}
  done
fi

if [ -d "${HOME}/.config/shells_vendor" ]; then
  for file in $(/bin/ls "${HOME}"/.config/shells_vendor/*.sh); do
    # echo ${file}
    # shellcheck source=/dev/null
    [ -r "${file}" ] && . "${file}"
  done
fi

if [ -d "${HOME}/.config/zshrc.d" ]; then
  for file in $(/bin/ls ${HOME}/.config/zshrc.d/*.zshrc); do
    # echo "${file}"
    # shellcheck source=/dev/null
    . ${file}
  done
fi

if [ -d "${HOME}/.config/work.d" ]; then
  for file in $(/bin/ls ${HOME}/.config/work.d/*.sh); do
    # echo "${file}"
    # shellcheck source=/dev/null
    . ${file}
  done
fi

# Load local configuration
[ -f ${HOME}/.local.zshrc ] && . ${HOME}/.local.zshrc

# Load secret or personal configuration (PERSONAL_DIR loaded from path.shrc)
if [ -d "${PERSONAL_DIR}/zshrc.d" ]; then
  for file in $(/bin/ls ${PERSONAL_DIR}/zshrc.d/*.zshrc); do
    echo ${file}
    # shellcheck source=/dev/null
    [ -r "${file}" ] && . "${file}"
  done
fi

# https://www.freedesktop.org/wiki/Software/xdg-user-dirs/
[ -f ${XDG_CONFIG_HOME}/user-dirs.dirs ] && source ${XDG_CONFIG_HOME}/user-dirs.dirs

# if [ -e "${HOME}/.asdf/asdf.sh" ]; then
#   source ${HOME}/.asdf/asdf.sh
#   fpath=(${HOME}/.asdf/completions $fpath)
# elif [ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]; then
#     source /opt/homebrew/opt/asdf/libexec/asdf.sh
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -f "${HOME}/.rustrc" ]] && source "${HOME}/.rustrc"

if [[ "$-" == *x* ]]; then
  echo "DEBUG MODE is ON ========================== Zsh setup finished."
fi


if [ -d "${HOME}/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/nicolas.lamirault/.opam/opam-init/init.zsh' ]] || source '/Users/nicolas.lamirault/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"

# Added by Antigravity
export PATH="/Users/nicolas.lamirault/.antigravity/antigravity/bin:$PATH"

eval "$(~/.local/bin/mise activate zsh)"
