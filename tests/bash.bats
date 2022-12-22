#!/usr/bin/env bats

@test "bashrc file" {
  run ls ${HOME}/.bashrc
  [ "$status" -eq 0 ]

  run ls ${HOME}/.bash_profile
  [ "$status" -eq 0 ]
}

@test "bashrc configurations" {
  run test -d ${HOME}/.config/bashrc.d
  [ "$status" -eq 0 ]
}