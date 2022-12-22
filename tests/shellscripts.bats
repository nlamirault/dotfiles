#!/usr/bin/env bats

@test "Personal shell script files" {
  run ls ${HOME}/bin/tmux-lam.sh
  [ "$status" -eq 0 ]

  run ls ${HOME}/bin/tmux-perso.sh
  [ "$status" -eq 0 ]

  run ls ${HOME}/bin/alacritty-perso.sh
  [ "$status" -eq 0 ]

  run ls ${HOME}/bin/zellij.sh
  [ "$status" -eq 0 ]

  run ls ${HOME}/bin/yk-reset.sh
  [ "$status" -eq 0 ]
}