#!/bin/bash


SESSION="lam"

function tmux_lam {
    tmux start-server
    tmux new-session -s $SESSION -n Lam -d
    tmux new-window -n "Config"
    tmux send-keys -t $SESSION "cd $HOME/Perso/lam-config/" C-m
    tmux new-window -n "Scame"
    tmux send-keys -t $SESSION "cd $HOME/Perso/scame/" C-m
    tmux new-window -n "Vision"
    tmux send-keys -t $SESSION "cd $HOME/Perso/vision" C-m
    tmux new-window -n "Blinky"
    tmux send-keys -t $SESSION "cd $HOME/Perso/blinky" C-m
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
    tmux send-keys -t $SESSION "cd $HOME/Perso/enigma" C-m
    tmux new-window -n "Aneto"
    tmux send-keys -t $SESSION "cd $HOME/Perso/aneto" C-m
    tmux new-window -n "Guzuta"
    tmux send-keys -t $SESSION "cd $HOME/Perso/guzuta" C-m
    tmux new-window -n "Abraracourcix"
    tmux send-keys -t $SESSION "cd $HOME/Perso/abraracourcix" C-m
    tmux new-window -n "Geronimo"
    tmux send-keys -t $SESSION "cd $HOME/Perso/geronimo" C-m
    tmux new-window -n "Iris"
    tmux send-keys -t $SESSION "cd $HOME/Perso/iris" C-m
    tmux new-window -n "Shiva"
    tmux send-keys -t $SESSION "cd $HOME/Perso/shiva" C-m
    tmux new-window -n "Skybox"
    tmux send-keys -t $SESSION "cd $HOME/Perso/skybox" C-m
    tmux new-window -n "Actarus"
    tmux send-keys -t $SESSION "cd $HOME/Perso/actarus" C-m
    tmux new-window -n "Muk"
    tmux send-keys -t $SESSION "cd $HOME/Perso/muk" C-m
    tmux new-window -n "Bento"
    tmux send-keys -t $SESSION "cd $HOME/Perso/bento" C-m
    tmux new-window -n "sift.el"
    tmux send-keys -t $SESSION "cd $HOME/Perso/sift.el" C-m
    tmux new-window -n "decks"
    tmux send-keys -t $SESSION "cd $HOME/Perso/decks" C-m
    tmux new-window -n "Framboise"
    tmux send-keys -t $SESSION "cd $HOME/Perso/framboise" C-m
    tmux new-window -n "Mert"
    tmux send-keys -t $SESSION "cd $HOME/Perso/mert" C-m

	tmux attach-session -t $SESSION
}

tmux_lam
