#!/usr/bin/env bash

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
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
# SPDX-License-Identifier: Apache-2.0

BASE_DIR=$(pwd)

function create_link() {
	local dir=$1

	test -L "${HOME}/${dir}" || ln -fs "${BASE_DIR}/${dir}" "${HOME}/${dir}"
}

function install_shell {
	create_link ".config/shrc.d"
	create_link ".bashrc"
	create_link ".bash_profile"
	create_link ".config/bashrc.d"
	create_link ".zshrc"
	create_link ".zprofile"
	create_link ".config/zshrc.d"
	create_link ".config/fish"
}

function install_binaries {
	mkdir -p "${HOME}/bin"
	create_link "/bin/tmux-lam.sh"
	create_link "/bin/tmux-perso.sh"
	create_link "/bin/tmux-zeiot.sh"
	create_link "/bin/tmux-pilotariak.sh"
	create_link "/bin/alacritty-perso.sh"
	create_link "/bin/zellij.sh"
	create_link "/bin/yk-reset.sh"
}

function install_share {
	mkdir -p "${HOME}/.config"
	create_link ".local/share/backgrounds"
	create_link ".local/share/man"
	create_link ".local/share/icons"
}

function install_apps {
	mkdir -p "${HOME}/.config"
	create_link ".gitconfig"
	create_link ".gtkrc-2.0"
	create_link ".htop"
	create_link ".editorconfig"
	create_link ".tmux.conf"
	create_link ".xinitrc"
	create_link ".config/user-dirs.dirs"
	create_link ".config/user-dirs.locale"
	create_link ".config/mimeapps.list"
	create_link ".config/autostart"
	create_link ".config/redshift"
	create_link ".config/starship.toml"
	create_link ".config/i3"
	create_link ".config/conky"
	create_link ".config/rofi"
	create_link ".config/dunst"
	create_link ".config/polybar"
	create_link ".config/sway"
	create_link ".config/i3status-rs"
	create_link ".config/tmux"
	create_link ".config/alacritty"
	create_link ".config/termite"
	create_link ".config/kitty"
	create_link ".config/wal"
	create_link ".config/zellij"
	create_link ".config/yabai"
	mkdir -p "${HOME}/.config/Code/User"
	create_link ".config/Code/User/settings.json"
	# create_link ""
	# create_link ""
}

function install_ssh {
	mkdir -p "${HOME}/.ssh"
	create_link ".ssh/config"
	create_link ".ssh/personal"
}

install_shell
install_binaries
install_ssh
install_share
install_apps


