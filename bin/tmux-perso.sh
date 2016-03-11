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

GO_PRJ="$HOME/Apps/golang/src/github.com/nlamirault"

SESSION="lam"

function tmux_lam {
    tmux start-server
    tmux new-session -s $SESSION -n Lam -d
    tmux new-window -n "Config"
    tmux send-keys -t $SESSION "cd $HOME/Perso/dotfiles/" C-m
    tmux new-window -n "Divona"
    tmux send-keys -t $SESSION "cd $HOME/Perso/divona/" C-m
    tmux new-window -n "Scame"
    tmux send-keys -t $SESSION "cd $HOME/Perso/scame/" C-m
    tmux new-window -n "Vision"
    tmux send-keys -t $SESSION "cd $HOME/Perso/vision" C-m
    tmux new-window -n "Blinky"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/blinky" C-m
    tmux new-window -n "Tchoupi"
    tmux send-keys -t $SESSION "cd $HOME/Perso/tchoupi" C-m
    tmux new-window -n "gotest.el"
    tmux send-keys -t $SESSION "cd $HOME/Perso/gotest.el" C-m
    tmux new-window -n "phpunit.el"
    tmux send-keys -t $SESSION "cd $HOME/Perso/phpunit.el" C-m
    tmux new-window -n "Marcopolo"
    tmux send-keys -t $SESSION "cd $HOME/Perso/marcopolo" C-m
    tmux new-window -n "Dionysos"
    tmux send-keys -t $SESSION "cd $HOME/Perso/dionysos" C-m
    tmux new-window -n "E-Gitlab"
    tmux send-keys -t $SESSION "cd $HOME/Perso/emacs-gitlab" C-m
    tmux new-window -n "E-Travis"
    tmux send-keys -t $SESSION "cd $HOME/Perso/emacs-travis" C-m
    tmux new-window -n "Enigma"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/enigma" C-m
    tmux new-window -n "Aneto"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/aneto" C-m
    tmux new-window -n "Guzuta"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/guzuta" C-m
    tmux new-window -n "Abraracourcix"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/abraracourcix" C-m
    tmux new-window -n "Geronimo"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/geronimo" C-m
    tmux new-window -n "Iris"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/iris" C-m
    tmux new-window -n "Shiva"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/shiva" C-m
    tmux new-window -n "Skybox"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/skybox" C-m
    tmux new-window -n "Actarus"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/actarus" C-m
    tmux new-window -n "Muk"
    tmux send-keys -t $SESSION "cd $HOME/Perso/muk" C-m
    tmux new-window -n "Bento"
    tmux send-keys -t $SESSION "cd $HOME/Perso/bento" C-m
    tmux new-window -n "sift.el"
    tmux send-keys -t $SESSION "cd $HOME/Perso/sift.el" C-m
    tmux new-window -n "decks"
    tmux send-keys -t $SESSION "cd $HOME/Perso/decks" C-m
    tmux new-window -n "Mert"
    tmux send-keys -t $SESSION "cd ${GO_PRJ}/mert" C-m

    tmux new-window -n "Framboise"
    tmux send-keys -t $SESSION "cd $HOME/Perso/Zeiot/framboise" C-m
    tmux new-window -n "Jarvis"
    tmux send-keys -t $SESSION "cd $HOME/Perso/Zeiot/jarvis" C-m
    tmux new-window -n "Arduino-examples"
    tmux send-keys -t $SESSION "cd $HOME/Perso/Zeiot/arduino-examples" C-m

	tmux attach-session -t $SESSION
}

tmux_lam
