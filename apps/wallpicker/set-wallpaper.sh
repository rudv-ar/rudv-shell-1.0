#!/bin/bash

bsp_wall_dir="SHOME/.config/bspwm/bspwm.d/sources"
bsp_wall_source="$HOME/.config/bspwm/bspwm.d/sources/wallpaper.sh"
cur_wall=$(cat "$bsp_wall_source" | perl -ne 'if ( /\$wall_dir\/([^"]*)/) { print "$1" }')

wallname=$(basename "$1")
feh --bg-fill "$1" && sed -i "s/$cur_wall/$wallname/g" "$bsp_wall_source"

