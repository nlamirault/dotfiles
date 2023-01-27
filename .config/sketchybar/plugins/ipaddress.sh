#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"

PUBLIC_IP=$(curl -s ifconfig.io)
PRIVATE_IP="192.168.1.10"

sketchybar -m \
  --set public_ip label=$PUBLIC_IP \
  --set private_ip label=$PRIVATE_IP
