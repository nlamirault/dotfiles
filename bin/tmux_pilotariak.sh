#!/bin/bash

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

GO_PRJ="$HOME/Apps/golang/src/github.com/pilotariak"

SESSION="pilotariak"

function tmux_pilotariak {
    tmux start-server
    tmux new-session -s $SESSION -n Pilotariak -d
    tmux new-window -n "Trinquet"
    tmux send-keys -t $SESSION "cd {GO_PRJ}/trinquet" C-m
    tmux new-window -n "Paleta"
    tmux send-keys -t $SESSION "cd {GO_PRJ}/paleta" C-m
    tmux new-window -n "pilotariak-webapp"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Pilotariak/pilotariak-webapp" C-m
    tmux attach-session -t $SESSION
}

tmux_pilotariak
