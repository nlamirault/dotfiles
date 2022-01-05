#!/usr/bin/env bash

# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

BASE_DIR=$(pwd)

function install_shell {
    test -L ${HOME}/.config/shrc.d || ln -fs ${BASE_DIR}/.config/shrc.d/ ${HOME}/.config/shrc.d
	test -L ${HOME}/.bashrc || ln -fs ${BASE_DIR}/.bashrc ${HOME}/.bashrc
	test -L ${HOME}/.bash_profile || ln -fs ${BASE_DIR}/.bash_profile ${HOME}/.bash_profile
	test -L ${HOME}/.config/bashrc.d || ln -fs ${BASE_DIR}/.config/bashrc.d/ ${HOME}/.config/bashrc.d
	test -L ${HOME}/.zshrc || ln -fs ${BASE_DIR}/.zshrc ${HOME}/.zshrc
	test -L ${HOME}/.zprofile || ln -fs ${BASE_DIR}/.zprofile ${HOME}/.zprofile
	test -L ${HOME}/.config/zshrc.d || ln -fs ${BASE_DIR}/.config/zshrc.d/ ${HOME}/.config/zshrc.d
	test -L ${HOME}/.config/fish || ln -fs ${BASE_DIR}/.config/fish ${HOME}/.config/fish
}

function install_binaries {
	mkdir -p ${HOME}/bin
	test -L ${HOME}/bin/tmux-lam.sh || ln -fs ${BASE_DIR}/bin/tmux-lam.sh ${HOME}/bin/tmux-lam.sh
	test -L ${HOME}/bin/tmux-perso.sh || ln -fs ${BASE_DIR}/bin/tmux-perso.sh ${HOME}/bin/tmux-perso.sh
	test -L ${HOME}/bin/tmux-zeiot.sh || ln -fs ${BASE_DIR}/bin/tmux-zeiot.sh ${HOME}/bin/tmux-zeiot.sh
	test -L ${HOME}/bin/tmux-pilotariak.sh || ln -fs ${BASE_DIR}/bin/tmux-pilotariak.sh ${HOME}/bin/tmux-pilotariak.sh
	test -L ${HOME}/bin/wifi-network.sh || ln -fs ${BASE_DIR}/bin/wifi-network.sh ${HOME}/bin/wifi-network.sh
}

function install_share {
	test -L ${HOME}/.local/share/backgrounds || ln -s ${BASE_DIR}/.local/share/backgrounds ${HOME}/.local/share/backgrounds
	test -L ${HOME}/.local/share/man || ln -s ${BASE_DIR}/.local/share/man ${HOME}/.local/share/man
	test -L ${HOME}/.local/share/icons || ln -s ${BASE_DIR}/.local/share/icons ${HOME}/.local/share/icons
}

function install_apps {
	test -L ${HOME}/.config/user-dirs.dirs || ln -s ${BASE_DIR}/.config/user-dirs.dirs ${HOME}/.config/user-dirs.dirs
	test -L ${HOME}/.config/user-dirs.locale || ln -s ${BASE_DIR}/.config/user-dirs.locale ${HOME}/.config/user-dirs.locale
	test -L ${HOME}/.config/mimeapps.list || ln -s ${BASE_DIR}/.config/mimeapps.list ${HOME}/.config/mimeapps.list
	test -L ${HOME}/.xinitrc || ln -fs ${BASE_DIR}/.xinitrc ${HOME}/.xinitrc
	test -L ${HOME}/.gitconfig || ln -fs ${BASE_DIR}/.gitconfig ${HOME}/.gitconfig
	test -L ${HOME}/.config/i3 || ln -s ${BASE_DIR}/.config/i3 ${HOME}/.config/i3
	test -L ${HOME}/.config/conky || ln -s ${BASE_DIR}/.config/conky ${HOME}/.config/conky
	test -L ${HOME}/.config/rofi || ln -s ${BASE_DIR}/.config/rofi ${HOME}/.config/rofi
	test -L ${HOME}/.config/dunst || ln -s ${BASE_DIR}/.config/dunst ${HOME}/.config/dunst
	test -L ${HOME}/.config/polybar || ln -s ${BASE_DIR}/.config/polybar ${HOME}/.config/polybar
	# rm -f ${HOME}/.config/polybar/config && \
	# 	ln -s ${BASE_DIR}/.config/polybar/$(POLYBAR_FILE) ${HOME}/.config/polybar/config
	test -L ${HOME}/.config/sway || ln -s ${BASE_DIR}/.config/sway ${HOME}/.config/sway
	test -L ${HOME}/.config/i3status-rs || ln -s ${BASE_DIR}/.config/i3status-rs ${HOME}/.config/i3status-rs
	test -L ${HOME}/.config/tmux|| ln -s ${BASE_DIR}/.config/tmux ${HOME}/.config/tmux
	test -L ${HOME}/.tmux.conf|| ln -s ${BASE_DIR}/.config/tmux/tmux.conf ${HOME}/.tmux.conf
	test -L ${HOME}/.config/termite || ln -s ${BASE_DIR}/.config/termite ${HOME}/.config/termite
	test -L ${HOME}/.config/kitty || ln -s ${BASE_DIR}/.config/termite ${HOME}/.config/kitty
	test -L ${HOME}/.config/wal || ln -s ${BASE_DIR}/.config/wal ${HOME}/.config/wal
	test -L ${HOME}/.gtkrc-2.0 || ln -s ${BASE_DIR}/.config/gtk/gtk2/.gtkrc-2.0 ${HOME}/.gtkrc-2.0
	test -L ${HOME}/.config/gtk-3.0/settings.ini || ${BASE_DIR}/.config/gtk/gtk3/settings.ini ${HOME}/.config/gtk-3.0/settings.ini
}

function install_ssh {
	mkdir -p ${HOME}/.ssh
	test -L ${HOME}/.ssh/config || ln -s ${BASE_DIR}/.ssh/config ${HOME}/.ssh/config
	test -L ${HOME}/.ssh/personal || ln -s ${BASE_DIR}/.ssh/personal ${HOME}/.ssh/personal
}

install_shell
install_binaries
install_apps
install_ssh