#!/usr/bin/env sh

. "${HOME}/.config/sketchybar/env.sh"

ICON="${ICON_CLOCK}"
LABEL=$(date '+%H:%M:%S')

sketchybar --set "${NAME}" icon="${ICON}" label="${LABEL}"