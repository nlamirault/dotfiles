#!/bin/sh

#
# Seulement l'écran du portable.
# BUG: A faire obligatoirement en 2 etapes
#

xrandr --output VGA-0 --mode 1920x1080 --pos 0x0 --rotate normal --output LVDS-0 --off --output HDMI-0 --off --output DP-3 --off --output DP-2 --off --output DP-1 --off --output DP-0 --off
sleep 1
xrandr --output VGA-0 --off --output LVDS-0 --mode 1600x900 --pos 0x0 --rotate normal --output HDMI-0 --off --output DP-3 --off --output DP-2 --off --output DP-1 --off --output DP-0 --off
