#!/bin/bash

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>

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
    tmux new-window -n "charts"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/charts" C-m
    tmux new-window -n "jarvis-bot"
    tmux send-keys -t $SESSION "cd {GO_PRJ}/jarvis-bot" C-m
    tmux new-window -n "rpi-helm"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-helm" C-m
    tmux new-window -n "rpi-prometheus"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-prometheus" C-m
    tmux new-window -n "rpi-alertmanager"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-alertmanager" C-m
    tmux new-window -n "rpi-grafana"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-grafana" C-m
    tmux new-window -n "rpi-node_exporter"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-node_exporter" C-m
    tmux new-window -n "rpi-snmp_exporter"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-snmp_exporter" C-m
    tmux new-window -n "rpi-domoticz"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-domoticz" C-m
    tmux new-window -n "rpi-pihole_exporter"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-pihole_exporter" C-m
    tmux new-window -n "rpi-speedtest_exporter"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/rpi-speedtest_exporter" C-m
    # tmux new-window -n "Arduino-examples"
    # tmux send-keys -t $SESSION "cd ${HOME}/Perso/Zeiot/arduino-examples" C-m
    tmux attach-session -t $SESSION
}

tmux_zeiot
