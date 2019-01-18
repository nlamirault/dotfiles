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

DIR = $(shell pwd)

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

MAKE_COLOR=\033[33;01m%-20s\033[0m

.DEFAULT_GOAL := help

BASE_DIR=$(shell echo `pwd`)

.PHONY: help
help:
	@echo -e "$(OK_COLOR)==== $(APP) ====$(NO_COLOR)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(MAKE_COLOR) : %s\n", $$1, $$2}'

.PHONY: debug
debug:
	@echo -e "$(OK_COLOR)Informations$(NO_COLOR)"
	@echo "Configuration source: ${BASE_DIR}"

install: install-shell install-bin ## Install all components

install-shell:
	@echo -e "$(OK_COLOR)Install Shell configurations$(NO_COLOR)"
	test -L || ln -fs ${BASE_DIR}/.config/shrc.d/ ${HOME}/.config/shrc.d
	test -L || ln -fs ${BASE_DIR}/.bashrc ${HOME}/.bashrc
	test -L || ln -fs ${BASE_DIR}/.bash_profile ${HOME}/.bash_profile
	test -L || ln -fs ${BASE_DIR}/.config/bashrc.d/ ${HOME}/.config/bashrc.d
	test -L || ln -fs ${BASE_DIR}/.zshrc ${HOME}/.zshrc
	test -L || ln -fs ${BASE_DIR}/.config/zshrc.d/ ${HOME}/.config/zshrc.d

install-bin:
	mkdir -p ${HOME}/bin
	test -L || ln -fs ${BASE_DIR}/bin/tmux-lam.sh ${HOME}/bin/tmux-lam.sh
	test -L || ln -fs ${BASE_DIR}/bin/tmux-perso.sh ${HOME}/bin/tmux-perso.sh
	test -L || ln -fs ${BASE_DIR}/bin/tmux-zeiot.sh ${HOME}/bin/tmux-zeiot.sh
	test -L || ln -fs ${BASE_DIR}/bin/tmux-pilotariak.sh ${HOME}/bin/tmux-pilotariak.sh

install-apps:
	test -L || ln -fs ${BASE_DIR}/.gitconfig ${HOME}/.gitconfig
	test -L || ln -s ${BASE_DIR}/.config/i3 ${HOME}/.config/i3
	test -L || ln -s ${BASE_DIR}/.config/conky ${HOME}/.config/conky
	test -L || ln -s ${BASE_DIR}/.config/rofi ${HOME}/.config/rofi
	test -L || ln -s ${BASE_DIR}/.config/polybar ${HOME}/.config/polybar
	test -L || ln -s ${BASE_DIR}/.config/termite ${HOME}/.config/termite
	test -L || ln -s ${BASE_DIR}/.config/tmux ${HOME}/.config/tmux

