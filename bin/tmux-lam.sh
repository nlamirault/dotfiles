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

SESSION="lam"

if [ -f "${HOME}/.config/shrc.d/path.shrc" ]; then
    # shellcheck source=/dev/null
    . "${HOME}/.config/shrc.d/path.shrc"
fi

PROJECTS=${HOME}/Projects

function tmux_lam {
    tmux start-server
    tmux new-session -s $SESSION -n Lam -d
    tmux new-window -n "Journal"
    tmux send-keys -t $SESSION "cd ${HOME}" C-m
    tmux new-window -n "Dotfiles"
    tmux send-keys -t $SESSION "cd ${PROJECTS}/dotfiles" C-m
    tmux new-window -n "Divona"
    tmux send-keys -t $SESSION "cd ${PROJECTS}/divona" C-m
    tmux new-window -n "Network"
    tmux send-keys -t $SESSION "cd ${HOME}" C-m
    tmux attach-session -t $SESSION
}

tmux_lam
