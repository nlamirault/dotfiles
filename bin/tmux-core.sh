#!/bin/bash

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# SPDX-License-Identifier: Apache-2.0

SESSION="core"

if [ -f "${HOME}/.config/shrc.d/path.shrc" ]; then
    # shellcheck source=/dev/null
    . "${HOME}/.config/shrc.d/path.shrc"
fi

PROJECTS=${HOME}/Projects

function tmux_core {
    tmux start-server
    tmux new-session -s $SESSION -n Core -d

    tmux new-window -n "Home"
    tmux send-keys -t $SESSION "cd ${HOME}" C-m
    tmux new-window -n "Dotfiles"
    tmux send-keys -t $SESSION "cd ${PROJECTS}/dotfiles" C-m
    tmux new-window -n "Agentic"
    tmux send-keys -t $SESSION "cd ${PROJECTS}/divona" C-m
    tmux new-window -n "Divona"
    tmux send-keys -t $SESSION "cd ${HOME}" C-m
    tmux new-window -n "Portefaix-k8s"
    tmux send-keys -t $SESSION "cd ${HOME}" C-m
    tmux new-window -n "Portefaix-Infra"
    tmux send-keys -t $SESSION "cd ${HOME}" C-m
    tmux new-window -n "Portefaix-Hub"
    tmux send-keys -t $SESSION "cd ${HOME}" C-m
    tmux new-window -n "Portefaix-Krm"
    tmux send-keys -t $SESSION "cd ${HOME}" C-m
    tmux new-window -n "Portefaix-Misc"
    tmux send-keys -t $SESSION "cd ${HOME}" C-m

    tmux attach-session -t $SESSION
}

tmux_core
