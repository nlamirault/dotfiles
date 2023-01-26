sketchybar  --add       item        battery     right                       \
            --set       battery     script="$PLUGIN_DIR/battery.sh"         \
                                    update_freq=5                           \
                                    label.font="$FONT:Light:20.0"           \
                                    icon.font="$FONT:Semibold:12.0"         \
                                    label.color=$WHITE                      \
                                    icon.color=$WHITE \
                                    icon.padding_right=4 \
                                    label.padding_right=10 \
                                    label.padding_left=5 \
            --subscribe battery     system_woke
