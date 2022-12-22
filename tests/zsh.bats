#!/usr/bin/env bats

@test "zshrc file" {
  run ls ${HOME}/.zshrc
  [ "$status" -eq 0 ]

  run ls ${HOME}/.zprofile
  [ "$status" -eq 0 ]
}

@test "Zsh configurations" {
  run test -d ${HOME}/.config/zshrc.d
  [ "$status" -eq 0 ]
}