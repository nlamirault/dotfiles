#!/usr/bin/env zsh

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

zstyle ':completion:*' completer _complete _ignored _prefix
zstyle ':completion:*' expand prefix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=1
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/'"${USER}"'/.zshrc.d/completion.zshrc'

[ -r "${HOME}"/.fzf.zsh ] && . "${HOME}"/.fzf.zsh

K8S_BINARIES=("kubectl")
# for BIN in "${K8S_BINARIES[@]}"; do
#   echo ${BIN}
#   command "${BIN}"
#   if command "${BIN}" > /dev/null 2>&1; then
#     # shellcheck source=/dev/null
#     # source <("${BIN}" completion zsh)
#     kubectl completion zsh > "${HOME}/.local/share/zsh/site-functions/_${BIN}"
#   fi
# done

if [ -f "${HOME}/.asdf/shims/kubectl" ]; then
  ${HOME}/.asdf/shims/kubectl completion zsh > "${HOME}/.local/share/zsh/site-functions/_kubectl"
fi

if [ -f "${HOME}/Applications/google-cloud-sdk/completion.zsh.inc" ]; then
    source ${HOME}/Applications/google-cloud-sdk/completion.zsh.inc
fi

if [ -f "${HOME}/Applications/aws-cli/venv/bin/activate" ]; then
    source ${HOME}/Applications/aws-cli/venv/bin/activate
    source aws_zsh_completer.sh
    deactivate
fi

if [ -f "${HOME}/Applications/azure-cli/venv/bin/activate" ]; then
    source ${HOME}/Applications/azure-cli/venv/bin/activate
    source az.completion.sh
    deactivate
fi

fpath=("${HOME}/.local/share/zsh/site-functions" $fpath)

if command "gh" > /dev/null 2>&1; then
  gh completion -s zsh > "${HOME}/.local/share/zsh/site-functions/_gh"
fi

if command "glab" > /dev/null 2>&1; then
  glab completion -s zsh > "${HOME}/.local/share/zsh/site-functions/_glab"
fi



autoload -Uz compinit
compinit