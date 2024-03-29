#!/usr/bin/env sh

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc

# UPDOWN=$(ifstat -i "utun3" -b 0.1 1 | tail -n1)
# DOWN=$(echo $UPDOWN | awk "{ print \$1 }" | cut -f1 -d ".")
# UP=$(echo $UPDOWN | awk "{ print \$2 }" | cut -f1 -d ".")

# DOWN_FORMAT=""
# if [ "$DOWN" -gt "999" ]; then
#   DOWN_FORMAT=$(echo $DOWN | awk '{ printf "%03.0f Mbps", $1 / 1000}')
# else
#   DOWN_FORMAT=$(echo $DOWN | awk '{ printf "%03.0f kbps", $1}')
# fi

# UP_FORMAT=""
# if [ "$UP" -gt "999" ]; then
#   UP_FORMAT=$(echo $UP | awk '{ printf "%03.0f Mbps", $1 / 1000}')
# else
#   UP_FORMAT=$(echo $UP | awk '{ printf "%03.0f kbps", $1}')
# fi


airport=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)
AIRPORT=$(echo "$airport" | awk 'NR==1 {print $2}')
LABEL=$(echo "$airport" | grep -o "SSID: .*" | sed 's/^SSID: //')
UPDOWN=$(ifstat -i "en0" -b 0.1 1 | tail -n1)
DOWN=$(echo $UPDOWN | awk "{ print \$1 }" | cut -f1 -d ".")
UP=$(echo $UPDOWN | awk "{ print \$2 }" | cut -f1 -d ".")
DOWN_SPEED=$((DOWN/8))
UP_SPEED=$((UP/8))
SPEED=""

if [ "$AIRPORT" = "Off" ] || [ -z "$LABEL" ]; then
    sketchybar -m --set network_down icon.drawing=off
    sketchybar -m --set network_up icon.drawing=off
elif [ "$UP_SPEED" -gt "$DOWN_SPEED" ]; then
    # sketchybar -m --set network icon.drawing=on icon=$UPLOAD
    if [ "$UP_SPEED" -gt "999" ]; then
        SPEED=$(echo $UP_SPEED | awk '{ printf "%.1f MB/s", $1 / 1000}')
    else
        SPEED=$(echo $UP_SPEED | awk '{ printf "%.1f KB/s", $1}')
    fi
else
    # sketchybar -m --set network icon.drawing=on icon=$DOWNLOAD
    if [ "$DOWN_SPEED" -gt "999" ]; then
        SPEED=$(echo $DOWN_SPEED | awk '{ printf "%.1f MB/s", $1 / 1000}')
    else
        SPEED=$(echo $DOWN_SPEED | awk '{ printf "%.1f KB/s", $1}')
    fi
fi

# sketchybar -m --set network_speed label="$SPEED"
sketchybar -m \
    --set network_down label="$DOWN_FORMAT" icon.highlight=$(if [ "$DOWN" -gt "0" ]; then echo "on"; else echo "off"; fi) \
    --set network_up label="$UP_FORMAT" icon.highlight=$(if [ "$UP" -gt "0" ]; then echo "on"; else echo "off"; fi)
