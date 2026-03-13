#!/bin/sh

bspc subscribe node_add node_state | while read _ _ _ wid; do
    name=$(xprop -id "$wid" _NET_WM_NAME 2>/dev/null | sed -n 's/.*= "\(.*\)"/\1/p')
    if [ "$name" = "quickshell" ]; then
        bspc node "$wid" -t floating -l above -g sticky=on
        xdo raise "$wid"
    fi
done
