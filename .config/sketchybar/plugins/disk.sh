#!/usr/bin/env bash

sketchybar -m --set "$NAME" label="$(df -lh | grep /dev/disk3s1s1 | awk '{ printf ("%02.0f\n", $5) }')%"