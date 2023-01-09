#!/usr/bin/env sh

. "${HOME}/.config/sketchybar/env.sh"

update() {
    ICON="${ICON_CALENDAR}"
    LABEL=$(date '+%a %-d %b')
    sketchybar --set "${NAME}" icon="${ICON}" label="${LABEL}"
}

add_hover() {
    sketchybar --animate linear 10 --set "${NAME}" background.border_color="${BAR_ACQUA}"
}

remove_hover() {
    sketchybar --animate linear 10 --set "${NAME}" background.border_color="${BAR_BACKGROUND}"
}

mouse_clicked() {
    open -a calendar
}

case "${SENDER}" in
  "mouse.clicked")
    mouse_clicked
    ;;
  "mouse.entered")
    add_hover
    ;;
  "mouse.exited")
    remove_hover
    ;;
  *)
    update
    ;;
esac