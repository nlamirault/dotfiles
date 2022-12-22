#!/usr/bin/env bats

os="$(uname -s)"
case "${os}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${os}"
esac

@test "Share directories" {
  run ls ${HOME}/.local/share/backgrounds
  [ "$status" -eq 0 ]

  run ls ${HOME}/.local/share/man
  [ "$status" -eq 0 ]

  run ls ${HOME}/.local/share/icons
  [ "$status" -eq 0 ]
}

@test "Configurations" {
  run ls ${HOME}/.config/user-dirs.dirs
  [ "$status" -eq 0 ]

  run ls ${HOME}/.config/user-dirs.locale
  [ "$status" -eq 0 ]

  run ls ${HOME}/.config/mimeapps.list
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/autostart
  [ "$status" -eq 0 ]

  run ls ${HOME}/.config/starship.toml
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/i3
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/conky
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/rofi
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/dunst
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/polybar
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/sway
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/i3status-rs
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/tmux
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/alacritty
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/termite
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/kitty
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/wal
  [ "$status" -eq 0 ]

  run test -d ${HOME}/.config/zellij
  [ "$status" -eq 0 ]

  if [ "${machine}" == "Mac" ]; then
    run test -d ${HOME}/.config/yabai
    [ "$status" -eq 0 ]
  fi

  run test -d ${HOME}/.config/Code
  [ "$status" -eq 0 ]
}