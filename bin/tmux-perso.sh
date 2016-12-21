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

GO_PRJ="${HOME}/Apps/golang/src/github.com/"

SESSION="perso"

function tmux_perso {
    tmux start-server
    tmux new-session -s $SESSION -n Lam -d
    tmux new-window -n "Config"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/dotfiles/" C-m
    tmux new-window -n "nlamirault"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/nlamirault.github.io/" C-m
    tmux new-window -n "Divona"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/divona/" C-m
    tmux new-window -n "Scame"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/scame/" C-m
    tmux new-window -n "Vision"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/vision" C-m
    tmux new-window -n "Blinky"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/blinky" C-m
    tmux new-window -n "Tchoupi"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/tchoupi" C-m
    tmux new-window -n "gotest.el"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/gotest.el" C-m
    tmux new-window -n "phpunit.el"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/phpunit.el" C-m
    tmux new-window -n "Marcopolo"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/marcopolo" C-m
    tmux new-window -n "Dionysos"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/dionysos" C-m
    tmux new-window -n "E-Gitlab"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/emacs-gitlab" C-m
    tmux new-window -n "E-Travis"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/emacs-travis" C-m
    tmux new-window -n "Enigma"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/enigma" C-m
    tmux new-window -n "Aneto"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/aneto" C-m
    tmux new-window -n "Guzuta"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/guzuta" C-m
    tmux new-window -n "Abraracourcix"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/abraracourcix" C-m
    tmux new-window -n "Geronimo"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/geronimo" C-m
    tmux new-window -n "Iris"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/iris" C-m
    tmux new-window -n "Shiva"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/shiva" C-m
    tmux new-window -n "Skybox"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/skybox" C-m
    tmux new-window -n "Actarus"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/actarus" C-m
    tmux new-window -n "Muk"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/muk" C-m
    tmux new-window -n "Bento"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/bento" C-m
    tmux new-window -n "sift.el"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/sift.el" C-m
    tmux new-window -n "ripgrep.el"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/ripgrep.el" C-m
    tmux new-window -n "socyl"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/socyl" C-m
    tmux new-window -n "timonier"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/timonier" C-m
    tmux new-window -n "opensource.el"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/opensource.el" C-m
    tmux new-window -n "emacs-markdownfmt"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/emacs-markdownfmt" C-m
    tmux new-window -n "Julius"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/julius" C-m
    tmux new-window -n "decks"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/decks" C-m
    tmux new-window -n "Mert"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/mert" C-m
    tmux new-window -n "Happy"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/happy" C-m
    tmux new-window -n "Helmsman"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/helmsman" C-m
    tmux new-window -n "k8s-bot"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/nlamirault/k8s-bot" C-m
    tmux new-window -n "Framboise"
    tmux send-keys -t $SESSION "cd ${HOME}/Perso/framboise" C-m
    tmux new-window -n "kodi_exporter"
    tmux send-keys -t $SESSION " cd ${GO_PRJ}/nlamirault/kodi_exporter" C-m
    tmux new-window -n "pihole_exporter"
    tmux send-keys -t $SESSION " cd ${GO_PRJ}/nlamirault/pihole_exporter" C-m
    tmux new-window -n "syno_exporter"
    tmux send-keys -t $SESSION " cd ${GO_PRJ}/nlamirault/syno_exporter" C-m
    tmux new-window -n "domoticz_exporter"
    tmux send-keys -t $SESSION " cd ${GO_PRJ}/nlamirault/domoticz_exporter" C-m
    tmux new-window -n "speedtest_exporter"
    tmux send-keys -t $SESSION " cd ${GO_PRJ}/nlamirault/speedtest_exporter" C-m

    tmux attach-session -t $SESSION
}

tmux_perso
