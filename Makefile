# Copyright (C) 2016-2019 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

APP = dotfiles

SHELL = /bin/bash

SHELLCHECK = koalaman/shellcheck:stable

DIR = $(shell pwd)

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

MAKE_COLOR=\033[33;01m%-20s\033[0m

.DEFAULT_GOAL := help

BASE_DIR=$(shell echo `pwd`)

POLYBAR_FILE ?= config-theming

.PHONY: help
help:
	@echo -e "$(OK_COLOR)==== $(APP) ====$(NO_COLOR)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(MAKE_COLOR) : %s\n", $$1, $$2}'

.PHONY: debug
debug:
	@echo -e "$(OK_COLOR)Informations$(NO_COLOR)"
	@echo "Configuration source: ${BASE_DIR}"

install: install-fonts install-shell install-binaries install-apps ## Install all components

uninstall: uninstall-shell uninstall-binaries ## Uninstall all components

install-fonts:
	@echo -e "$(OK_COLOR)Install required fonts$(NO_COLOR)"
	yay -Sy nerd-fonts-complete

install-shell:
	@echo -e "$(OK_COLOR)Install Shell configurations$(NO_COLOR)"
	test -L ${HOME}/.config/shrc.d || ln -fs ${BASE_DIR}/.config/shrc.d/ ${HOME}/.config/shrc.d
	test -L ${HOME}/.bashrc || ln -fs ${BASE_DIR}/.bashrc ${HOME}/.bashrc
	test -L ${HOME}/.bash_profile || ln -fs ${BASE_DIR}/.bash_profile ${HOME}/.bash_profile
	test -L ${HOME}/.config/bashrc.d || ln -fs ${BASE_DIR}/.config/bashrc.d/ ${HOME}/.config/bashrc.d
	test -L ${HOME}/.zshrc || ln -fs ${BASE_DIR}/.zshrc ${HOME}/.zshrc
	test -L ${HOME}/.config/zshrc.d || ln -fs ${BASE_DIR}/.config/zshrc.d/ ${HOME}/.config/zshrc.d
	test -L ${HOME}/.config/fish || ln -fs ${BASE_DIR}/.config/fish ${HOME}/.config/fish

lint-shell:
	@echo -e "$(OK_COLOR)Lint Shell scripts$(NO_COLOR)"
	@echo ".bashrc"
	@docker run -v "$$PWD:/mnt" $(SHELLCHECK) /mnt/.bashrc
	@echo ".bash_profile"
	@docker run -v "$$PWD:/mnt" $(SHELLCHECK) /mnt/.bash_profile
	@for file in $(shell ls .config/bashrc.d/); do \
		echo $${file}; \
		docker run -v "$$PWD:/mnt" $(SHELLCHECK) /mnt/.config/bashrc.d/$${file}; done
	@for file in $(shell ls .config/shrc.d/); do \
		echo $${file}; \
		docker run -v "$$PWD:/mnt" $(SHELLCHECK) /mnt/.config/shrc.d/$${file}; done

install-binaries:
	mkdir -p ${HOME}/bin
	test -L ${HOME}/bin/tmux-lam.sh || ln -fs ${BASE_DIR}/bin/tmux-lam.sh ${HOME}/bin/tmux-lam.sh
	test -L ${HOME}/bin/tmux-perso.sh || ln -fs ${BASE_DIR}/bin/tmux-perso.sh ${HOME}/bin/tmux-perso.sh
	test -L ${HOME}/bin/tmux-zeiot.sh || ln -fs ${BASE_DIR}/bin/tmux-zeiot.sh ${HOME}/bin/tmux-zeiot.sh
	test -L ${HOME}/bin/tmux-pilotariak.sh || ln -fs ${BASE_DIR}/bin/tmux-pilotariak.sh ${HOME}/bin/tmux-pilotariak.sh

install-share:
	test -L ${HOME}/.local/share/backgrounds || ln -s ${BASE_DIR}/.local/share/backgrounds ${HOME}/.local/share/backgrounds
	test -L ${HOME}/.local/share/man|| ln -s ${BASE_DIR}/.local/share/man ${HOME}/.local/share/man

install-apps:
	test -L ${HOME}/.config/user-dirs.dirs || ln -s ${BASE_DIR}/.config/user-dirs.dirs ${HOME}/.config/user-dirs.dirs
	test -L ${HOME}/.config/user-dirs.locale || ln -s ${BASE_DIR}/.config/user-dirs.locale ${HOME}/.config/user-dirs.locale
	test -L ${HOME}/.xinitrc || ln -fs ${BASE_DIR}/.xinitrc ${HOME}/.xinitrc
	test -L ${HOME}/.gitconfig || ln -fs ${BASE_DIR}/.gitconfig ${HOME}/.gitconfig
	test -L ${HOME}/.config/i3 || ln -s ${BASE_DIR}/.config/i3 ${HOME}/.config/i3
	test -L ${HOME}/.config/conky || ln -s ${BASE_DIR}/.config/conky ${HOME}/.config/conky
	test -L ${HOME}/.config/rofi || ln -s ${BASE_DIR}/.config/rofi ${HOME}/.config/rofi
	test -L ${HOME}/.config/dunst || ln -s ${BASE_DIR}/.config/dunst ${HOME}/.config/dunst
	test -L ${HOME}/.config/polybar || ln -s ${BASE_DIR}/.config/polybar ${HOME}/.config/polybar
	rm -f ${HOME}/.config/polybar/config && \
		ln -s ${BASE_DIR}/.config/polybar/$(POLYBAR_FILE) ${HOME}/.config/polybar/config
	test -L ${HOME}/.config/sway || ln -s ${BASE_DIR}/.config/sway ${HOME}/.config/sway
	test -L ${HOME}/.config/i3status-rs || ln -s ${BASE_DIR}/.config/i3status-rs ${HOME}/.config/i3status-rs
	test -L ${HOME}/.config/tmux|| ln -s ${BASE_DIR}/.config/tmux ${HOME}/.config/tmux
	test -L ${HOME}/.tmux.conf|| ln -s ${BASE_DIR}/.config/tmux/tmux.conf ${HOME}/.tmux.conf
	test -L ${HOME}/.config/termite || ln -s ${BASE_DIR}/.config/termite ${HOME}/.config/termite
	test -L ${HOME}/.config/kitty || ln -s ${BASE_DIR}/.config/termite ${HOME}/.config/kitty
	test -L ${HOME}/.config/wal || ln -s ${BASE_DIR}/.config/wal ${HOME}/.config/wal

uninstall-shell:
	@echo -e "$(OK_COLOR)Install Shell configurations$(NO_COLOR)"
	@rm -f ${HOME}/.config/shrc.d
	@rm -f ${HOME}/.bashrc
	@rm -f ${HOME}/.bash_profile
	@rm -f ${HOME}/.config/bashrc.d
	@rm -f ${HOME}/.zshrc
	@rm -f ${HOME}/.config/zshrc.d
	@rm -f ${HOME}/.config/fish

uninstall-binaries:
	@rm -f ${HOME}/bin/tmux-lam.sh
	@rm -f ${HOME}/bin/tmux-perso.sh
	@rm -f ${HOME}/bin/tmux-zeiot.sh
	@rm -f ${HOME}/bin/tmux-pilotariak.sh

uninstall-apps:
	@rm -f ${HOME}/.gitconfig
	@rm -fr ${HOME}/.config/i3
	@rm -fr ${HOME}/.config/conky
	@rm -fr ${HOME}/.config/rofi
	@rm -fr ${HOME}/.config/polybar
	@rm -fr ${HOME}/.config/tmux
	@rm -fr ${HOME}/.config/termite
	@rm -fr ${HOME}/.config/kitty


