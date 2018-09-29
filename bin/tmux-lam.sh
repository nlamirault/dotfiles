#!/bin/bash


SESSION="lam"

function tmux_lam {
    tmux start-server
    tmux new-session -s $SESSION -n lam -d
    tmux new-window -n "Config"
    tmux send-keys -t $SESSION "cd $HOME/lam/lam-config/" C-m
    tmux new-window -n "Journalctl"
    tmux send-keys -t $SESSION "cd $HOME" C-m
    tmux new-window -n "VPN"
    tmux send-keys -t $SESSION "cd $HOME" C-m
    tmux attach-session -t $SESSION
}

tmux_lam
