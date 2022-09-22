#!/usr/bin/env bash

DIR="${HOME}/.config/rofi"

rofi \
	-show drun \
	-modi run,drun,ssh,window \
	-no-lazy-grab \
	-scroll-method 0 \
	-drun-match-fields all \
	-drun-display-format "{name}" \
	-no-drun-show-actions \
	-terminal alacritty \
	-theme "${DIR}/themes/launcher.rasi"
	