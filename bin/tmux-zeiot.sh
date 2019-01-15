#!/bin/bash

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
#

GO_PRJ="$HOME/Apps/golang/src/github.com/zeiot"

SESSION="zeiot"

function tmux_zeiot {
    tmux start-server
    tmux new-session -s $SESSION -n Zeiot -d
    tmux new-window -n "Jarvis"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/jarvis" C-m
    tmux new-window -n "rpi-prometheus"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-prometheus" C-m
    tmux new-window -n "rpi-alertmanager"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-alertmanager" C-m
    tmux new-window -n "rpi-grafana"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-grafana" C-m
    tmux new-window -n "rpi-node_exporter"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-node_exporter" C-m
    tmux new-window -n "rpi-influxdb"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-influxdb" C-m
    tmux new-window -n "rpi-coredns"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-coredns" C-m
    tmux new-window -n "rpi-vault"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-vault" C-m
    tmux attach-session -t $SESSION
}

tmux_zeiot
